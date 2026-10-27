import '../core/enums.dart';
import '../core/utils.dart';

/// A user entry in follow/fan lists.
class FollowUser {
  const FollowUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;

  String get displayName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String? get avatarUrl => portrait.isEmpty
      ? null
      : 'https://himg.bdimg.com/sys/portrait/item/$portrait';

  factory FollowUser.fromJson(Map<String, dynamic> json) {
    return FollowUser(
      userId: parseInt(json['id']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name']),
      nickNameNew: parseString(json['name_show']),
    );
  }
}

/// Pagination for follow/fan lists.
class FollowPage {
  const FollowPage({
    required this.currentPage,
    required this.totalCount,
    required this.hasMore,
    required this.hasPrev,
  });

  final int currentPage;
  final int totalCount;
  final bool hasMore;
  final bool hasPrev;

  factory FollowPage.fromJson(Map<String, dynamic> json) {
    final current = parseInt(json['pn']);
    return FollowPage(
      currentPage: current,
      totalCount: parseInt(json['total_follow_num']),
      hasMore: _asBool(json['has_more']),
      hasPrev: current > 1,
    );
  }

  /// Parses the nested `page` object returned by the fans endpoint.
  factory FollowPage.fromFanJson(Map<String, dynamic> json) {
    return FollowPage(
      currentPage: parseInt(json['current_page']),
      totalCount: parseInt(json['total_count']),
      hasMore: _asBool(json['has_more']),
      hasPrev: _asBool(json['has_prev']),
    );
  }
}

class TiebaFollows {
  const TiebaFollows({required this.objs, required this.page});

  final List<FollowUser> objs;
  final FollowPage page;

  bool get hasMore => page.hasMore;

  factory TiebaFollows.fromJson(Map<String, dynamic> json) {
    final list = json['follow_list'];
    return TiebaFollows(
      objs: list is List
          ? <FollowUser>[
              for (final item in list.whereType<Map>())
                FollowUser.fromJson(item.cast<String, dynamic>()),
            ]
          : const <FollowUser>[],
      page: FollowPage.fromJson(json),
    );
  }
}

class TiebaFans {
  const TiebaFans({required this.objs, required this.page});

  final List<FollowUser> objs;
  final FollowPage page;

  bool get hasMore => page.hasMore;

  factory TiebaFans.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? (json['data'] as Map).cast<String, dynamic>()
        : json;
    final list = data['user_list'] ?? data['fans_list'] ?? data['follow_list'];
    final page = data['page'] is Map
        ? FollowPage.fromFanJson((data['page'] as Map).cast<String, dynamic>())
        : const FollowPage(
            currentPage: 0,
            totalCount: 0,
            hasMore: false,
            hasPrev: false,
          );
    return TiebaFans(
      objs: list is List
          ? <FollowUser>[
              for (final item in list.whereType<Map>())
                FollowUser.fromJson(item.cast<String, dynamic>()),
            ]
          : const <FollowUser>[],
      page: page,
    );
  }
}

/// A user in the new-format blacklist.
class BlacklistUser {
  const BlacklistUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
    required this.types,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;
  final Set<BlacklistType> types;

  String get displayName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String? get avatarUrl => portrait.isEmpty
      ? null
      : 'https://himg.bdimg.com/sys/portrait/item/$portrait';

  factory BlacklistUser.fromJson(Map<String, dynamic> json) {
    final perm = json['perm_list'];
    final permMap = perm is Map
        ? perm.cast<String, dynamic>()
        : <String, dynamic>{};
    final types = <BlacklistType>{};
    if (parseInt(permMap['follow']) != 0) types.add(BlacklistType.follow);
    if (parseInt(permMap['chat']) != 0) types.add(BlacklistType.chat);
    if (parseInt(permMap['interact']) != 0) types.add(BlacklistType.interact);
    return BlacklistUser(
      userId: parseInt(json['uid']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['user_name']),
      nickNameNew: parseString(json['name_show']),
      types: types,
    );
  }
}

class TiebaBlacklist {
  const TiebaBlacklist({required this.objs});

  final List<BlacklistUser> objs;

  factory TiebaBlacklist.fromJson(Map<String, dynamic> json) {
    final list = json['user_perm_list'];
    return TiebaBlacklist(
      objs: list is List
          ? <BlacklistUser>[
              for (final item in list.whereType<Map>())
                BlacklistUser.fromJson(item.cast<String, dynamic>()),
            ]
          : const <BlacklistUser>[],
    );
  }
}

/// A forum followed by a user.
class FollowForum {
  const FollowForum({
    required this.fid,
    required this.fname,
    required this.level,
    required this.exp,
  });

  final int fid;
  final String fname;
  final int level;
  final int exp;

  factory FollowForum.fromJson(Map<String, dynamic> json) {
    return FollowForum(
      fid: parseInt(json['id']),
      fname: parseString(json['name']),
      level: parseInt(json['level_id']),
      exp: parseInt(json['cur_score']),
    );
  }
}

class TiebaFollowForums {
  const TiebaFollowForums({required this.objs, required this.hasMore});

  final List<FollowForum> objs;
  final bool hasMore;

  factory TiebaFollowForums.fromJson(Map<String, dynamic> json) {
    final forumList = json['forum_list'];
    final objs = <FollowForum>[];
    var hasMore = false;
    if (forumList is Map) {
      final map = forumList.cast<String, dynamic>();
      for (final key in <String>['non-gconforum', 'gconforum']) {
        final list = map[key];
        if (list is List) {
          for (final item in list.whereType<Map>()) {
            objs.add(FollowForum.fromJson(item.cast<String, dynamic>()));
          }
        }
      }
      hasMore = parseInt(json['has_more']) != 0;
    }
    return TiebaFollowForums(objs: objs, hasMore: hasMore);
  }
}

bool _asBool(dynamic value) {
  if (value is bool) return value;
  return parseInt(value) != 0;
}
