import '../core/enums.dart';
import '../core/utils.dart';
import 'uinfo_common.dart';

/// User info returned by the web panel endpoint `/home/get/panel`.
///
/// Mirrors aiotieba's `UserInfo_panel`.
class UserInfoPanel {
  const UserInfoPanel({
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
    required this.nickNameOld,
    required this.gender,
    required this.age,
    required this.postNum,
    required this.fanNum,
    required this.isVip,
  });

  final String portrait;
  final String userName;
  final String nickNameNew;
  final String nickNameOld;

  final Gender gender;

  /// Account age in years.
  final double age;
  final int postNum;
  final int fanNum;

  final bool isVip;

  bool get isValid => portrait.isNotEmpty;

  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get logName {
    if (userName.isNotEmpty) return userName;
    return '$nickNameNew/$portrait';
  }

  /// Parses the `data` block of the response.
  factory UserInfoPanel.fromJson(Map<String, dynamic> json) {
    final tbAge = parseString(json['tb_age'], '-');
    return UserInfoPanel(
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name']),
      nickNameNew: parseString(json['show_nickname']),
      nickNameOld: parseString(json['name_show']),
      gender: genderFromText(parseString(json['sex'])),
      age: tbAge == '-' ? 0 : (double.tryParse(tbAge) ?? 0),
      postNum: tbnum2int(json['post_num'], '万'),
      fanNum: tbnum2int(json['followed_count'], '万'),
      isVip: vipInfoToBool(json['vipInfo']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserInfoPanel && other.portrait == portrait;

  @override
  int get hashCode => portrait.hashCode;

  @override
  String toString() => userName.isNotEmpty ? userName : portrait;
}
