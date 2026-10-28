import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import '../core/image_cache.dart';

import '../data/models/feed.dart';
import '../data/models/forum_page.dart';
import '../data/models/forum_summary.dart';
import '../data/models/hot_topic.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'format.dart';
import 'forum_page.dart';
import 'search_page.dart';
import 'thread_page.dart';
import 'widgets/forum_avatar.dart';
import 'widgets/morphing_shape.dart';
import 'widgets/thread_card.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key, this.loadFeed = true});

  final bool loadFeed;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();

  static const List<_Category> _categories = <_Category>[
    _Category('游戏', Icons.sports_esports_rounded, Color(0xFF5B8DEF)),
    _Category('动漫', Icons.auto_awesome_rounded, Color(0xFF8A6BE8)),
    _Category('数码', Icons.devices_rounded, Color(0xFF3FAE8F)),
    _Category('体育', Icons.sports_basketball_rounded, Color(0xFFE08A4D)),
    _Category('摄影', Icons.camera_alt_rounded, Color(0xFF4C9DBD)),
    _Category('旅游', Icons.flight_takeoff_rounded, Color(0xFFD9647A)),
    _Category('娱乐', Icons.local_fire_department_rounded, Color(0xFFC76A9E)),
  ];

  List<ForumSummary> _hotForums = const <ForumSummary>[];
  List<HotTopic> _topics = const <HotTopic>[];
  List<ForumSummary> _recommended = const <ForumSummary>[];
  ThreadFeed _hotFeed = ThreadFeed.empty;
  String _category = '游戏';
  bool _loading = false;
  bool _categoryLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.loadFeed) _load();
  }

  Future<void> _load() async {
    if (!widget.loadFeed || _loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    List<ForumSummary> hot = const <ForumSummary>[];
    List<HotTopic> topics = const <HotTopic>[];
    List<ForumSummary> recommended = const <ForumSummary>[];
    ThreadFeed hotFeed = ThreadFeed.empty;
    Object? failure;

    try {
      final page = await _repo.squareForums('热门', rn: 10);
      hot = page.items;
    } catch (error) {
      failure = error;
    }
    try {
      topics = await _repo.hotTopics();
    } catch (error) {
      failure ??= error;
    }
    try {
      final page = await _repo.squareForums(_category, rn: 6);
      recommended = page.items;
    } catch (error) {
      failure ??= error;
    }

    if (hot.isNotEmpty) {
      final sources = hot.take(3).map((forum) => forum.name).toList();
      final feeds = await Future.wait(
        sources.map((name) async {
          try {
            return await _repo.forumFeed(name, limit: 10, hot: true);
          } catch (_) {
            return ThreadFeed.empty;
          }
        }),
      );
      final threads = <ThreadSummary>[];
      final users = <int, TiebaUser>{};
      final seen = <int>{};
      for (final source in feeds) {
        users.addAll(source.users);
        for (final thread in source.threads) {
          if (thread.tid == 0 || !seen.add(thread.tid)) continue;
          threads.add(thread);
        }
      }
      threads.sort((a, b) => b.replyNum.compareTo(a.replyNum));
      hotFeed = ThreadFeed(
        threads: threads.take(10).toList(growable: false),
        users: users,
      );
    }

    if (!mounted) return;
    setState(() {
      _hotForums = hot;
      _topics = topics;
      _recommended = recommended;
      _hotFeed = hotFeed;
      _loading = false;
      _error =
          hot.isEmpty &&
              topics.isEmpty &&
              recommended.isEmpty &&
              failure != null
          ? failure.toString()
          : null;
    });
  }

  Future<void> _selectCategory(String category) async {
    if (category == _category) return;
    setState(() {
      _category = category;
      _categoryLoading = true;
      _recommended = const <ForumSummary>[];
    });
    try {
      final page = await _repo.squareForums(category, rn: 6);
      if (!mounted) return;
      setState(() => _recommended = page.items);
    } catch (_) {
      if (!mounted) return;
      setState(() => _recommended = const <ForumSummary>[]);
    } finally {
      if (mounted) setState(() => _categoryLoading = false);
    }
  }

  void _openForum(String name) => Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: name)));

  void _openThread(ThreadSummary thread) {
    final author = _hotFeed.users[thread.authorId];
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadPage(
          tid: thread.tid,
          title: thread.title,
          forumName: thread.forumName,
          authorName: author?.displayName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 4,
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
                            '话题榜、推荐、热吧和热帖',
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
                      onPressed: _load,
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
              ),
            ),
            const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              tabs: <Widget>[
                Tab(text: '话题'),
                Tab(text: '推荐'),
                Tab(text: '热吧'),
                Tab(text: '热帖'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _topicTab(),
                  _recommendTab(),
                  _forumRankTab(),
                  _hotPostsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicTab() {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              '来自贴吧话题榜的真实排名',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (_loading && _topics.isEmpty)
            const _ListSkeleton()
          else if (_topics.isEmpty)
            const _EmptyCard(text: '话题榜暂时没有数据。')
          else
            for (var i = 0; i < _topics.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _HotTopicCard(
                  topic: _topics[i],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          SearchPage(initialKeyword: _topics[i].name),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _forumRankTab() {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              '来自吧广场热门分类，按当前热度排序',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (_loading && _hotForums.isEmpty)
            const _ListSkeleton()
          else if (_error != null && _hotForums.isEmpty)
            _ErrorCard(message: _error!, onRetry: _load)
          else if (_hotForums.isEmpty)
            const _EmptyCard(text: '热门吧暂时没有数据。')
          else
            for (var i = 0; i < _hotForums.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _HotForumCard(
                  rank: i + 1,
                  repo: _repo,
                  forum: _hotForums[i],
                  onTap: () => _openForum(_hotForums[i].name),
                ),
              ),
        ],
      ),
    );
  }

  Widget _recommendTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      children: <Widget>[
        Text(
          '按分类发现真实贴吧',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final category in _categories)
              ChoiceChip(
                avatar: Icon(
                  category.icon,
                  size: 16,
                  color: _category == category.title
                      ? theme.colorScheme.onSecondaryContainer
                      : category.color,
                ),
                label: Text(category.title),
                selected: _category == category.title,
                onSelected: (_) => _selectCategory(category.title),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (_categoryLoading)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_recommended.isEmpty)
          const _EmptyCard(text: '这个分类暂时没有推荐吧。')
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemCount: _recommended.length,
            itemBuilder: (context, index) {
              final forum = _recommended[index];
              return _RecommendedForumCard(
                repo: _repo,
                forum: forum,
                onTap: () => _openForum(forum.name),
              );
            },
          ),
      ],
    );
  }

  Widget _hotPostsTab() {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              '热门吧里正在被回复的帖子',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (_loading && _hotFeed.threads.isEmpty)
            const _ThreadSkeleton()
          else if (_hotFeed.threads.isEmpty)
            const _EmptyCard(text: '热帖暂时没有数据。')
          else
            for (final thread in _hotFeed.threads)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ThreadCard(
                  thread: thread,
                  authorName: _hotFeed.users[thread.authorId]?.displayName,
                  authorAvatar: _hotFeed.users[thread.authorId]?.avatarUrl,
                  forumName: thread.forumName,
                  onTap: () => _openThread(thread),
                ),
              ),
        ],
      ),
    );
  }
}

class _HotTopicCard extends StatelessWidget {
  const _HotTopicCard({required this.topic, required this.onTap});

  final HotTopic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = topic.imageUrl;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 11, 10, 11),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 26,
                child: Text(
                  '${topic.rank}',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: topic.rank <= 3
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      topic.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    if (topic.description.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 4),
                      Text(
                        topic.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        if (topic.discussNum > 0)
                          Text(
                            '${compactCount(topic.discussNum)} 讨论',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        if (topic.isVideo) ...<Widget>[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.play_circle_outline_rounded,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '视频',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (image != null && image.isNotEmpty) ...<Widget>[
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    cacheManager: FeibaImageCache.managerFor(image),
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 120),
                    placeholder: (_, _) =>
                        const SizedBox(width: 62, height: 62),
                    errorWidget: (_, _, _) =>
                        const SizedBox(width: 62, height: 62),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HotForumCard extends StatelessWidget {
  const _HotForumCard({
    required this.rank,
    required this.repo,
    required this.forum,
    required this.onTap,
  });

  final int rank;
  final ProtocolBrowseRepository repo;
  final ForumSummary forum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final detail = forum.memberNum > 0
        ? '${compactCount(forum.memberNum)} 成员'
        : forum.threadNum > 0
        ? '${compactCount(forum.threadNum)} 帖子'
        : '进入贴吧';
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 28,
                child: Text(
                  '$rank',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: rank <= 3
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              ForumAvatar(name: forum.name, repo: repo, size: 40),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      forum.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (forum.isFollowed)
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    '已关注',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedForumCard extends StatelessWidget {
  const _RecommendedForumCard({
    required this.repo,
    required this.forum,
    required this.onTap,
  });

  final ProtocolBrowseRepository repo;
  final ForumSummary forum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ForumAvatar(name: forum.name, repo: repo, size: 34),
                  const Spacer(),
                  if (forum.isFollowed)
                    Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                forum.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                forum.memberNum > 0
                    ? '${compactCount(forum.memberNum)} 成员'
                    : '进入贴吧',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
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

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final line = theme.colorScheme.surfaceContainerHighest;
    return Column(
      children: <Widget>[
        for (var i = 0; i < 4; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: line,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Container(height: 12, color: line)),
              ],
            ),
          ),
      ],
    );
  }
}

class _ThreadSkeleton extends StatelessWidget {
  const _ThreadSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final line = theme.colorScheme.surfaceContainerHighest;
    return Column(
      children: <Widget>[
        for (var i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: 120, height: 12, color: line),
                const SizedBox(height: 12),
                Container(width: double.infinity, height: 14, color: line),
                const SizedBox(height: 8),
                Container(width: 210, height: 10, color: line),
              ],
            ),
          ),
      ],
    );
  }
}

class _Category {
  const _Category(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final Color color;
}
