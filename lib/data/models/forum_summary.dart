/// A lightweight forum entry for followed/visited/discovery lists.
class ForumSummary {
  const ForumSummary({
    required this.fid,
    required this.name,
    this.memberNum = 0,
    this.threadNum = 0,
    this.isFollowed = false,
    this.level = 0,
    this.hotNum = 0,
    this.todayThreadNum = 0,
    this.isSigned = false,
    this.isLocal = false,
  });

  final int fid;
  final String name;
  final int memberNum;
  final int threadNum;
  final bool isFollowed;
  final int level;
  final int hotNum;
  final int todayThreadNum;
  final bool isSigned;

  /// True for a guest-only local follow that is not synced to the account.
  final bool isLocal;

  String get displayName => name;
}

class ForumSquarePage {
  const ForumSquarePage({required this.items, required this.hasMore});

  final List<ForumSummary> items;
  final bool hasMore;
}
