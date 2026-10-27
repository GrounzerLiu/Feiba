/// A user's membership details inside one forum.
class TiebaUserForumInfo {
  const TiebaUserForumInfo({
    required this.userId,
    required this.portrait,
    required this.showName,
    required this.isLike,
    required this.fname,
    required this.smallAvatar,
    required this.isFollow,
    required this.followDays,
    required this.signDays,
    required this.threadNum,
    required this.dayPostNum,
    required this.daySignRank,
    required this.level,
    required this.levelName,
    required this.exp,
    required this.levelupExp,
    required this.roleName,
    required this.highLightSignDays,
  });

  final int userId;
  final String portrait;
  final String showName;
  final bool isLike;
  final String fname;
  final String smallAvatar;
  final bool isFollow;
  final int followDays;
  final int signDays;
  final int threadNum;
  final int dayPostNum;
  final int daySignRank;
  final int level;
  final String levelName;
  final int exp;
  final int levelupExp;
  final String roleName;
  final int highLightSignDays;
}
