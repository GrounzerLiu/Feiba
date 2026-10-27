/// High-level public entry point of the Tieba chat/IM subsystem.
///
/// Wraps the low-level APIs with the state machine aiotieba's `Client`
/// implements:
///
/// * [login] runs the LCP token request, BLCP connect, LCM handshake, optional
///   cloud-control login and the IM login (which fills the chat identity).
/// * [initWebSocket] connects the chat websocket and uploads the secret key.
/// * [getGroupMessages] / [sendMessage] / [markRead] drive private messages and
///   keep the message-id cursors up to date.
/// * [joinRoom] / [sendRoomMessage] / [fetchRoomMessages] / [fetchRooms] /
///   [fetchRoomDetail] cover forum chat rooms.
/// * [close] tears both transports down; the instance is single-use afterwards.
library;

import 'dart:async';
import 'dart:convert';

import '../core/account.dart';
import '../core/blcp/constants.dart';
import '../core/blcp/core.dart';
import '../core/blcp/enums.dart';
import '../core/blcp/packet.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../core/ws/core.dart';
import '../core/ws/enums.dart';
import '../models/chat_login.dart';
import '../models/chat_room.dart';
import '../models/chat_ws.dart';
import 'account_init.dart';
import 'chat_login.dart';
import 'chat_room.dart';
import 'chat_ws.dart';

Map<String, dynamic> _decodeJsonObject(String text) {
  if (text.isEmpty) return const <String, dynamic>{};
  try {
    final decoded = jsonDecode(text);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return decoded.cast<String, dynamic>();
  } on FormatException {
    // Not JSON: read receipts are the only structured messages we decode.
  }
  return const <String, dynamic>{};
}

/// Chat/IM client for one account.
class TiebaChatClient {
  TiebaChatClient({
    required this.http,
    BlcpConfig blcpConfig = const BlcpConfig(),
    WsConfig wsConfig = const WsConfig(),
    this.clientVersion = chatVersion,
  }) : blcp = BlcpCore(account: http.account, config: blcpConfig),
       ws = WsCore(
         account: http.account,
         clientVersion: clientVersion,
         config: wsConfig,
       );

  /// HTTP transport shared with the rest of the protocol layer.
  final TiebaHttpCore http;

  /// BLCP connection (control plane + IM session bus).
  final BlcpCore blcp;

  /// Chat websocket connection.
  final WsCore ws;

  /// Client version reported by the websocket initialization.
  final String clientVersion;

  final StreamController<WsNotify> _pushNotifies =
      StreamController<WsNotify>.broadcast();

  InitWsInfo? _wsInfo;
  Object? _cloudControlError;

  /// Account used by both transports.
  TiebaAccount get account => http.account;

  /// Current BLCP state.
  BlcpStatus get blcpStatus => blcp.status;

  /// Current websocket state.
  WsStatus get wsStatus => ws.status;

  /// Server pushes received on the BLCP connection.
  Stream<BlcpNotify> get blcpNotifications => blcp.notifications;

  /// Server pushes received on the chat websocket.
  Stream<WsNotify> get pushNotifications => _pushNotifies.stream;

  /// Last cloud-control login failure, if any.
  ///
  /// Cloud control is an optional configuration channel; [login] does not fail
  /// when it is rejected.
  Object? get cloudControlError => _cloudControlError;

  /// Runs the whole BLCP login sequence.
  ///
  /// Fills `account.uk`, `account.bduk` and `account.triggerId` from the IM
  /// login and starts the heartbeat timer.
  Future<LoginImResult> login({bool withCloudControl = true}) async {
    final token = await fetchLcmToken(http);

    if (!blcp.isOpen) {
      await blcp.connect();
    }

    final interval = await loginBlcpLcm(blcp, token);
    blcp.startHeartbeat(interval);

    _cloudControlError = null;
    if (withCloudControl) {
      try {
        await loginBlcpCloudCtrl(blcp);
      } on Object catch (error) {
        // Best effort: chat itself does not depend on the cloud config.
        _cloudControlError = error;
      }
    }

    final result = await loginBlcpIm(blcp);
    blcp.markLoggedIn();
    return result;
  }

  /// Connects the websocket and uploads the secret key.
  ///
  /// [full] uploads the complete device description and `STOKEN`; the light
  /// payload is the aiotieba default.
  Future<InitWsInfo> initWebSocket({bool full = false}) async {
    if (ws.status == WsStatus.open && _wsInfo != null) {
      return _wsInfo!;
    }
    await ws.connect();
    try {
      if (full) {
        final account = http.account;
        if (account.clientId.isEmpty || account.sampleId.isEmpty) {
          await fetchSync(http);
        }
        if ((account.zid ?? '').isEmpty) {
          await fetchInitZid(http);
        }
        if ((account.baiduId ?? '').isEmpty) {
          await fetchInitBaiduId(http);
        }
      }
      final info = await uploadWsSec(ws, full: full);
      _wsInfo = info;
      registerPushNotifyHandler(ws, (notifies) {
        for (final notify in notifies) {
          if (!_pushNotifies.isClosed) _pushNotifies.add(notify);
        }
      });
      return info;
    } on Object {
      await ws.close();
      rethrow;
    }
  }

  /// Pulls messages of [groupIds] and refreshes the private message cursors.
  ///
  /// Read receipts (`eventId == 22001`) update the peer read position.
  Future<WsMsgGroups> getGroupMessages(
    Iterable<int> groupIds, {
    int getType = 1,
  }) async {
    final groups = await getGroupMsg(ws, groupIds, getType: getType);
    final manager = ws.midManager;
    for (final group in groups) {
      if (group.groupType != WsGroupType.privateMessage.value) continue;
      for (final message in group.messages) {
        final userId = message.user.userId;
        if (userId == 0) continue;
        manager.updatePulledMsgId(userId, message.msgId);
        if (message.msgType != WsMsgType.readed.value) continue;
        final content = _decodeJsonObject(message.text);
        if (parseInt(content['eventId']) != 22001) continue;
        final eventParam = content['eventParam'];
        if (eventParam is Map) {
          manager.updateReadMsgId(userId, parseInt(eventParam['readMsgId']));
        }
      }
    }
    return groups;
  }

  /// Sends a private message and records the returned message ids.
  Future<SendMsgResult> sendMessage(int userId, String content) async {
    final result = await sendMsg(ws, userId, content);
    final manager = ws.midManager;
    final peer = result.toUid != 0 ? result.toUid : userId;
    manager.updateLocalMsgId(peer, result.localMsgId);
    if (result.groupId != 0 && result.toUserType == 0) {
      manager.privGid = result.groupId;
    }
    return result;
  }

  /// Reports [message] as read and records the read position.
  Future<SetMsgReadedResult> markRead(WsMessage message) async {
    final result = await setMsgReaded(ws, message);
    final manager = ws.midManager;
    final peer = result.toUid != 0 ? result.toUid : message.user.userId;
    if (result.readMsgId != 0) {
      manager.updateSentMsgId(peer, result.readMsgId);
    }
    if (result.groupId != 0 && result.toUserType == 0) {
      manager.privGid = result.groupId;
    }
    return result;
  }

  /// Joins the multicast channel of [chatroomId].
  Future<void> joinRoom(int chatroomId) => joinChatroom(blcp, chatroomId);

  /// Sends a text message to a chat room.
  Future<void> sendRoomMessage({
    required int chatroomId,
    required String text,
    required int fid,
    int level = 0,
    List<Map<String, dynamic>>? atdata,
    int robot = -1,
    ChatSenderProfile? sender,
  }) => sendChatroomMsg(
    blcp,
    chatroomId: chatroomId,
    text: text,
    fid: fid,
    level: level,
    atdata: atdata,
    robot: robot,
    sender: sender,
  );

  /// Fetches the latest messages of a chat room.
  Future<List<ChatroomMessage>> fetchRoomMessages(int chatroomId) =>
      fetchChatroomMsg(http, chatroomId);

  /// Fetches every chat room of forum [fid].
  Future<RoomList> fetchRooms(int fid) => fetchRoomListByFid(http, fid);

  /// Fetches the detail of one chat room.
  Future<ChatroomDetail> fetchRoomDetail(
    int chatroomId, {
    int lastMsgId = 0,
    int lastTime = 0,
  }) => fetchChatroomDetail(
    http,
    chatroomId,
    lastMsgId: lastMsgId,
    lastTime: lastTime,
  );

  /// Stops the heartbeat, closes both transports and the push stream.
  Future<void> close() async {
    await ws.close();
    await blcp.dispose();
    if (!_pushNotifies.isClosed) {
      await _pushNotifies.close();
    }
  }
}
