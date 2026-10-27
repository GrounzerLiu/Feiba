import '../core/enums.dart';
import 'contents.dart';
import 'thread.dart';
import 'user.dart';

/// A thread shown on a user's homepage.
class HomepageThread {
  const HomepageThread({
    required this.contents,
    required this.title,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.user,
    required this.replyNum,
    required this.agreeNum,
    required this.createTime,
    this.type = ThreadType.unknown,
    this.viewNum = 0,
    this.shareNum = 0,
    this.voteInfo,
  });

  final Contents contents;
  final String title;
  final int fid;
  final String fname;
  final int tid;
  final int pid;
  final TiebaUser? user;
  final int replyNum;
  final int agreeNum;
  final int createTime;
  final ThreadType type;
  final int viewNum;
  final int shareNum;
  final VoteInfo? voteInfo;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  String get preview => contents.isNotEmpty ? contents.displayText : title;
}

/// A user profile plus their recent threads.
class TiebaHomepage {
  const TiebaHomepage({required this.user, required this.threads});

  final TiebaUser? user;
  final List<HomepageThread> threads;

  bool get isEmpty => threads.isEmpty;

  factory TiebaHomepage.empty() =>
      const TiebaHomepage(user: null, threads: <HomepageThread>[]);
}
