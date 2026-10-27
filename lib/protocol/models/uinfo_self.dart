import '../core/enums.dart';
import '../core/utils.dart';
import 'uinfo_common.dart';

/// Nickname info returned by `/c/s/initNickname`.
///
/// Mirrors aiotieba's `UserInfo_selfinit`.
class UserInfoSelfInit {
  const UserInfoSelfInit({
    required this.userName,
    required this.nickNameOld,
    required this.tiebaUid,
  });

  final String userName;
  final String nickNameOld;

  /// Uid of the user's personal homepage.
  final int tiebaUid;

  bool get isValid => tiebaUid != 0;

  String get nickName => nickNameOld;

  String get logName =>
      userName.isNotEmpty ? userName : '$nickNameOld/$tiebaUid';

  factory UserInfoSelfInit.fromJson(Map<String, dynamic> json) {
    return UserInfoSelfInit(
      userName: parseString(json['user_name']),
      nickNameOld: parseString(json['name_show']),
      tiebaUid: int.tryParse(parseString(json['tieba_uid'])) ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoSelfInit && other.tiebaUid == tiebaUid;

  @override
  int get hashCode => tiebaUid.hashCode;

  @override
  String toString() => userName;
}

/// Self info returned by the mobile endpoint `/mo/q/newmoindex`.
///
/// Mirrors aiotieba's `UserInfo_moindex`.
class UserInfoMoindex {
  const UserInfoMoindex({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.gender,
    required this.postNum,
    required this.fanNum,
    required this.followNum,
    required this.forumNum,
    required this.sign,
    required this.isVip,
  });

  final int userId;
  final String portrait;
  final String userName;

  final Gender gender;
  final int postNum;
  final int fanNum;
  final int followNum;

  /// Number of followed forums.
  final int forumNum;
  final String sign;

  final bool isVip;

  bool get isValid => userId != 0;

  String get logName => userName.isNotEmpty ? userName : portrait;

  factory UserInfoMoindex.fromJson(Map<String, dynamic> json) {
    return UserInfoMoindex(
      userId: parseInt(json['id']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name']),
      gender: Gender.fromValue(parseInt(json['user_sex'])),
      postNum: parseInt(json['post_num']),
      fanNum: parseInt(json['fans_num']),
      followNum: parseInt(json['concern_num']),
      forumNum: parseInt(json['like_forum_num']),
      sign: parseString(json['intro']),
      isVip: vipInfoToBool(json['vipInfo']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoMoindex && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() => userName.isNotEmpty ? userName : portrait;
}
