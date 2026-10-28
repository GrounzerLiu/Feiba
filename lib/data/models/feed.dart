import 'forum_page.dart';
import 'tieba_user.dart';

/// A mixed list of threads and the page-level users they reference.
class ThreadFeed {
  const ThreadFeed({required this.threads, required this.users});

  final List<ThreadSummary> threads;
  final Map<int, TiebaUser> users;

  bool get isEmpty => threads.isEmpty;

  static const ThreadFeed empty = ThreadFeed(
    threads: <ThreadSummary>[],
    users: <int, TiebaUser>{},
  );
}
