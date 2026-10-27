import '../core/utils.dart';
import 'bawu_enums.dart';
import 'bawu_parse.dart';

/// The target user of a moderator permission entry.
class BawuPermUser {
  const BawuPermUser({
    required this.userName,
    required this.nickNameOld,
    required this.level,
    required this.bawuType,
    required this.beginTime,
  });

  final String userName;

  /// Old-style nickname.
  final String nickNameOld;

  /// Forum level.
  final int level;

  final BawuType bawuType;

  /// Time the user took office; the epoch when the server omits it.
  final DateTime beginTime;

  factory BawuPermUser.fromJson(Map<String, dynamic> json) {
    final createTime = parseInt(json['create_time']);
    return BawuPermUser(
      userName: parseString(json['user_name']),
      nickNameOld: parseString(json['user_nickname']),
      level: parseInt(json['level_id']),
      bawuType: BawuType.fromValue(parseString(json['role_type'])),
      beginTime: createTime == 0
          ? bawuEpoch()
          : DateTime.fromMillisecondsSinceEpoch(createTime * 1000),
    );
  }
}

/// The permissions granted to one forum moderator.
class BawuPerm {
  const BawuPerm({required this.user, required this.perms});

  final BawuPermUser user;
  final BawuPermType perms;

  factory BawuPerm.fromJson(Map<String, dynamic> json) {
    final setting = bawuMap(json['perm_setting']);
    var perms = BawuPermType.none;
    for (final category in const <String>['category_user', 'category_thread']) {
      for (final item in bawuList(setting[category])) {
        final entry = bawuMap(item);
        if (!bawuFlag(entry['switch'])) continue;
        final perm = BawuPermType.fromPermId(parseInt(entry['perm']));
        if (perm != null) perms = perms | perm;
      }
    }
    return BawuPerm(
      user: BawuPermUser.fromJson(bawuMap(json['user'])),
      perms: perms,
    );
  }
}
