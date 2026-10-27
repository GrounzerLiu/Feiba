/// Unit tests for the ported chat/IM protocol layer.
///
/// These tests are pure Dart (no network and no Flutter widgets): they cover
/// packet framing, websocket packing, the BLCP crypto helpers and the chat
/// model parsers.
library;

import 'dart:convert';
import 'dart:io' show gzip;
import 'dart:typed_data';

import 'package:feiba/protocol/api/chat_room.dart';
import 'package:feiba/protocol/core/account.dart';
import 'package:feiba/protocol/core/blcp/blcp_crypto.dart';
import 'package:feiba/protocol/core/blcp/enums.dart';
import 'package:feiba/protocol/core/blcp/packet.dart';
import 'package:feiba/protocol/core/ws/helper.dart';
import 'package:feiba/protocol/core/ws/msgid.dart';
import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/models/chat_login.dart';
import 'package:feiba/protocol/models/chat_room.dart';
import 'package:feiba/protocol/models/chat_ws.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

String _hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

Uint8List _ascii(String text) => Uint8List.fromList(utf8.encode(text));

void main() {
  group('blcp crypto', () {
    test('userId2bduk / bduk2userId match the reference vector', () {
      expect(userId2bduk(123456789), 'ru79Dd_Vb1J4qiBxw5rfZQ');
      expect(bduk2userId('ru79Dd_Vb1J4qiBxw5rfZQ'), 123456789);
    });

    test('bduk round-trips a normal user id', () {
      const userId = 987654321012;
      final bduk = userId2bduk(userId);
      expect(bduk, isNot(contains('=')));
      expect(bduk, matches(RegExp(r'^[A-Za-z0-9_-]+$')));
      expect(bduk2userId(bduk), userId);
    });

    test('computeMsgKey starts with the bduk and is numeric', () {
      const bduk = 'ru79Dd_Vb1J4qiBxw5rfZQ';
      final key = computeMsgKey(bduk);
      expect(key.startsWith(bduk), isTrue);
      expect(key.length, greaterThan(bduk.length + 13));
      expect(key.substring(bduk.length), matches(RegExp(r'^[0-9-]+$')));
    });

    test('rc4_42 matches the C reference vector', () {
      final key = '0123456789abcdef0123456789abcdef';
      final data = List<int>.generate(16, (i) => i);
      expect(_hex(rc4_42(key, data)), 'ae436870d3618cb52bd57abfe6b47760');
    });

    test('enuid zero-pads cuid_galaxy2 to 57 characters', () {
      const cuidGalaxy2 = '06C7F37D41256F25FABA97B885DB6EFB|VAPUDW7TA';
      final value = enuid(cuidGalaxy2);
      expect(value.length, 57);
      expect(value.substring(0, 42), cuidGalaxy2);
      expect(value.substring(42), '\u0000' * 15);
    });
  });

  group('LCP packets', () {
    test('request frame round-trips through the stream parser', () {
      final request = BlcpRequest.create(
        BlcpServiceId.im.value,
        BlcpMethodId.loginByToken.value,
        body: const JsonBody(<String, dynamic>{'method': 50, 'appid': 7}),
        correlationId: 12345,
        event: null,
      );
      final bytes = request.toBytes();
      expect(bytes.sublist(0, 4), lcpFramePrefix);

      final parser = LcpFrameParser();
      // Random leading garbage must be skipped, and a prefix can span chunks.
      final frames = <LcpFrame>[
        ...parser.feed(
          Uint8List.fromList(<int>[0xFF, 0x00, ...bytes.sublist(0, 2)]),
        ),
        ...parser.feed(bytes.sublist(2)),
      ];
      expect(frames, hasLength(1));

      final decoded = LcpFrame.decode(frames.single.encode());
      final meta = RpcMeta.decode(decoded.header);
      expect(meta.correlationId, 12345);
      expect(meta.serviceId, BlcpServiceId.im.value);
      expect(meta.methodId, BlcpMethodId.loginByToken.value);
      expect(meta.isNotify, isFalse);

      final body = BlcpBody.decodeFor(meta, decoded.body);
      expect(body, isA<JsonBody>());
      expect((body as JsonBody).data['appid'], 7);
    });

    test('gzip response body decodes into a JSON payload', () {
      final bodyBytes = Uint8List.fromList(
        gzip.encode(utf8.encode('{"err_code":0,"uk":42}')),
      );
      final meta = RpcMeta(
        correlationId: 77,
        response: const RpcResponseMeta(serviceId: 2, methodId: 50, logId: 77),
        compressType: BlcpCompressType.gzip,
      );
      final frame = LcpFrame(meta.encode(), bodyBytes);
      final parser = LcpFrameParser();
      final frames = parser.feed(frame.encode());
      expect(frames, hasLength(1));

      final packet = BlcpPacket.fromFrame(frames.single);
      expect(packet, isA<BlcpResponse>());
      final response = packet as BlcpResponse;
      expect(response.correlationId, 77);
      expect(response.ok, isTrue);
      expect(response.payload['uk'], 42);
    });

    test('LCM heartbeat request carries a typed control body', () {
      final correlationId = randomCorrelationId();
      final body = LcmBody.heartbeat(
        logId: correlationId,
        timestamp: 1700000000000,
      );
      final request = BlcpRequest.create(
        BlcpServiceId.lcm.value,
        BlcpMethodId.heartbeat.value,
        body: body,
        correlationId: correlationId,
      );
      final frame = LcpFrame.decode(request.toBytes());
      final meta = RpcMeta.decode(frame.header);
      expect(meta.serviceId, BlcpServiceId.lcm.value);
      expect(meta.methodId, BlcpMethodId.heartbeat.value);

      final decoded = BlcpBody.decodeFor(meta, frame.body);
      expect(decoded, isA<LcmBody>());
      final lcmBody = decoded as LcmBody;
      expect(lcmBody.data.lcmRequest.logId.toInt(), correlationId);
      expect(lcmBody.data.lcmRequest.timestamp.toInt(), 1700000000000);
    });

    test('LCM login body fills the common block', () {
      final body = LcmBody.login(
        logId: 5,
        token: 'token',
        timestamp: 1700000000000,
        cuid: 'cuid',
        appId: 10773430,
        appVersion: '22.12.1.0',
        sdkVersion: '3460016',
      );
      final decoded = LcmBody.decode(body.encode());
      final request = decoded.data.lcmRequest;
      expect(request.token, 'token');
      expect(request.common.cuid, 'cuid');
      expect(request.common.appId, '10773430');
      expect(request.common.sdkVersion, '3460016');
      expect(request.connType, 1);
      expect(request.startType, -1);
    });

    test('notify frame decodes into a push payload', () {
      final meta = RpcMeta(
        correlationId: 0,
        notify: const RpcNotifyMeta(serviceId: 2, methodId: 202006, logId: 3),
      );
      final frame = LcpFrame(
        meta.encode(),
        Uint8List.fromList(utf8.encode('{"type":1}')),
      );
      final parser = LcpFrameParser();
      final packet = BlcpPacket.fromFrame(parser.feed(frame.encode()).single);
      expect(packet, isA<BlcpNotify>());
      final notify = packet as BlcpNotify;
      expect(notify.serviceId, 2);
      expect(notify.methodId, 202006);
      expect(notify.payload['type'], 1);
    });

    test('two frames in one chunk are both parsed', () {
      LcpFrame build(int id) {
        final meta = RpcMeta(
          correlationId: id,
          response: RpcResponseMeta(serviceId: 2, methodId: 50, logId: id),
        );
        return LcpFrame(meta.encode(), Uint8List.fromList(<int>[id]));
      }

      final parser = LcpFrameParser();
      final frames = parser.feed(
        Uint8List.fromList(<int>[...build(1).encode(), ...build(2).encode()]),
      );
      expect(frames, hasLength(2));
      expect(RpcMeta.decode(frames[0].header).correlationId, 1);
      expect(RpcMeta.decode(frames[1].header).correlationId, 2);
    });
  });

  group('websocket framing', () {
    TiebaAccount account() => TiebaAccount()
      ..wsSecKey = Uint8List.fromList(
        List<int>.generate(31, (i) => (i * 7 + 1) & 0xFF),
      );

    test('derived AES key is stable and 32 bytes long', () {
      final first = deriveWsAesKey(account().wsSecKey);
      final second = deriveWsAesKey(account().wsSecKey);
      expect(first, hasLength(32));
      expect(first, second);
      expect(first, isNot(everyElement(0)));
    });

    test('encrypted frame round-trips', () {
      final wsAccount = account();
      final payload = _ascii('hello chat');
      final frame = packWsBytes(wsAccount, payload, 205001, 4242);
      expect(frame[0], wsFlagProtobuf | wsFlagEncrypted);
      expect(frame.length, 9 + 16);

      final parsed = parseWsBytes(wsAccount, frame);
      expect(parsed.cmd, 205001);
      expect(parsed.reqId, 4242);
      expect(parsed.data, payload);
    });

    test('encrypted and compressed frame round-trips', () {
      final wsAccount = account();
      final payload = Uint8List.fromList(
        utf8.encode('{"text":"${'a' * 200}"}'),
      );
      final frame = packWsBytes(wsAccount, payload, 202003, 1, compress: true);
      expect(frame[0], wsFlagProtobuf | wsFlagEncrypted | wsFlagCompressed);
      final parsed = parseWsBytes(wsAccount, frame);
      expect(parsed.cmd, 202003);
      expect(utf8.decode(parsed.data), utf8.decode(payload));
    });

    test('plain frame round-trips', () {
      final wsAccount = account();
      final payload = Uint8List.fromList(<int>[1, 2, 3, 4]);
      final frame = packWsBytes(wsAccount, payload, 1001, 9, encrypt: false);
      expect(frame[0], wsFlagProtobuf);
      expect(frame.length, 9 + payload.length);
      final parsed = parseWsBytes(wsAccount, frame);
      expect(parsed.data, payload);
    });
  });

  group('message id manager', () {
    test('tracks previous and current ids per group', () {
      final manager = MsgIdManager();
      expect(manager.getMsgId(0), 0);
      manager.updateMsgId(0, 5);
      expect(manager.getMsgId(0), 0);
      manager.updateMsgId(0, 9);
      expect(manager.getMsgId(0), 5);
      expect(manager.getMsgId(7), 0);
    });

    test('synthesises local message ids from pulled ids', () {
      final manager = MsgIdManager();
      expect(manager.getLocalMsgId(42), 1);
      manager.updatePulledMsgId(42, 3);
      expect(manager.getLocalMsgId(42), 301);
      manager.updateLocalMsgId(42, 400);
      expect(manager.getLocalMsgId(42), 401);
      manager.updateLocalMsgId(42, 100);
      expect(manager.getCursors(42).localMsgId, 400);
    });

    test('read cursors only move forward', () {
      final manager = MsgIdManager();
      manager.updateSentMsgId(1, 10);
      manager.updateSentMsgId(1, 4);
      manager.updateReadMsgId(1, 8);
      expect(manager.getCursors(1).sentMsgId, 10);
      expect(manager.getCursors(1).readMsgId, 8);
      expect(manager.privGid, 0);
    });
  });

  group('chat models', () {
    test('LoginImResult parses trigger_id list and bd_uid', () {
      final result = LoginImResult.fromJson(<String, dynamic>{
        'trigger_id': <dynamic>[123456, 0],
        'uk': 789,
        'bd_uid': 987654,
      });
      expect(result.triggerId, 123456);
      expect(result.uk, 789);
      expect(result.bduk, '987654');
    });

    test('ChatroomDetail parses basic/extra/bots', () {
      final robotUk = userId2bduk(777);
      final detail = ChatroomDetail.fromJson(<String, dynamic>{
        'basic_info': <String, dynamic>{
          'id': 100,
          'forum_id': 200,
          'forum_name': 'forum',
          'name': 'room',
          'avatar': 'https://example/avatar',
          'discuss_num': 12,
        },
        'extra_info': <String, dynamic>{
          'announce': 'hello',
          'talk_threshold_level': 3,
          'is_talk_banned': '1',
        },
        'bots': <String, dynamic>{
          'bot_list': <dynamic>[
            <String, dynamic>{
              'user': <String, dynamic>{
                'name': 'bot',
                'name_show': 'Bot',
                'portrait': 'tb.1.bot',
                'uk': robotUk,
                'robot_role': 2,
              },
              'skill': <dynamic>[
                <String, dynamic>{
                  'type': 1,
                  'name': 'sign',
                  'alias': 'daily',
                  'desc': 'daily sign',
                  'is_show': '1',
                  'items': <dynamic>[],
                },
              ],
            },
          ],
        },
      });
      expect(detail.roomId, 100);
      expect(detail.forumId, 200);
      expect(detail.forumName, 'forum');
      expect(detail.name, 'room');
      expect(detail.discussNum, 12);
      expect(detail.announce, 'hello');
      expect(detail.talkThresholdLevel, 3);
      expect(detail.isTalkBanned, isTrue);
      expect(detail.robots, hasLength(1));
      expect(detail.robots.single.userId, 777);
      expect(detail.robots.single.robotRole, 2);
      expect(detail.robots.single.skills.single.name, 'sign');
      expect(detail.robots.single.skills.single.isShow, isTrue);
    });

    test('ChatroomMessage unwraps the double encoded content', () {
      final content = jsonEncode(<String, dynamic>{
        'text': jsonEncode(<String, dynamic>{'text': 'hi', 'extra': 3}),
      });
      final message = ChatroomMessage.fromJson(<String, dynamic>{
        'msgid': 12,
        'type': 1,
        'from_user': 34,
        'create_time': 1700000000,
        'content': content,
      });
      expect(message.msgId, 12);
      expect(message.msgType, 1);
      expect(message.userId, 34);
      expect(message.createTime, 1700000000);
      expect(message.content['text'], 'hi');
      expect(message.content['extra'], 3);
    });

    test('RoomList flattens nested room lists', () {
      final rooms = RoomList.fromJson(<String, dynamic>{
        'list': <dynamic>[
          <String, dynamic>{
            'room_list': <dynamic>[
              <String, dynamic>{'room_id': 1},
              <String, dynamic>{'room_id': 2},
            ],
          },
          <String, dynamic>{
            'room_list': <dynamic>[
              <String, dynamic>{'room_id': 3},
            ],
          },
        ],
      });
      expect(rooms.length, 3);
      expect(rooms.rooms.last['room_id'], 3);
    });

    test('WsMsgGroups parses protobuf groups and drops empty ones', () {
      final data = pb.GetGroupMsgResIdl_DataRes();
      data.groupInfo.add(
        pb.GetGroupMsgResIdl_DataRes_GroupMsg()
          ..groupInfo = (pb.GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo()
            ..groupId = Int64(9)
            ..groupType = 6)
          ..msgList.add(
            pb.GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo()
              ..msgId = Int64(1)
              ..msgType = 1
              ..content = 'hello'
              ..createTime = 1700
              ..userInfo =
                  (pb.GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo()
                    ..userId = Int64(88)
                    ..userName = 'user'
                    ..portrait = 'tb.1.user?t=1700000000'),
          ),
      );
      data.groupInfo.add(
        pb.GetGroupMsgResIdl_DataRes_GroupMsg()
          ..groupInfo = (pb.GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo()
            ..groupId = Int64(0)),
      );

      final groups = WsMsgGroups.fromProto(data);
      expect(groups, hasLength(1));
      final group = groups.single;
      expect(group.groupId, 9);
      expect(group.groupType, 6);
      expect(group.messages, hasLength(1));
      expect(group.messages.single.user.userId, 88);
      expect(group.messages.single.user.userName, 'user');
      expect(group.messages.single.user.portrait, 'tb.1.user');
      expect(group.messages.single.text, 'hello');
      expect(group.messages.single.createTime, 1700);
    });

    test('InitWsInfo parses groups and the current user', () {
      final proto = pb.UpdateClientInfoResIdl();
      final data = proto.ensureData();
      data.groupInfo.add(
        pb.UpdateClientInfoResIdl_DataRes_GroupInfo()
          ..groupId = Int64(6)
          ..groupType = 6
          ..lastMsgId = Int64(1234),
      );
      data.ensureUserInfo()
        ..userId = Int64(55)
        ..userName = 'me'
        ..portrait = 'tb.1.me';

      final info = InitWsInfo.fromProto(proto);
      expect(info.groups.single.groupId, 6);
      expect(info.groups.single.groupType, 6);
      expect(info.groups.single.lastMsgId, 1234);
      expect(info.user.userId, 55);
      expect(info.user.userName, 'me');
      expect(info.user.portrait, 'tb.1.me');
    });

    test('SendMsgResult and SetMsgReadedResult parse protobufs', () {
      final sendProto = pb.CommitPersonalMsgResIdl_DataRes()
        ..groupId = Int64(6)
        ..recordId = Int64(301)
        ..toUid = Int64(88)
        ..toUserType = 0;
      final send = SendMsgResult.fromProto(sendProto);
      expect(send.groupId, 6);
      expect(send.localMsgId, 301);
      expect(send.toUid, 88);

      final readProto = pb.CommitReceivedPmsgResIdl_DataRes()
        ..readMsgId = Int64(400)
        ..groupId = Int64(6)
        ..toUid = Int64(88)
        ..toUserType = 0;
      final read = SetMsgReadedResult.fromProto(readProto);
      expect(read.readMsgId, 400);
      expect(read.groupId, 6);
    });

    test('WsNotify parses push protobufs', () {
      final pusher = pb.PushNotifyResIdl_PusherMsg()
        ..data = (pb.PushNotifyResIdl_PusherMsg_PusherMsgInfo()
          ..groupId = Int64(6)
          ..msgId = Int64(7)
          ..type = 1
          ..et = '1700000000'
          ..groupType = 6);
      final notify = WsNotify.fromProto(pusher);
      expect(notify.noteType, 1);
      expect(notify.groupId, 6);
      expect(notify.groupType, 6);
      expect(notify.msgId, 7);
      expect(notify.createTime, 1700000000);
    });

    test('buildChatroomMsgData double encodes content', () {
      final account = TiebaAccount()
        ..userId = 123456789
        ..userName = 'me'
        ..portrait = 'tb.1.me'
        ..uk = 11
        ..triggerId = 22;
      final data = buildChatroomMsgData(
        account: account,
        sender: ChatSenderProfile.fromAccount(account),
        chatroomId: 100,
        text: 'hello',
        fid: 200,
        level: 3,
      );

      expect(data['method'], 185);
      expect(data['mcast_id'], 100);
      expect(data['uk'], 11);
      expect(data['origin_id'], 22);
      expect(data['type'], 81);
      expect(data['msg_key'], isA<String>());

      final content =
          jsonDecode(data['content'] as String) as Map<String, dynamic>;
      // The outer `text` value is a JSON string, not an object.
      expect(content['text'], isA<String>());
      final textData =
          jsonDecode(content['text'] as String) as Map<String, dynamic>;
      expect(textData['room_id'], '100');
      expect(textData['baidu_uk'], userId2bduk(123456789));
      expect(
        (jsonDecode(textData['content_body'] as String)
            as Map<String, dynamic>)['text'],
        'hello',
      );
      final ext = jsonDecode(textData['ext'] as String) as Map<String, dynamic>;
      expect(ext['forum_id'], 200);
      expect(ext['level'], 3);
      expect(ext['session_id'], 100);
      expect(ext['main_data'], isA<List<dynamic>>());
      expect(ext['content'], isA<Map<String, dynamic>>());

      final appSafeExt =
          jsonDecode(data['app_safe_ext'] as String) as Map<String, dynamic>;
      expect(appSafeExt['haotianjing'], isA<Map<String, dynamic>>());
    });

    test('WsNotify falls back to 0 for a non numeric et', () {
      final pusher = pb.PushNotifyResIdl_PusherMsg()
        ..data = (pb.PushNotifyResIdl_PusherMsg_PusherMsgInfo()..et = '');
      expect(WsNotify.fromProto(pusher).createTime, 0);
    });
  });
}
