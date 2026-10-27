/// Models of the forum chat room (吧群) APIs.
library;

import 'dart:convert';

import '../core/account.dart';
import '../core/blcp/blcp_crypto.dart';
import '../core/utils.dart';

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  return const <String, dynamic>{};
}

List<Map<String, dynamic>> _asMapList(dynamic value) {
  if (value is List) {
    return <Map<String, dynamic>>[for (final item in value) _asMap(item)];
  }
  return const <Map<String, dynamic>>[];
}

/// Chat room list of one forum (`get_roomlist_by_fid`).
///
/// aiotieba keeps the room payloads as raw JSON objects, so this model does the
/// same instead of inventing a schema for the per-room fields.
class RoomList {
  const RoomList({this.rooms = const <Map<String, dynamic>>[]});

  /// Room payloads, flattened from `data.list[].room_list`.
  final List<Map<String, dynamic>> rooms;

  bool get isEmpty => rooms.isEmpty;

  int get length => rooms.length;

  /// Parses the `data` object of the response.
  factory RoomList.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return const RoomList();
    final rooms = <Map<String, dynamic>>[];
    for (final entry in _asMapList(data['list'])) {
      rooms.addAll(_asMapList(entry['room_list']));
    }
    return RoomList(rooms: rooms);
  }
}

/// A skill of a chat room robot.
class RobotSkill {
  const RobotSkill({
    this.type = 0,
    this.name = '',
    this.alias = '',
    this.desc = '',
    this.isShow = false,
    this.items = const <Map<String, dynamic>>[],
  });

  final int type;
  final String name;
  final String alias;
  final String desc;
  final bool isShow;
  final List<Map<String, dynamic>> items;

  factory RobotSkill.fromJson(Map<String, dynamic> data) => RobotSkill(
    type: parseInt(data['type']),
    name: parseString(data['name']),
    alias: parseString(data['alias']),
    desc: parseString(data['desc']),
    isShow: parseInt(data['is_show']) != 0,
    items: _asMapList(data['items']),
  );
}

/// A chat room robot.
class ChatRobot {
  const ChatRobot({
    this.name = '',
    this.nameShow = '',
    this.portrait = '',
    this.uk = '',
    this.userId = 0,
    this.robotRole = 0,
    this.skills = const <RobotSkill>[],
  });

  final String name;
  final String nameShow;
  final String portrait;

  /// `baidu_uk` of the robot account.
  final String uk;

  /// Decrypted user id; 0 when [uk] is not a valid bduk value.
  final int userId;

  final int robotRole;
  final List<RobotSkill> skills;

  factory ChatRobot.fromJson(Map<String, dynamic> data) {
    final user = _asMap(data['user']);
    final uk = parseString(user['uk']);
    var userId = 0;
    if (uk.isNotEmpty) {
      try {
        userId = bduk2userId(uk);
      } on Object {
        // Malformed robot identifier: keep 0 instead of failing the detail.
        userId = 0;
      }
    }
    return ChatRobot(
      name: parseString(user['name']),
      nameShow: parseString(user['name_show']),
      portrait: parseString(user['portrait']),
      uk: uk,
      userId: userId,
      robotRole: parseInt(user['robot_role']),
      skills: <RobotSkill>[
        for (final item in _asMapList(data['skill'])) RobotSkill.fromJson(item),
      ],
    );
  }
}

/// Detail of one chat room (`get_chatroom_detail`).
class ChatroomDetail {
  const ChatroomDetail({
    this.roomId = 0,
    this.forumId = 0,
    this.forumName = '',
    this.name = '',
    this.avatar = '',
    this.discussNum = 0,
    this.announce = '',
    this.talkThresholdLevel = 0,
    this.isTalkBanned = false,
    this.robots = const <ChatRobot>[],
  });

  final int roomId;
  final int forumId;
  final String forumName;
  final String name;
  final String avatar;
  final int discussNum;
  final String announce;
  final int talkThresholdLevel;
  final bool isTalkBanned;
  final List<ChatRobot> robots;

  factory ChatroomDetail.fromJson(Map<String, dynamic> data) {
    final basicInfo = _asMap(data['basic_info']);
    final extraInfo = _asMap(data['extra_info']);
    final bots = _asMap(data['bots']);
    return ChatroomDetail(
      roomId: parseInt(basicInfo['id']),
      forumId: parseInt(basicInfo['forum_id']),
      forumName: parseString(basicInfo['forum_name']),
      name: parseString(basicInfo['name']),
      avatar: parseString(basicInfo['avatar']),
      discussNum: parseInt(basicInfo['discuss_num']),
      announce: parseString(extraInfo['announce']),
      talkThresholdLevel: parseInt(extraInfo['talk_threshold_level']),
      isTalkBanned: parseInt(extraInfo['is_talk_banned']) != 0,
      robots: <ChatRobot>[
        for (final item in _asMapList(bots['bot_list']))
          ChatRobot.fromJson(item),
      ],
    );
  }
}

/// One message of a chat room (`fetch_chatroom_msg`).
class ChatroomMessage {
  const ChatroomMessage({
    this.msgId = 0,
    this.msgType = 0,
    this.userId = 0,
    this.createTime = 0,
    this.content = const <String, dynamic>{},
  });

  /// Message id.
  final int msgId;

  /// Message type.
  final int msgType;

  /// Sender user id; 0 for system messages.
  final int userId;

  /// Send time as a 10-digit (seconds) timestamp.
  final int createTime;

  /// Message content; the structure depends on [msgType].
  final Map<String, dynamic> content;

  /// Parses one element of the `messages` array.
  ///
  /// The wire format nests JSON twice: `content` is a string holding an
  /// object whose `text` field is again a JSON string.
  factory ChatroomMessage.fromJson(Map<String, dynamic> data) =>
      ChatroomMessage(
        msgId: parseInt(data['msgid']),
        msgType: parseInt(data['type']),
        userId: parseInt(data['from_user']),
        createTime: parseInt(data['create_time']),
        content: _decodeContent(data['content']),
      );

  static Map<String, dynamic> _decodeContent(dynamic raw) {
    var outer = raw;
    if (raw is String) {
      outer = _tryDecodeJson(raw) ?? const <String, dynamic>{};
    }
    final outerMap = _asMap(outer);
    final text = outerMap['text'];
    if (text is String) {
      final decoded = _tryDecodeJson(text);
      if (decoded != null) return _asMap(decoded);
      return const <String, dynamic>{};
    }
    if (text is Map) return _asMap(text);
    return outerMap;
  }
}

Object? _tryDecodeJson(String text) {
  if (text.isEmpty) return null;
  try {
    return jsonDecode(text);
  } on FormatException {
    return null;
  }
}

/// Profile of the account used when sending a chat room message.
class ChatSenderProfile {
  const ChatSenderProfile({
    this.userId = 0,
    this.uk = 0,
    this.triggerId = 0,
    this.bduk = '',
    this.name = '',
    this.portrait = '',
    this.isVip = false,
    this.glevel = 0,
  });

  /// Current user id.
  final int userId;

  /// Chat account identifier from the IM login.
  final int uk;

  /// Chat session identifier from the IM login.
  final int triggerId;

  /// Chat account `bd_uid` from the IM login.
  final String bduk;

  /// Display name.
  final String name;

  /// Portrait identifier.
  final String portrait;

  /// Whether the account has a Tieba VIP badge.
  final bool isVip;

  /// Tieba growth level.
  final int glevel;

  /// Builds a profile from an account, optionally overriding display values.
  factory ChatSenderProfile.fromAccount(
    TiebaAccount account, {
    String? name,
    bool isVip = false,
    int glevel = 0,
  }) => ChatSenderProfile(
    userId: account.userId,
    uk: account.uk,
    triggerId: account.triggerId,
    bduk: account.bduk ?? '',
    name: name ?? account.userName ?? '',
    portrait: account.portrait ?? '',
    isVip: isVip,
    glevel: glevel,
  );
}
