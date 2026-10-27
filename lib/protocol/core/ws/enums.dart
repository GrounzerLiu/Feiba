/// Enumerations used by the Tieba websocket protocol.
///
/// Ported from `aiotieba/enums.py` (Unlicense).
library;

/// State of a websocket connection.
enum WsStatus {
  closed(0),
  connecting(1),
  open(2);

  const WsStatus(this.value);

  final int value;
}

/// Type of a websocket message group.
enum WsGroupType {
  /// Private message group.
  privateMessage(6),

  /// Misc group (system notifications and similar).
  misc(8);

  const WsGroupType(this.value);

  final int value;

  /// Returns the matching group type, or `null` for an unknown value.
  static WsGroupType? tryFromValue(int value) {
    for (final item in WsGroupType.values) {
      if (item.value == value) return item;
    }
    return null;
  }
}

/// Type of a websocket message.
enum WsMsgType {
  /// A private message.
  privateMessage(1),

  /// A miscellaneous/system message.
  misc(10),

  /// A read receipt.
  readed(22);

  const WsMsgType(this.value);

  final int value;

  /// Returns the matching message type, or `null` for an unknown value.
  static WsMsgType? tryFromValue(int value) {
    for (final item in WsMsgType.values) {
      if (item.value == value) return item;
    }
    return null;
  }
}
