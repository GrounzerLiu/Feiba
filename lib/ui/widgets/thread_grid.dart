import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/feed.dart';
import '../../data/models/forum_page.dart';
import '../../data/protocol_browse_repository.dart';
import 'thread_card.dart';

/// Responsive masonry wall for threads that are not inside their forum page.
///
/// The column count follows the available width, while the masonry delegate
/// keeps cards of different heights tightly packed.
class ThreadGrid extends StatelessWidget {
  const ThreadGrid({
    super.key,
    required this.feed,
    required this.repo,
    required this.onThreadTap,
    required this.onForumTap,
  });

  final ThreadFeed feed;
  final ProtocolBrowseRepository repo;
  final ValueChanged<ThreadSummary>? onThreadTap;
  final ValueChanged<String> onForumTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / 300).floor().clamp(1, 4);
        return MasonryGridView.count(
          crossAxisCount: columns,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feed.threads.length,
          itemBuilder: (context, index) {
            final thread = feed.threads[index];
            return ThreadCard(
              thread: thread,
              authorName: feed.users[thread.authorId]?.displayName,
              authorAvatar: feed.users[thread.authorId]?.avatarUrl,
              forumName: thread.forumName,
              forumRepo: repo,
              showForumChip: true,
              onForumTap: () => onForumTap(thread.forumName),
              onTap: () => onThreadTap?.call(thread),
            );
          },
        );
      },
    );
  }
}
