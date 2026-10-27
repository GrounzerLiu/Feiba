import 'page.dart';
import 'user.dart';

class LastReplyerThread {
  const LastReplyerThread({
    required this.title,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.author,
    required this.lastReplyer,
    required this.isGood,
    required this.isTop,
    required this.createTime,
    required this.lastTime,
  });

  final String title;
  final int fid;
  final String fname;
  final int tid;
  final int pid;
  final TiebaUser? author;
  final TiebaUser? lastReplyer;
  final bool isGood;
  final bool isTop;
  final int createTime;
  final int lastTime;

  DateTime get lastDateTime =>
      DateTime.fromMillisecondsSinceEpoch(lastTime * 1000);
}

class TiebaLastReplyers {
  const TiebaLastReplyers({
    required this.objs,
    required this.page,
    required this.forumFid,
    required this.forumFname,
  });

  final List<LastReplyerThread> objs;
  final TiebaPage page;
  final int forumFid;
  final String forumFname;

  bool get hasMore => page.hasMore;
}
