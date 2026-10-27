/// Message-id bookkeeping for the chat websocket.
///
/// Ported from `aiotieba/core/websocket/msgid.py` (Unlicense).
library;

/// Two-element message id window (previous and current).
class MsgIdPair {
  MsgIdPair({this.lastId = 0, this.currId = 0});

  int lastId;
  int currId;

  /// Pushes a new message id, keeping the previous one.
  void updateMsgId(int currId) {
    lastId = this.currId;
    this.currId = currId;
  }
}

/// Cursors of a private conversation with one user.
class PrivChatCursors {
  PrivChatCursors({
    this.localMsgId = 0,
    this.pulledMsgId = 0,
    this.sentMsgId = 0,
    this.readMsgId = 0,
  });

  /// Last `local_msg_id` used by this side, echoed by the server.
  int localMsgId;

  /// Newest message id already pulled.
  int pulledMsgId;

  /// Last reported read position.
  int sentMsgId;

  /// Newest message id the peer has read.
  int readMsgId;
}

/// Message-id manager used by the chat websocket.
class MsgIdManager {
  /// Message group id of the private message channel.
  int privGid = 0;

  /// Per-group message id windows; group 0 is always present.
  final Map<int, MsgIdPair> gid2mid = <int, MsgIdPair>{0: MsgIdPair()};

  /// Per-user private conversation cursors.
  final Map<int, PrivChatCursors> uid2cursors = <int, PrivChatCursors>{};

  /// Records the newest message id of [groupId].
  void updateMsgId(int groupId, int msgId) {
    final pair = gid2mid[groupId];
    if (pair != null) {
      pair.updateMsgId(msgId);
    } else {
      gid2mid[groupId] = MsgIdPair(lastId: msgId, currId: msgId);
    }
  }

  /// Returns the previous message id of [groupId], or 0 when unknown.
  int getMsgId(int groupId) => gid2mid[groupId]?.lastId ?? 0;

  /// Returns (creating when needed) the cursors of [userId].
  PrivChatCursors getCursors(int userId) =>
      uid2cursors.putIfAbsent(userId, PrivChatCursors.new);

  /// Next `local_msg_id` to use when sending to [userId].
  int getLocalMsgId(int userId) {
    final cursors = getCursors(userId);
    final base = cursors.localMsgId > cursors.pulledMsgId * 100
        ? cursors.localMsgId
        : cursors.pulledMsgId * 100;
    return base + 1;
  }

  /// Records the `local_msg_id` used for the last send to [userId].
  void updateLocalMsgId(int userId, int localMsgId) {
    final cursors = getCursors(userId);
    if (localMsgId > cursors.localMsgId) {
      cursors.localMsgId = localMsgId;
    }
  }

  /// Records the newest pulled message id of [userId].
  void updatePulledMsgId(int userId, int msgId) {
    final cursors = getCursors(userId);
    if (msgId > cursors.pulledMsgId) {
      cursors.pulledMsgId = msgId;
    }
  }

  /// Records the last reported read position for [userId].
  void updateSentMsgId(int userId, int msgId) {
    final cursors = getCursors(userId);
    if (msgId > cursors.sentMsgId) {
      cursors.sentMsgId = msgId;
    }
  }

  /// Records the newest message id the peer has read.
  void updateReadMsgId(int userId, int msgId) {
    final cursors = getCursors(userId);
    if (msgId > cursors.readMsgId) {
      cursors.readMsgId = msgId;
    }
  }
}
