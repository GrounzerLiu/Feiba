/// Forum chat room (吧群) APIs.
///
/// Ported from aiotieba's `get_cid`, `get_roomlist_by_fid`,
/// `get_chatroom_detail`, `fetch_chatroom_msg`, `send_chatroom_msg` and
/// `join_chatroom` (Unlicense).
///
/// The list/detail/message APIs use HTTP; sending messages and joining a room
/// go through the BLCP connection because they need the chat identity
/// (`uk` / `trigger_id`) established by the IM login.
library;

import 'dart:convert';

import '../core/account.dart';
import '../core/blcp/blcp_crypto.dart';
import '../core/blcp/constants.dart';
import '../core/blcp/core.dart';
import '../core/blcp/enums.dart';
import '../core/blcp/exceptions.dart';
import '../core/blcp/packet.dart';
import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/sign.dart';
import '../core/utils.dart';
import '../models/chat_room.dart';
import '_common.dart';

Uri _pimUri(String path) =>
    Uri(scheme: 'https', host: 'pim.baidu.com', path: path);

Map<String, String> _pimHeaders(String bduss) {
  final headers = <String, String>{
    'Accept-Encoding': 'gzip',
    'User-Agent': 'okhttp/3.11.0',
  };
  if (bduss.isNotEmpty) headers['Cookie'] = 'BDUSS=$bduss';
  return headers;
}

Map<String, String> _appWebHeaders(TiebaAccount account) {
  final headers = <String, String>{
    'User-Agent': TiebaConstants.webUserAgent,
    'Accept': 'application/json, text/plain, */*',
    'Accept-Encoding': 'gzip, deflate',
    'Connection': 'keep-alive',
  };
  final cookies = <String>[
    if (account.bduss.isNotEmpty) 'BDUSS=${account.bduss}',
    if (account.stoken.isNotEmpty) 'STOKEN=${account.stoken}',
  ];
  if (cookies.isNotEmpty) headers['Cookie'] = cookies.join('; ');
  return headers;
}

Map<String, dynamic> _decodeJson(List<int> bytes) {
  final decoded = jsonDecode(utf8.decode(bytes, allowMalformed: true));
  if (decoded is Map<String, dynamic>) return decoded;
  if (decoded is Map) return decoded.cast<String, dynamic>();
  throw const TiebaFormatException('unexpected JSON payload');
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  return const <String, dynamic>{};
}

/// Fetches the category list used by chat room creation (`get_cid`).
///
/// Mirrors aiotieba, which queries the forum good-category endpoint and
/// returns its `cates` array as raw JSON objects.
Future<List<Map<String, dynamic>>> fetchCid(
  TiebaHttpCore http,
  String fname,
) async {
  final json = await http.postForm(
    '/c/c/bawu/goodlist',
    <MapEntry<String, String>>[
      MapEntry('BDUSS', http.account.bduss),
      MapEntry('word', fname),
    ],
  );
  ensureJsonOk(json);
  final cates = json['cates'];
  if (cates is! List) return const <Map<String, dynamic>>[];
  return <Map<String, dynamic>>[for (final item in cates) _asMap(item)];
}

/// Fetches every chat room of forum [fid] (`get_roomlist_by_fid`).
Future<RoomList> fetchRoomListByFid(TiebaHttpCore http, int fid) async {
  final json = await http.postForm(
    '/c/f/chat/getRoomListByFid',
    <MapEntry<String, String>>[
      MapEntry('BDUSS', http.account.bduss),
      MapEntry('_client_version', chatVersion),
      MapEntry('call_from', 'frs'),
      MapEntry('fid', '$fid'),
    ],
  );
  ensureJsonOk(json);
  return RoomList.fromJson(_asMap(json['data']));
}

/// Fetches the detail of one chat room (`get_chatroom_detail`).
///
/// [lastMsgId] and [lastTime] are optional incremental cursors.
Future<ChatroomDetail> fetchChatroomDetail(
  TiebaHttpCore http,
  int chatroomId, {
  int lastMsgId = 0,
  int lastTime = 0,
}) async {
  final params = <MapEntry<String, String>>[
    MapEntry('_client_version', chatVersion),
    MapEntry('chatroom_id', '$chatroomId'),
    if (lastMsgId != 0) MapEntry('last_msg_id', '$lastMsgId'),
    if (lastTime != 0) MapEntry('last_time', '$lastTime'),
  ];
  final signed = signForm(params, salt: TiebaConstants.appSalt);
  final uri = Uri(
    scheme: 'https',
    host: TiebaConstants.appBaseHost,
    path: '/c/f/chat/getChatRoomDetail',
    queryParameters: <String, String>{
      for (final entry in signed) entry.key: entry.value,
    },
  );
  final response = await http.getRaw(
    uri,
    headers: _appWebHeaders(http.account),
  );
  final json = _decodeJson(response.body);
  ensureJsonOk(json);
  return ChatroomDetail.fromJson(_asMap(json['data']));
}

/// Fetches the latest messages of a chat room (`fetch_chatroom_msg`).
///
/// The endpoint returns the 60 newest messages (negative `count`).
Future<List<ChatroomMessage>> fetchChatroomMsg(
  TiebaHttpCore http,
  int chatroomId,
) async {
  final account = http.account;
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  const longMax = 9223372036854775807;

  // The signature is computed over stringified values; the JSON body keeps the
  // native numeric types the official client sends.
  final signed = signForm(<MapEntry<String, String>>[
    MapEntry('appid', '$chatAppId'),
    MapEntry('mcast_id', '$chatroomId'),
    MapEntry('msgid_end', '$longMax'),
    MapEntry('count', '-60'),
    MapEntry('category', '4'),
    MapEntry('app_version', chatVersion),
    MapEntry('sdk_version', '$chatSdkVersion'),
    MapEntry('device_id', account.cuidGalaxy2),
    MapEntry('timestamp', '$timestamp'),
  ], salt: '');

  final body = <String, dynamic>{
    'appid': chatAppId,
    'mcast_id': chatroomId,
    'msgid_end': longMax,
    'count': -60,
    'category': 4,
    'app_version': chatVersion,
    'sdk_version': chatSdkVersion,
    'device_id': account.cuidGalaxy2,
    'timestamp': timestamp,
    'sign': signed.last.value,
  };

  final response = await http.postRaw(
    _pimUri('/rest/3.0/im/fetch_mcast_msg_client'),
    body: utf8.encode(jsonEncode(body)),
    headers: _pimHeaders(account.bduss),
    contentType: 'application/json',
  );
  final json = _decodeJson(response.body);
  final code = parseInt(json['err_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['err_msg']));
  }
  final rawMessages = json['messages'];
  if (rawMessages is! List) return const <ChatroomMessage>[];
  return <ChatroomMessage>[
    for (final item in rawMessages) ChatroomMessage.fromJson(_asMap(item)),
  ];
}

/// Builds the business payload of a chat room message.
///
/// Kept public so the wire shape can be inspected and tested: the official
/// client nests JSON twice (the outer `content` object holds a `text` string
/// which is itself JSON).
Map<String, dynamic> buildChatroomMsgData({
  required TiebaAccount account,
  required ChatSenderProfile sender,
  required int chatroomId,
  required String text,
  required int fid,
  int level = 0,
  List<Map<String, dynamic>>? atdata,
  int robot = -1,
}) {
  final nowMs = DateTime.now().millisecondsSinceEpoch;
  final nowSeconds = nowMs ~/ 1000;
  final portraitWithTime = '${sender.portrait}?t=$nowSeconds';
  final bduk = userId2bduk(sender.userId);
  final levelText = level.toString().padLeft(2, '0');

  final mainData = <Map<String, dynamic>>[];
  if (sender.isVip) {
    mainData.add(<String, dynamic>{
      'icon': <String, dynamic>{
        'height': 75,
        'priority': 2,
        'schema':
            'https://tieba.baidu.com/mo/q/hybrid-business-vip/tbvip'
            '?customfullscreen=1&nonavigationbar=1',
        'type': '1',
        'url':
            'https://tieba-ares.cdn.bcebos.com/mis/2023-7/'
            '1689061482682/13afea50121d.png',
        'width': 75,
      },
      'type': 2,
    });
  }
  mainData.add(<String, dynamic>{
    'text': <String, dynamic>{
      'short_enable': 1,
      'short_length': 5,
      'short_priority': 1,
      'priority': 1,
      'str': sender.name,
      'suffix': '...',
      'type': '1',
      if (sender.isVip)
        'text_color': <String, dynamic>{
          'day': 'CAM_X0301',
          'night': 'CAM_X0301',
          'type': 2,
        },
    },
    'type': 1,
  });
  mainData.add(<String, dynamic>{
    'icon': <String, dynamic>{
      'height': 15,
      'priority': 5,
      'schema':
          'https://tieba.baidu.com/mo/q/hybrid-main-user/taskCenter'
          '?customfullscreen=1&nonavigationbar=1',
      'type': '3',
      'url':
          'local://icon/icon_mask_level_usergrouth_${sender.glevel}'
          '?type=webp',
      'width': 24,
    },
    'type': 2,
  });
  mainData.add(<String, dynamic>{
    'icon': <String, dynamic>{
      'height': 12,
      'priority': 2,
      'schema':
          'https://tieba.baidu.com/mo/q/wise-bawu-core/forum-level'
          '?customfullscreen=1&forum_id=$fid&nonavigationbar=1'
          '&obj_locate=5&portrait=$portraitWithTime',
      'type': '4',
      'url': 'local://icon/icon_level_$levelText?type=webp',
      'width': 16,
    },
    'type': 2,
  });

  final extData = <String, dynamic>{
    'main_data': mainData,
    'is_sys_msg': 0,
    'version': '',
    'portrait': portraitWithTime,
    'robot_role': 0,
    'role': 0,
    'send_status': 0,
    'from': 'android',
    'session_id': chatroomId,
    'type': 1,
    'user_name': sender.name,
    'content': robot == -1
        ? <String, dynamic>{}
        : <String, dynamic>{
            'robot_params': <String, dynamic>{
              'scene': 'tieba_group_chat',
              'type': robot,
            },
          },
    'level': level,
    'forum_id': fid,
  };

  final textData = <String, dynamic>{
    'room_id': '$chatroomId',
    'type': '0',
    'to_uid': '0',
    'vip': sender.isVip ? '1' : '0',
    'name': sender.name,
    'portrait': portraitWithTime,
    'content_type': '0',
    'content_body': jsonEncode(<String, dynamic>{'text': text}),
    'src': '',
    'baidu_uk': bduk,
    'ext': jsonEncode(extData),
  };
  if (atdata != null && atdata.isNotEmpty) {
    textData['at_data'] = atdata;
  }

  return <String, dynamic>{
    'method': BlcpMethodId.sendMcastMsg.value,
    'mcast_id': chatroomId,
    'role': 3,
    'token': account.bduss,
    'appid': chatAppId,
    'uk': sender.uk,
    'origin_id': sender.triggerId,
    'type': 81,
    'app_safe_ext': jsonEncode(<String, dynamic>{
      'haotianjing': <String, dynamic>{'zid': account.zid ?? ''},
    }),
    'content': jsonEncode(<String, dynamic>{'text': jsonEncode(textData)}),
    'msg_key': computeMsgKey(bduk),
    'account_type': 1,
    'sdk_version': chatSdkVersion,
    'event_list': <Map<String, dynamic>>[
      <String, dynamic>{'event': 'CClickSendBegin', 'timestamp_ms': 0},
      <String, dynamic>{'event': 'CSendBegin', 'timestamp_ms': 0},
      <String, dynamic>{'event': 'CIMSendBegin', 'timestamp_ms': nowMs},
    ],
  };
}

/// Sends a text message to a chat room (`send_chatroom_msg`).
///
/// [sender] defaults to a profile built from [core]'s account; callers that
/// know the VIP/growth-level display values can pass them through
/// [ChatSenderProfile].
///
/// [atdata] carries `@` mentions as the client builds them, [robot] selects a
/// robot command (-1 means none), and [level] is the sender's forum level.
Future<void> sendChatroomMsg(
  BlcpCore core, {
  required int chatroomId,
  required String text,
  required int fid,
  int level = 0,
  List<Map<String, dynamic>>? atdata,
  int robot = -1,
  ChatSenderProfile? sender,
}) async {
  final account = core.account;
  final profile = sender ?? ChatSenderProfile.fromAccount(account);
  final requestData = buildChatroomMsgData(
    account: account,
    sender: profile,
    chatroomId: chatroomId,
    text: text,
    fid: fid,
    level: level,
    atdata: atdata,
    robot: robot,
  );
  requestData['client_logid'] = DateTime.now().microsecondsSinceEpoch;
  requestData['rpc'] = '{"rpc_retry_time":0}';

  final request = BlcpRequest.create(
    BlcpServiceId.mcast.value,
    BlcpMethodId.sendMcastMsg.value,
    body: JsonBody(requestData),
  );
  final response = await core.send(request);
  final payload = response.payload;
  final errCode = parseInt(payload['err_code']);
  if (errCode != 0) {
    throw TiebaServerException(errCode, parseString(payload['msg']));
  }
}

/// Joins the multicast channel of [chatroomId] (`join_chatroom`).
Future<void> joinChatroom(BlcpCore core, int chatroomId) async {
  final requestData = <String, dynamic>{
    'method': BlcpMethodId.joinCast.value,
    'mcast_id': chatroomId,
    'appid': chatAppId,
    'uk': core.account.uk,
  };
  final request = BlcpRequest.create(
    BlcpServiceId.mcast.value,
    BlcpMethodId.joinCast.value,
    body: JsonBody(requestData),
  );
  final response = await core.send(request);
  if (response.errorCode != 0) {
    throw BlcpException('join chatroom failed: ${response.describeError()}');
  }
  final errCode = parseInt(response.payload['err_code']);
  if (errCode != 0) {
    throw BlcpException('join chatroom failed err_code=$errCode');
  }
}
