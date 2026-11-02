import 'package:material_ui/material_ui.dart';

import '../data/models/feed.dart';
import '../data/models/forum_page.dart';
import '../data/models/hot_board.dart';
import '../data/models/hot_topic.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'format.dart';
import 'forum_page.dart';
import 'route_transitions.dart';
import 'search_page.dart';
import 'thread_page.dart';
import 'widgets/forum_chip.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/morphing_shape.dart';
import 'widgets/name_avatar.dart';
import 'widgets/thread_grid.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key, this.loadFeed = true});

  final bool loadFeed;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();

  ThreadFeed _recommendFeed = ThreadFeed.empty;
  HotBoard? _hotBoard;
  bool _loadingRecommend = false;
  bool _loadingHot = false;
  String? _recommendError;
  String? _hotError;
  String _hotTab = 'all';

  @override
  void initState() {
    super.initState();
    if (widget.loadFeed) {
      _loadRecommend();
      _loadHot(_hotTab);
    }
  }

  Future<void> _loadRecommend() async {
    if (!widget.loadFeed || _loadingRecommend) return;
    setState(() {
      _loadingRecommend = true;
      _recommendError = null;
    });
    try {
      final feed = await _repo.personalizedFeed();
      if (!mounted) return;
      setState(() => _recommendFeed = feed);
    } catch (error) {
      if (!mounted) return;
      setState(() => _recommendError = error.toString());
    } finally {
      if (mounted) setState(() => _loadingRecommend = false);
    }
  }

  Future<void> _loadHot(String tabCode) async {
    if (!widget.loadFeed || _loadingHot) return;
    setState(() {
      _loadingHot = true;
      _hotError = null;
      _hotTab = tabCode;
    });
    try {
      final board = await _repo.hotBoard(tabCode: tabCode);
      if (!mounted) return;
      setState(() => _hotBoard = board);
    } catch (error) {
      if (!mounted) return;
      setState(() => _hotError = error.toString());
    } finally {
      if (mounted) setState(() => _loadingHot = false);
    }
  }

  Future<void> _refreshHot() => _loadHot(_hotTab);

  void _openForum(String name) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: name)),
    );
  }

  void _openThread(ThreadSummary thread) {
    Navigator.of(context).push(
      threadPageRoute<void>(
        ThreadPage(
          tid: thread.tid,
          forumName: thread.forumName.isEmpty ? null : thread.forumName,
        ),
      ),
    );
  }

  void _openTopic(HotTopic topic) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SearchPage(initialKeyword: topic.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 8, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MorphingShape(
                      size: 42,
                      color: theme.colorScheme.primaryContainer,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SearchPage(),
                        ),
                      ),
                      child: Icon(
                        Icons.travel_explore_rounded,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('广场', style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 3),
                          Text(
                            '推荐帖子、热榜话题和热门吧',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: '搜索',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SearchPage(),
                        ),
                      ),
                      icon: const Icon(Icons.search_rounded),
                    ),
                    IconButton(
                      tooltip: '刷新',
                      onPressed: () {
                        _loadRecommend();
                        _refreshHot();
                      },
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
              ),
            ),
            TabBar(
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              tabs: const <Widget>[
                Tab(text: '推荐'),
                Tab(text: '热榜'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _recommendTab(theme),
                  _hotTabView(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendTab(ThemeData theme) {
    return RefreshIndicator(
      onRefresh: _loadRecommend,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          Text(
            '按兴趣推荐的帖子',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          if (_loadingRecommend && _recommendFeed.threads.isEmpty)
            const LoadingIndicator(minHeight: 260)
          else if (_recommendError != null && _recommendFeed.threads.isEmpty)
            _ErrorCard(message: _recommendError!, onRetry: _loadRecommend)
          else if (_recommendFeed.threads.isEmpty)
            const _EmptyCard(text: '暂时没有推荐帖子。')
          else
            ThreadGrid(feed: _recommendFeed, repo: _repo),
        ],
      ),
    );
  }

  Widget _hotTabView(ThemeData theme) {
    final board = _hotBoard;
    return RefreshIndicator(
      onRefresh: _refreshHot,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          if (_loadingHot && board == null)
            const LoadingIndicator(minHeight: 280)
          else if (_hotError != null && board == null)
            _ErrorCard(message: _hotError!, onRetry: _refreshHot)
          else if (board == null)
            const _EmptyCard(text: '热榜暂时没有数据。')
          else ...<Widget>[
            if (board.topics.isNotEmpty) ...<Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '话题榜',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '实时讨论',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  if (_loadingHot)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              _TopicGrid(
                topics: board.topics.take(8).toList(growable: false),
                onTap: _openTopic,
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 10),
            ],
            if (board.tabs.length > 1)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (final tab in board.tabs) ...<Widget>[
                      if (tab.code != board.tabs.first.code)
                        const SizedBox(width: 8),
                      ChoiceChip(
                        label: Text(tab.name),
                        selected: _hotTab == tab.code,
                        onSelected: (_) => _loadHot(tab.code),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              '按内容热度排序',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            if (_loadingHot && board.feed.threads.isEmpty)
              const LoadingIndicator(minHeight: 220)
            else if (board.feed.threads.isEmpty)
              const _EmptyCard(text: '这个榜单暂时没有帖子。')
            else
              for (var index = 0; index < board.feed.threads.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _HotThreadCard(
                    rank: index + 1,
                    thread: board.feed.threads[index],
                    author: board.feed.users[board.feed.threads[index].authorId],
                    repo: _repo,
                    onTap: () => _openThread(board.feed.threads[index]),
                    onForumTap: _openForum,
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _TopicGrid extends StatelessWidget {
  const _TopicGrid({required this.topics, required this.onTap});

  final List<HotTopic> topics;
  final ValueChanged<HotTopic> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topics.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360,
        mainAxisExtent: 38,
        mainAxisSpacing: 4,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final topic = topics[index];
        final rank = topic.rank > 0 ? topic.rank : index + 1;
        final rankColor = rank == 1
            ? theme.colorScheme.error
            : rank == 2
            ? const Color(0xFFE07A2E)
            : rank == 3
            ? const Color(0xFFC49A16)
            : theme.colorScheme.onSurfaceVariant;
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onTap(topic),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 22,
                child: Text(
                  rank.toString(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: rankColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  topic.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              if (topic.tag == 2)
                _TopicTag(text: '热', color: theme.colorScheme.error)
              else if (topic.tag == 1)
                _TopicTag(text: '新', color: const Color(0xFFE07A2E)),
            ],
          ),
        );
      },
    );
  }
}

class _TopicTag extends StatelessWidget {
  const _TopicTag({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _HotThreadCard extends StatelessWidget {
  const _HotThreadCard({
    required this.rank,
    required this.thread,
    required this.author,
    required this.repo,
    required this.onTap,
    required this.onForumTap,
  });

  final int rank;
  final ThreadSummary thread;
  final TiebaUser? author;
  final ProtocolBrowseRepository repo;
  final VoidCallback onTap;
  final ValueChanged<String> onForumTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = author?.displayName ?? '贴吧用户';
    final heat = thread.hotNum > 0 ? thread.hotNum : thread.viewNum;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 22,
                    child: Text(
                      rank.toString(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: rank <= 3
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  NameAvatar(
                    name: name,
                    imageUrl: author?.avatarUrl,
                    size: 26,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (heat > 0)
                    Text(
                      '${compactCount(heat)} 热度',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                thread.title.isEmpty ? '无标题' : thread.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              if (thread.preview.trim().isNotEmpty) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  thread.preview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  if (thread.forumName.isNotEmpty)
                    Flexible(
                      child: ForumChip(
                        name: thread.forumName,
                        repo: repo,
                        dense: true,
                        onPressed: () => onForumTap(thread.forumName),
                      ),
                    ),
                  const Spacer(),
                  Icon(
                    Icons.mode_comment_outlined,
                    size: 15,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    compactCount(thread.replyNum),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 15,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    compactCount(thread.agreeNum),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.cloud_off_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('重试')),
        ],
      ),
    );
  }
}