/// Models of the chat websocket APIs.
library;

import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// User information carried by websocket messages.
class WsUserInfo {
  const WsUserInfo({this.userId = 0, this.portrait = '', this.userName = ''});

  final int userId;
  final String portrait;
  final String userName;

  bool get isEmpty => userId == 0;

  /// Builds user info from a message-level protobuf.
  factory WsUserInfo.fromMsgProto(
    pb.GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo proto,
  ) => WsUserInfo(
    userId: proto.userId.toInt(),
    portrait: normalizePortrait(proto.portrait),
    userName: proto.userName,
  );

  /// Builds user info from the websocket initialization protobuf.
  factory WsUserInfo.fromUpdateProto(
    pb.UpdateClientInfoResIdl_DataRes_UserInfo proto,
  ) => WsUserInfo(
    userId: proto.userId.toInt(),
    portrait: normalizePortrait(proto.portrait),
    userName: proto.userName,
  );

  @override
  String toString() => userName.isNotEmpty
      ? userName
      : (portrait.isNotEmpty ? portrait : '$userId');
}

/// One websocket message (`get_group_msg`).
class WsMessage {
  const WsMessage({
    this.msgId = 0,
    this.msgType = 0,
    this.text = '',
    this.user = const WsUserInfo(),
    this.createTime = 0,
  });

  /// Message id.
  final int msgId;

  /// Message type, see [WsMsgType].
  final int msgType;

  /// Message text; read receipts and misc messages carry JSON here.
  final String text;

  /// Sender.
  final WsUserInfo user;

  /// Send time as a 10-digit (seconds) timestamp.
  final int createTime;

  factory WsMessage.fromProto(
    pb.GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo proto,
  ) => WsMessage(
    msgId: proto.msgId.toInt(),
    msgType: proto.msgType,
    text: proto.content,
    user: WsUserInfo.fromMsgProto(proto.userInfo),
    createTime: proto.createTime,
  );
}

/// One message group (`get_group_msg`).
class WsMsgGroup {
  const WsMsgGroup({
    this.groupId = 0,
    this.groupType = 0,
    this.messages = const <WsMessage>[],
  });

  /// Group id.
  final int groupId;

  /// Group type, see [WsGroupType].
  final int groupType;

  /// Messages of this group.
  final List<WsMessage> messages;

  bool get isEmpty => messages.isEmpty;

  factory WsMsgGroup.fromProto(pb.GetGroupMsgResIdl_DataRes_GroupMsg proto) =>
      WsMsgGroup(
        groupId: proto.groupInfo.groupId.toInt(),
        groupType: proto.groupInfo.groupType,
        messages: <WsMessage>[
          for (final message in proto.msgList) WsMessage.fromProto(message),
        ],
      );
}

/// The message groups returned by `get_group_msg`.
class WsMsgGroups extends Iterable<WsMsgGroup> {
  const WsMsgGroups(this.groups);

  /// Message groups; groups with a zero id are dropped.
  final List<WsMsgGroup> groups;

  @override
  Iterator<WsMsgGroup> get iterator => groups.iterator;

  @override
  int get length => groups.length;

  @override
  WsMsgGroup elementAt(int index) => groups[index];

  @override
  bool get isEmpty => groups.isEmpty;

  factory WsMsgGroups.fromProto(pb.GetGroupMsgResIdl_DataRes data) =>
      WsMsgGroups(<WsMsgGroup>[
        for (final group in data.groupInfo)
          if (group.groupInfo.groupId.toInt() != 0) WsMsgGroup.fromProto(group),
      ]);
}

/// A message group announced by the websocket initialization.
class WsMsgGroupInfo {
  const WsMsgGroupInfo({
    this.groupId = 0,
    this.groupType = 0,
    this.lastMsgId = 0,
  });

  final int groupId;
  final int groupType;
  final int lastMsgId;

  factory WsMsgGroupInfo.fromProto(
    pb.UpdateClientInfoResIdl_DataRes_GroupInfo proto,
  ) => WsMsgGroupInfo(
    groupId: proto.groupId.toInt(),
    groupType: proto.groupType,
    lastMsgId: proto.lastMsgId.toInt(),
  );
}

/// Result of the websocket initialization (`upload_ws_sec`).
class InitWsInfo {
  const InitWsInfo({
    this.groups = const <WsMsgGroupInfo>[],
    this.user = const WsUserInfo(),
  });

  /// Message groups known by the server.
  final List<WsMsgGroupInfo> groups;

  /// Basic information of the current account.
  final WsUserInfo user;

  factory InitWsInfo.fromProto(pb.UpdateClientInfoResIdl proto) {
    final data = proto.data;
    return InitWsInfo(
      groups: <WsMsgGroupInfo>[
        for (final group in data.groupInfo) WsMsgGroupInfo.fromProto(group),
      ],
      user: WsUserInfo.fromUpdateProto(data.userInfo),
    );
  }
}

/// Result of `send_msg` (private message).
class SendMsgResult {
  const SendMsgResult({
    this.groupId = 0,
    this.localMsgId = 0,
    this.toUid = 0,
    this.toUserType = 0,
  });

  /// Private message group id.
  final int groupId;

  /// Local message id echoed by the server.
  final int localMsgId;

  /// Receiver user id.
  final int toUid;

  /// Receiver user type; 0 means a regular user.
  final int toUserType;

  factory SendMsgResult.fromProto(pb.CommitPersonalMsgResIdl_DataRes proto) =>
      SendMsgResult(
        groupId: proto.groupId.toInt(),
        localMsgId: proto.recordId.toInt(),
        toUid: proto.toUid.toInt(),
        toUserType: proto.toUserType,
      );
}

/// Result of `set_msg_readed`.
class SetMsgReadedResult {
  const SetMsgReadedResult({
    this.readMsgId = 0,
    this.groupId = 0,
    this.toUid = 0,
    this.toUserType = 0,
  });

  /// Read position recorded by the server.
  final int readMsgId;

  /// Private message group id.
  final int groupId;

  /// Peer user id.
  final int toUid;

  /// Peer user type; 0 means a regular user.
  final int toUserType;

  factory SetMsgReadedResult.fromProto(
    pb.CommitReceivedPmsgResIdl_DataRes proto,
  ) => SetMsgReadedResult(
    readMsgId: proto.readMsgId.toInt(),
    groupId: proto.groupId.toInt(),
    toUid: proto.toUid.toInt(),
    toUserType: proto.toUserType,
  );
}

/// A server-pushed notification (`push_notify`).
class WsNotify {
  const WsNotify({
    this.noteType = 0,
    this.groupId = 0,
    this.groupType = 0,
    this.msgId = 0,
    this.createTime = 0,
  });

  /// Notification type.
  final int noteType;

  /// Message group id.
  final int groupId;

  /// Message group type, see [WsGroupType].
  final int groupType;

  /// Newest message id.
  final int msgId;

  /// Push time as a 10-digit (seconds) timestamp.
  final int createTime;

  factory WsNotify.fromProto(pb.PushNotifyResIdl_PusherMsg proto) {
    final info = proto.data;
    return WsNotify(
      noteType: info.type,
      groupId: info.groupId.toInt(),
      groupType: info.groupType,
      msgId: info.msgId.toInt(),
      createTime: int.tryParse(info.et) ?? 0,
    );
  }

  @override
  String toString() =>
      'WsNotify(type: $noteType, group: $groupId/$groupType, msg: $msgId)';
}
