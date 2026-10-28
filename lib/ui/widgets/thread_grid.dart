import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/feed.dart';
import '../../data/protocol_browse_repository.dart';
import '../thread_page.dart';
import 'thread_card.dart';
import 'thread_open_container.dart';

/// Responsive masonry wall for threads that are not inside their forum page.
class ThreadGrid extends StatelessWidget {
  const ThreadGrid({
    super.key,
    required this.feed,
    required this.repo,
  });

  final ThreadFeed feed;
  final ProtocolBrowseRepository repo;

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
            final author = feed.users[thread.authorId];
            return ThreadOpenContainer(
              closedBuilder: (context, open) => ThreadCard(
                thread: thread,
                authorName: author?.displayName,
                authorAvatar: author?.avatarUrl,
                forumName: thread.forumName,
                forumRepo: repo,
                showForumChip: true,
                onTap: open,
              ),
              openBuilder: (context) => ThreadPage(
                tid: thread.tid,
                title: thread.title,
                forumName: thread.forumName,
                authorName: author?.displayName,
              ),
            );
          },
        );
      },
    );
  }
}