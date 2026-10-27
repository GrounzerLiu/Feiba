import '../core/utils.dart';

/// A forum in the current account's follow list (forum-guide response).
class SelfFollowForum {
  const SelfFollowForum({
    required this.fid,
    required this.fname,
    required this.level,
    required this.isSigned,
    required this.todayThreadNum,
    required this.hotNum,
    required this.memberCount,
    required this.threadNum,
  });

  final int fid;
  final String fname;
  final int level;
  final bool isSigned;
  final int todayThreadNum;
  final int hotNum;
  final int memberCount;
  final int threadNum;

  factory SelfFollowForum.fromJson(Map<String, dynamic> json) {
    return SelfFollowForum(
      fid: parseInt(json['forum_id']),
      fname: parseString(json['forum_name']),
      level: parseInt(json['level_id']),
      isSigned: json['is_sign'] == true || parseInt(json['is_sign']) != 0,
      todayThreadNum: parseInt(json['day_thread_num']),
      hotNum: parseInt(json['hot_num']),
      memberCount: parseInt(json['member_count']),
      threadNum: parseInt(json['thread_num']),
    );
  }
}

class TiebaSelfFollowForums {
  const TiebaSelfFollowForums({required this.objs});

  final List<SelfFollowForum> objs;

  factory TiebaSelfFollowForums.fromJson(Map<String, dynamic> json) {
    final list = json['like_forum'];
    return TiebaSelfFollowForums(
      objs: list is List
          ? <SelfFollowForum>[
              for (final item in list.whereType<Map>())
                SelfFollowForum.fromJson(item.cast<String, dynamic>()),
            ]
          : const <SelfFollowForum>[],
    );
  }
}
