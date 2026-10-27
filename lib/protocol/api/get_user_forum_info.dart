import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/user_forum_info.dart';

Future<TiebaUserForumInfo> fetchUserForumInfo(
  TiebaHttpCore http, {
  required int fid,
  required String portrait,
}) async {
  final json = await http.postForm(
    '/c/f/forum/getUserForumLevelInfo',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('forum_id', '$fid'),
      MapEntry<String, String>('friend_portrait', portrait),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('user forum info is missing');
  }
  final map = data.cast<String, dynamic>();
  final user = map['user_info'];
  final userForum = map['user_forum_info'];
  final forum = map['forum_info'];
  if (user is! Map || userForum is! Map || forum is! Map) {
    throw const TiebaFormatException('user forum info is incomplete');
  }
  final userMap = user.cast<String, dynamic>();
  final userForumMap = userForum.cast<String, dynamic>();
  final forumMap = forum.cast<String, dynamic>();
  return TiebaUserForumInfo(
    userId: parseInt(userMap['id']),
    portrait: normalizePortrait(parseString(userMap['portrait'])),
    showName: parseString(userMap['name']),
    isLike: parseInt(userMap['is_like']) != 0,
    fname: parseString(forumMap['forum_name']),
    smallAvatar: parseString(forumMap['forum_avatar']),
    isFollow: parseInt(userForumMap['is_follow']) != 0,
    followDays: parseInt(userForumMap['follow_days']),
    signDays: parseInt(userForumMap['sign_days']),
    threadNum: parseInt(userForumMap['thread_num']),
    dayPostNum: parseInt(userForumMap['day_post_num']),
    daySignRank: parseInt(userForumMap['day_sign_no']),
    level: parseInt(userForumMap['level_id']),
    levelName: parseString(userForumMap['level_name']),
    exp: parseInt(userForumMap['cur_score']),
    levelupExp: parseInt(userForumMap['levelup_score']),
    roleName: parseString(userForumMap['role_name']),
    highLightSignDays: parseInt(userForumMap['high_light_sign_days']),
  );
}
