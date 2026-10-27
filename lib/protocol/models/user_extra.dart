import '../generated/generated.dart' as pb;
import 'notification.dart';

/// A user in the legacy (mute) blacklist.
class BlacklistOldUser {
  const BlacklistOldUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameOld,
    required this.untilTime,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameOld;
  final int untilTime;

  String get displayName => nickNameOld.isNotEmpty ? nickNameOld : userName;

  DateTime? get untilDateTime => untilTime == 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch(untilTime * 1000);
}

class TiebaBlacklistOld {
  const TiebaBlacklistOld({required this.objs, required this.page});

  final List<BlacklistOldUser> objs;
  final NotificationPage page;

  bool get hasMore => page.hasMore;
}

/// A forum hidden from the homepage recommendation feed.
class DislikeForum {
  const DislikeForum({
    required this.fid,
    required this.fname,
    required this.memberNum,
    required this.postNum,
    required this.threadNum,
  });

  final int fid;
  final String fname;
  final int memberNum;
  final int postNum;
  final int threadNum;
}

class DislikeForumsPage {
  const DislikeForumsPage({
    required this.currentPage,
    required this.hasMore,
    required this.hasPrev,
  });

  final int currentPage;
  final bool hasMore;
  final bool hasPrev;

  factory DislikeForumsPage.fromProto(pb.GetDislikeListResIdl_DataRes proto) {
    return DislikeForumsPage(
      currentPage: proto.curPage,
      hasMore: proto.hasMore != 0,
      hasPrev: proto.curPage > 1,
    );
  }
}

class TiebaDislikeForums {
  const TiebaDislikeForums({required this.objs, required this.page});

  final List<DislikeForum> objs;
  final DislikeForumsPage page;

  bool get hasMore => page.hasMore;
}

/// Forum statistics series (moderator endpoint), oldest to newest.
class TiebaStatistics {
  const TiebaStatistics({
    required this.view,
    required this.thread,
    required this.newMember,
    required this.post,
    required this.signRatio,
    required this.avgTime,
    required this.avgTimes,
    required this.recommend,
  });

  final List<int> view;
  final List<int> thread;
  final List<int> newMember;
  final List<int> post;
  final List<int> signRatio;
  final List<int> avgTime;
  final List<int> avgTimes;
  final List<int> recommend;
}
