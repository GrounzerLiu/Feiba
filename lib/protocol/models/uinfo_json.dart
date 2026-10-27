import '../core/utils.dart';

/// User info returned by the legacy endpoint `/i/sys/user_json`.
///
/// The endpoint only resolves a user name to an id and a portrait, so
/// [userName] is always empty. Mirrors aiotieba's `UserInfo_json`.
class UserInfoJson {
  const UserInfoJson({
    required this.userId,
    required this.portrait,
    this.userName = '',
  });

  final int userId;
  final String portrait;
  final String userName;

  bool get isValid => userId != 0;

  String get logName => toString();

  factory UserInfoJson.fromJson(Map<String, dynamic> json) {
    return UserInfoJson(
      userId: parseInt(json['id']),
      portrait: normalizePortrait(parseString(json['portrait'])),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoJson && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return portrait;
    return '$userId';
  }
}
