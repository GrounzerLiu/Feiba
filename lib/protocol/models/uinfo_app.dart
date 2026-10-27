import '../core/enums.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// User info returned by the app endpoint `/c/u/user/getuserinfo`.
///
/// Mirrors aiotieba's `UserInfo_guinfo_app`.
class UserInfoApp {
  const UserInfoApp({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameOld,
    required this.gender,
    required this.isVip,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameOld;
  final Gender gender;
  final bool isVip;

  bool get isValid => userId != 0;

  /// The app endpoint only exposes the legacy nickname.
  String get nickName => nickNameOld;

  String get logName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return '$nickNameOld/$portrait';
    return '$userId';
  }

  factory UserInfoApp.fromProto(pb.User proto) {
    return UserInfoApp(
      userId: proto.id.toInt(),
      portrait: normalizePortrait(proto.portrait),
      userName: proto.name,
      nickNameOld: proto.nameShow,
      gender: Gender.fromValue(proto.sex),
      isVip: proto.isMem != 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoApp && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return portrait;
    return '$userId';
  }
}
