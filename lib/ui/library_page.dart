import 'package:flutter/material.dart';

import '../core/local_library.dart';
import 'format.dart';
import 'forum_page.dart';
import 'thread_page.dart';
import 'widgets/empty_state.dart';

/// Local-only history and favorites, available without an account.
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialTab,
      child: AnimatedBuilder(
        animation: LocalLibrary.instance,
        builder: (context, _) {
          final library = LocalLibrary.instance;
          return Scaffold(
            appBar: AppBar(
              title: const Text('我的空间'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: '历史 ${library.historyCount}'),
                  Tab(text: '收藏 ${library.favoriteCount}'),
                  Tab(text: '关注 ${library.followedForums.length}'),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _LibraryList(
                  items: library.history,
                  emptyTitle: '还没有浏览记录',
                  emptyDescription: '看过的帖子会保存在这里，无需登录。',
                  icon: Icons.history_rounded,
                  trailingIcon: Icons.close_rounded,
                  trailingTooltip: '删除记录',
                  onRemove: (item) => library.removeHistory(item.tid),
                  onTap: (item) => _openThread(context, item),
                ),
                _LibraryList(
                  items: library.favorites,
                  emptyTitle: '还没有收藏',
                  emptyDescription: '在帖子右上角点收藏，稍后可以从这里继续看。',
                  icon: Icons.bookmark_border_rounded,
                  trailingIcon: Icons.bookmark_remove_outlined,
                  trailingTooltip: '取消收藏',
                  onRemove: (item) => library.removeFavorite(item.tid),
                  onTap: (item) => _openThread(context, item),
                ),
                _FollowedForumsList(items: library.followedForums),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openThread(BuildContext context, LocalThread item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadPage(
          tid: item.tid,
          title: item.title,
          forumName: item.forumName,
          authorName: item.authorName,
        ),
      ),
    );
  }
}

class _FollowedForumsList extends StatelessWidget {
  const _FollowedForumsList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.people_alt_outlined,
        title: '还没有关注任何吧',
        description: '进入吧页点关注，关注列表会保存在本机，登录后可同步账号。',
        action: OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('去逛吧'),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      itemCount: items.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 2),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '本地关注 · 登录后同步账号关注',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        final name = items[index - 1];
        return Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => ForumPage(forumName: name),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      name.isEmpty ? '吧' : name.substring(0, 1),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: '取消关注',
                    onPressed: () =>
                        LocalLibrary.instance.toggleForumFollow(name),
                    icon: Icon(
                      Icons.person_remove_outlined,
                      size: 19,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({
    required this.items,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.icon,
    required this.trailingIcon,
    required this.trailingTooltip,
    required this.onRemove,
    required this.onTap,
  });

  final List<LocalThread> items;
  final String emptyTitle;
  final String emptyDescription;
  final IconData icon;
  final IconData trailingIcon;
  final String trailingTooltip;
  final Future<void> Function(LocalThread item) onRemove;
  final void Function(LocalThread item) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (items.isEmpty) {
      return EmptyState(
        icon: icon,
        title: emptyTitle,
        description: emptyDescription,
        action: OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('去逛逛'),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        final time = item.visitedAt > 0
            ? relativeTime((item.visitedAt / 1000).round())
            : '';
        return Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onTap(item),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 19,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          <String>[
                            if (item.forumName.isNotEmpty) item.forumName,
                            if (time.isNotEmpty) time,
                            if (item.authorName?.isNotEmpty == true)
                              item.authorName!,
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: trailingTooltip,
                    onPressed: () => onRemove(item),
                    icon: Icon(
                      trailingIcon,
                      size: 19,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
