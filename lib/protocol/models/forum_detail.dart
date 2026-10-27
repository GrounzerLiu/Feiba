import 'page.dart';

/// Detailed forum information from the forum-detail endpoint.
class TiebaForumDetail {
  const TiebaForumDetail({
    required this.fid,
    required this.fname,
    required this.category,
    required this.smallAvatar,
    required this.originAvatar,
    required this.slogan,
    required this.memberNum,
    required this.postNum,
    required this.hasBawu,
  });

  final int fid;
  final String fname;
  final String category;
  final String smallAvatar;
  final String originAvatar;
  final String slogan;
  final int memberNum;
  final int postNum;
  final bool hasBawu;

  String? get avatarUrl => smallAvatar.isEmpty ? null : smallAvatar;
}

/// The current account's level in a forum.
class TiebaForumLevel {
  const TiebaForumLevel({
    required this.levelName,
    required this.userLevel,
    required this.isLike,
  });

  final String levelName;
  final int userLevel;
  final bool isLike;
}

/// A forum in the forum square.
class TiebaSquareForum {
  const TiebaSquareForum({
    required this.fid,
    required this.fname,
    required this.memberNum,
    required this.threadNum,
    required this.isFollowed,
  });

  final int fid;
  final String fname;
  final int memberNum;
  final int threadNum;
  final bool isFollowed;
}

class TiebaSquareForums {
  const TiebaSquareForums({required this.objs, required this.page});

  final List<TiebaSquareForum> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
}

/// Monthly recommendation quota for a forum moderator.
class TiebaRecomStatus {
  const TiebaRecomStatus({required this.total, required this.used});

  final int total;
  final int used;

  int get remaining => total - used;
}
