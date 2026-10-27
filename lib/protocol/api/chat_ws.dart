/// Websocket APIs of the chat/IM subsystem.
///
/// Ported from aiotieba's `upload_ws_sec`, `get_group_msg`, `send_msg`,
/// `set_msg_readed` and `push_notify` (Unlicense).
///
/// All requests that aiotieba sends with `pack_proto` are protobuf messages
/// carried inside a websocket frame; `upload_ws_sec` is the only one sent
/// without encryption (it delivers the key used by the other frames).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';

import '../core/account.dart';
import '../core/exceptions.dart';
import '../core/ws/core.dart';
import '../core/ws/enums.dart';
import '../core/ws/rsa.dart';
import '../generated/generated.dart' as pb;
import '../models/chat_ws.dart';

/// CMD of `upload_ws_sec`.
const int wsCmdUpdateClientInfo = 1001;

/// CMD of `get_group_msg`.
const int wsCmdGetGroupMsg = 202003;

/// CMD of `send_msg`.
const int wsCmdSendMsg = 205001;

/// CMD of `set_msg_readed`.
const int wsCmdSetMsgReaded = 205006;

/// CMD of `push_notify` (server push, no request is sent).
const int wsCmdPushNotify = 202006;

/// Client version written into the `cuid` of `get_group_msg`.
const String _miniClientVersion = '12.35.1.0';

Map<String, String> _packMinDevice(String clientVersion) => <String, String>{
  '_client_type': '2',
  '_client_version': clientVersion,
};

Map<String, dynamic> _packFullDevice(
  TiebaAccount account,
  String clientVersion,
) {
  final now = DateTime.now();
  final nowMs = now.millisecondsSinceEpoch;
  final date = now.toLocal();
  return <String, dynamic>{
    'model': 'PDEM10',
    'brand': 'Xiaomi',
    '_phone_imei': '000000000000000',
    '_os_version': '13',
    'android_id': account.androidId,
    'mac': '',
    '_client_type': '2',
    '_client_version': clientVersion,
    'user_agent':
        'Mozilla/5.0 (Linux; Android 13; PDEM10 Build/TKQ1.221114.001; wv) '
        'AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 '
        'Chrome/114.0.5735.196 Mobile Safari/537.36 '
        'tieba/$clientVersion',
    '_client_id': account.clientId,
    'net_type': '1',
    'net': '1',
    'cuid': account.cuidGalaxy2,
    'cuid_galaxy2': account.cuidGalaxy2,
    'c3_aid': account.c3Aid,
    'cuid_gid': '',
    'timestamp': '$nowMs',
    'sample_id': account.sampleId,
    'z_id': account.zid,
    'baiduid': account.baiduId,
    'sdk_ver': '3.36.0',
    'framework_ver': '',
    'naws_game_ver': '',
    '_phone_screen': '1080,2340',
    '_msg_status': '0',
    '_pic_quality': '0',
    'pversion': '1.0.3',
    'q_type': '0',
    'scr_h': '2340',
    'scr_w': '1080',
    'scr_dip': '2.75',
    'active_timestamp': '$nowMs',
    'first_install_time': '${nowMs - 86400000}',
    'update_time': '${nowMs - 3600000}',
    'event_day': '${date.year}${date.month}${date.day}',
    'cmode': '1',
    'extra': '',
    'personalized_rec_switch': '1',
    'ad_context': '',
    'start_type': '99',
    'start_scheme': '',
  };
}

Uint8List _buildUploadWsSecProto(
  TiebaAccount account,
  String clientVersion, {
  required bool full,
}) {
  final request = pb.UpdateClientInfoReqIdl();
  final device = full
      ? _packFullDevice(account, clientVersion)
      : _packMinDevice(clientVersion);
  final requestData = request.ensureData()
    ..bduss = account.bduss
    ..device = jsonEncode(device)
    ..secretKey = encryptWsSecKey(account.wsSecKey);
  if (full) {
    requestData.stoken = account.stoken;
  }
  request.cuid = full
      ? '${account.cuid}|com.baidu.tieba$clientVersion'
      : '-|com.baidu.tieba$clientVersion';
  return request.writeToBuffer();
}

/// Parses an `upload_ws_sec` response.
///
/// Throws [TiebaServerException] on a server error and
/// [TiebaValueException] when the account is not usable.
InitWsInfo parseUploadWsSecResponse(Uint8List body) {
  final proto = pb.UpdateClientInfoResIdl.fromBuffer(body);
  final code = proto.error.errorno;
  if (code != 0) {
    throw TiebaServerException(code, proto.error.errmsg);
  }
  final data = proto.data;
  final userId = data.userInfo.userId.toInt();
  final userAvailable = data.isUserAvailable.toInt();
  if (userId == 0 || userAvailable != userId) {
    throw TiebaValueException(
      'isUserAvailable($userAvailable) userId($userId)',
    );
  }
  return InitWsInfo.fromProto(proto);
}

/// Initializes the websocket session (`upload_ws_sec`).
///
/// Uploads the `ws_sec_key` encrypted with Baidu's RSA key together with the
/// device description, then records the message groups and marks the
/// connection as open.
///
/// When [full] is true the full device payload and `STOKEN` are uploaded as
/// well; aiotieba only does that after the zid/sample-id helpers ran, so the
/// light payload is the default here.
Future<InitWsInfo> uploadWsSec(WsCore ws, {bool full = false}) async {
  final data = _buildUploadWsSecProto(ws.account, ws.clientVersion, full: full);
  final response = await ws.send(
    data,
    wsCmdUpdateClientInfo,
    compress: false,
    encrypt: false,
  );
  final info = parseUploadWsSecResponse(await response.read());

  final manager = ws.midManager;
  for (final group in info.groups) {
    if (group.groupType == WsGroupType.privateMessage.value) {
      manager.privGid = group.groupId;
    }
    manager.updateMsgId(group.groupId, group.lastMsgId);
  }

  final user = info.user;
  if (user.userId != 0) {
    ws.account.userId = user.userId;
  }
  if (user.userName.isNotEmpty) {
    ws.account.userName = user.userName;
  }
  if (user.portrait.isNotEmpty) {
    ws.account.portrait = user.portrait;
  }

  ws.markOpen();
  return info;
}

/// Requests messages of one or more message groups.
///
/// [getType] defaults to 1 (incremental pull), matching aiotieba's client.
Future<WsMsgGroups> getGroupMsg(
  WsCore ws,
  Iterable<int> groupIds, {
  int getType = 1,
}) async {
  final request = pb.GetGroupMsgReqIdl();
  final requestData = request.ensureData();
  for (final groupId in groupIds) {
    requestData.groupMids.add(
      pb.GetGroupMsgReqIdl_DataReq_GroupLastId()
        ..groupId = Int64(groupId)
        ..lastMsgId = Int64(ws.midManager.getMsgId(groupId)),
    );
  }
  requestData.gettype = '$getType';
  request.cuid = '${ws.account.cuid}|com.baidu.tieba_mini$_miniClientVersion';

  final response = await ws.send(request.writeToBuffer(), wsCmdGetGroupMsg);
  return parseGroupMsgResponse(await response.read());
}

/// Parses a `get_group_msg` response.
WsMsgGroups parseGroupMsgResponse(Uint8List body) {
  final proto = pb.GetGroupMsgResIdl.fromBuffer(body);
  final code = proto.error.errorno;
  if (code != 0) {
    throw TiebaServerException(code, proto.error.errmsg);
  }
  return WsMsgGroups.fromProto(proto.data);
}

/// Sends a private message to [userId].
Future<SendMsgResult> sendMsg(WsCore ws, int userId, String content) async {
  final localMsgId = ws.midManager.getLocalMsgId(userId);
  final request = pb.CommitPersonalMsgReqIdl();
  request.ensureData()
    ..toUid = Int64(userId)
    ..msgType = 1
    ..content = content
    ..recordId = Int64(localMsgId);

  final response = await ws.send(request.writeToBuffer(), wsCmdSendMsg);
  return parseSendMsgResponse(await response.read());
}

/// Parses a `send_msg` response.
SendMsgResult parseSendMsgResponse(Uint8List body) {
  final proto = pb.CommitPersonalMsgResIdl.fromBuffer(body);
  final code = proto.error.errorno;
  if (code != 0) {
    throw TiebaServerException(code, proto.error.errmsg);
  }
  final data = proto.data;
  final blockCode = data.blockInfo.blockErrno;
  if (blockCode != 0) {
    throw TiebaServerException(blockCode, data.blockInfo.blockErrmsg);
  }
  if (data.msgId.toInt() == 0) {
    throw const TiebaValueException('msgId is 0');
  }
  return SendMsgResult.fromProto(data);
}

/// Reports [message] as read.
Future<SetMsgReadedResult> setMsgReaded(WsCore ws, WsMessage message) async {
  final request = pb.CommitReceivedPmsgReqIdl();
  request.ensureData()
    ..groupId = Int64(ws.midManager.privGid)
    ..toUid = Int64(message.user.userId)
    ..msgType = WsMsgType.readed.value
    ..msgId = Int64(message.msgId);

  final response = await ws.send(request.writeToBuffer(), wsCmdSetMsgReaded);
  return parseSetMsgReadedResponse(await response.read());
}

/// Parses a `set_msg_readed` response.
SetMsgReadedResult parseSetMsgReadedResponse(Uint8List body) {
  final proto = pb.CommitReceivedPmsgResIdl.fromBuffer(body);
  final code = proto.error.errorno;
  if (code != 0) {
    throw TiebaServerException(code, proto.error.errmsg);
  }
  return SetMsgReadedResult.fromProto(proto.data);
}

/// Parses a server push into notifications.
///
/// `push_notify` has no request side: register [registerPushNotifyHandler] to
/// receive pushes with [wsCmdPushNotify].
List<WsNotify> parsePushNotify(Uint8List body) {
  final proto = pb.PushNotifyResIdl.fromBuffer(body);
  return <WsNotify>[
    for (final pusher in proto.multiMsg) WsNotify.fromProto(pusher),
  ];
}

/// Registers [handler] for server push frames.
void registerPushNotifyHandler(
  WsCore ws,
  void Function(List<WsNotify> notifies) handler,
) {
  ws.registerCallback(wsCmdPushNotify, (core, data, reqId) {
    handler(parsePushNotify(data));
  });
}
