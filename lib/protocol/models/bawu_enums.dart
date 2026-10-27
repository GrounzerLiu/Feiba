/// Enumerations used by the forum-management (bawu) endpoints.
library;

/// A forum moderator role, mirrored from aiotieba's `BawuType`.
///
/// [value] is the identifier used by the server. Note that [admin] is the
/// forum owner role and its server value is `manager`, while [manager] (the
/// assistant moderator role) uses `assist`.
enum BawuType {
  unknown('unknown'),
  admin('manager'),
  manager('assist'),
  videoEditor('videoadmin'),
  imageEditor('picadmin'),
  voiceEditor('voiceadmin'),
  journalEditor('publication'),
  journalChiefEditor('publication_editor'),
  broadcastEditor('broadcast_admin'),
  professAdmin('profess_admin'),
  fourthAdmin('fourth_admin');

  const BawuType(this.value);

  final String value;

  static BawuType fromValue(String value) => BawuType.values.firstWhere(
    (type) => type.value == value,
    orElse: () => BawuType.unknown,
  );
}

/// The search field used by the moderator log pages.
enum BawuSearchType {
  /// Search the author of the moderated post.
  user(0),

  /// Search the moderator that performed the action.
  op(1);

  const BawuSearchType(this.value);

  final int value;

  static BawuSearchType fromValue(int value) =>
      BawuSearchType.values.firstWhere(
        (type) => type.value == value,
        orElse: () => BawuSearchType.user,
      );
}

/// A forum-management permission set, mirrored from aiotieba's
/// `BawuPermType` flag enum.
///
/// Dart has no flag enums, so this class wraps the bit mask and exposes the
/// individual permissions as constants. Combine them with [operator |].
class BawuPermType {
  const BawuPermType(this.value);

  /// The raw bit mask.
  final int value;

  /// No permission at all.
  static const BawuPermType none = BawuPermType(0);

  /// Lift a ban.
  static const BawuPermType unblock = BawuPermType(1);

  /// Handle ban appeals.
  static const BawuPermType unblockAppeal = BawuPermType(2);

  /// Restore a deleted post.
  static const BawuPermType recover = BawuPermType(4);

  /// Handle deletion appeals.
  static const BawuPermType recoverAppeal = BawuPermType(8);

  /// Every permission.
  static const BawuPermType all = BawuPermType(15);

  /// Whether every bit of [other] is present in this permission set.
  bool contains(BawuPermType other) =>
      other.value != 0 && (value & other.value) == other.value;

  BawuPermType operator |(BawuPermType other) =>
      BawuPermType(value | other.value);

  BawuPermType operator &(BawuPermType other) =>
      BawuPermType(value & other.value);

  /// The `perm` id used by the permission API when this value denotes a single
  /// known permission; null otherwise.
  int? get permId => switch (value) {
    1 => 4,
    2 => 5,
    4 => 3,
    8 => 2,
    _ => null,
  };

  /// Maps a `perm` id returned by the permission API back to a permission.
  static BawuPermType? fromPermId(int id) => switch (id) {
    2 => recoverAppeal,
    3 => recover,
    4 => unblock,
    5 => unblockAppeal,
    _ => null,
  };

  @override
  bool operator ==(Object other) =>
      other is BawuPermType && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'BawuPermType($value)';
}
