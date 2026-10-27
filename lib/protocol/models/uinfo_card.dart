import '../core/enums.dart';
import '../core/utils.dart';

/// User info returned by the PC user-card endpoint `/c/u/pc/userCard`.
///
/// Mirrors aiotieba's `UserInfo_uc`.
class UserInfoCard {
  const UserInfoCard({
    required this.portrait,
    required this.nickNameNew,
    required this.tiebaUid,
    required this.gender,
    required this.age,
    required this.agreeNum,
    required this.fanNum,
    required this.followNum,
    required this.sign,
    required this.ip,
  });

  final String portrait;
  final String nickNameNew;

  /// Uid of the user's personal homepage.
  final int tiebaUid;

  final Gender gender;

  /// Account age in years.
  final double age;

  final int agreeNum;
  final int fanNum;
  final int followNum;
  final String sign;
  final String ip;

  bool get isValid => portrait.isNotEmpty;

  String get nickName => nickNameNew;

  String get showName => nickNameNew;

  String get logName => nickNameNew.isNotEmpty ? nickNameNew : portrait;

  factory UserInfoCard.fromJson(Map<String, dynamic> json) {
    return UserInfoCard(
      portrait: normalizePortrait(parseString(json['portrait'])),
      nickNameNew: parseString(json['name_show']),
      tiebaUid: int.tryParse(parseString(json['tieba_uid'])) ?? 0,
      gender: Gender.fromValue(parseInt(json['sex'])),
      age: double.tryParse(parseString(json['tb_age'])) ?? 0,
      agreeNum: parseInt(json['total_agree_num']),
      fanNum: parseInt(json['fans_num']),
      followNum: parseInt(json['concern_num']),
      sign: parseString(json['intro']),
      ip: parseString(json['ip_address']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoCard && other.portrait == portrait;

  @override
  int get hashCode => portrait.hashCode;

  @override
  String toString() => nickNameNew.isNotEmpty ? nickNameNew : portrait;
}
