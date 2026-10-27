import '../core/utils.dart';

/// User info returned by the web IM endpoint `/im/pcmsg/query/getUserInfo`.
///
/// Mirrors aiotieba's `UserInfo_guinfo_web`.
class UserInfoWeb {
  const UserInfoWeb({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;

  bool get isValid => userId != 0;

  /// Alias kept for parity with the other user-info variants.
  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get logName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return '$nickNameNew/$portrait';
    return '$userId';
  }

  /// Parses the `chatUser` block of the response.
  factory UserInfoWeb.fromJson(Map<String, dynamic> json) {
    final userId = parseInt(json['uid']);
    var userName = parseString(json['uname']);
    // The server echoes the numeric id as the user name of unnamed accounts.
    if (userName == '$userId') userName = '';
    return UserInfoWeb(
      userId: userId,
      portrait: parseString(json['portrait']),
      userName: userName,
      nickNameNew: parseString(json['show_nickname']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoWeb && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return portrait;
    return '$userId';
  }
}
