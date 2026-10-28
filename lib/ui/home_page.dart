import 'package:flutter/material.dart';

import '../core/local_library.dart';
import '../core/session.dart';
import '../data/models/forum_page.dart';
import '../data/protocol_browse_repository.dart';
import 'forum_page.dart';
import 'login_page.dart';
import 'search_page.dart';
import 'thread_page.dart';
import 'widgets/section_header.dart';
import 'widgets/thread_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.loadFeed = true});

  /// Allows widget tests to render the static shell without network I/O.
  final bool loadFeed;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();

  List<ThreadSummary> _threads = const <ThreadSummary>[];
  Map<int, dynamic> _users = const <int, dynamic>{};
  bool _loading = false;
  String? _error;

  static const List<_HotForum> _hotForums = <_HotForum>[
    _HotForum('原神', '游戏', Color(0xFF5B8DEF), Icons.sports_esports_rounded),
    _HotForum('孙笑川', '人物', Color(0xFFE08A4D), Icons.record_voice_over_rounded),
    _HotForum('李毅', '体育', Color(0xFF3FAE8F), Icons.sports_soccer_rounded),
    _HotForum('steam', '游戏', Color(0xFF4C6E9E), Icons.videogame_asset_rounded),
    _HotForum('明日方舟', '游戏', Color(0xFF7C6CF2), Icons.auto_awesome_rounded),
    _HotForum('崩坏星穹铁道', '游戏', Color(0xFFD9647A), Icons.rocket_launch_rounded),
  ];

  @override
  void initState() {
    super.initState();
    LocalLibrary.instance.addListener(_onLibraryChanged);
    if (widget.loadFeed) _load();
  }

  @override
  void dispose() {
    LocalLibrary.instance.removeListener(_onLibraryChanged);
    super.dispose();
  }

  void _onLibraryChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _repo.forumPage('原神');
      if (!mounted) return;
      setState(() {
        _threads = page.threads.take(8).toList(growable: false);
        _users = page.users;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openForum(String name) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: name)));
  }

  void _openSearch() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const SearchPage()));
  }

  void _openThread(ThreadSummary thread) {
    final author = _users[thread.authorId];
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadPage(
          tid: thread.tid,
          title: thread.title,
          forumName: '原神吧',
          authorName: author?.displayName as String?,
        ),
      ),
    );
  }

  Future<void> _openAccount() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loggedIn = Session.instance.isLoggedIn;
    final followed = LocalLibrary.instance.followedForums;
    final shortcuts = <_HotForum>[
      for (final name in followed)
        _HotForum(name, '已关注', theme.colorScheme.primary, Icons.star_rounded),
      ..._hotForums.where((forum) => !followed.contains(forum.name)),
    ];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 14, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('贴吧', style: theme.textTheme.headlineSmall),
                            const SizedBox(height: 4),
                            Text(
                              '来看看今天大家在聊什么',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip: loggedIn ? '账号' : '登录',
                        onPressed: _openAccount,
                        icon: Icon(
                          loggedIn
                              ? Icons.account_circle_rounded
                              : Icons.account_circle_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: _SearchEntry(onTap: _openSearch),
              ),
            ),
            if (LocalLibrary.instance.history.isNotEmpty) ...<Widget>[
              const SliverToBoxAdapter(
                child: SectionHeader(title: '最近浏览', subtitle: '从上次停下的地方继续'),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 82,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: LocalLibrary.instance.history.take(6).length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = LocalLibrary.instance.history[index];
                      return _RecentThreadCard(
                        item: item,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ThreadPage(
                              tid: item.tid,
                              title: item.title,
                              forumName: item.forumName,
                              authorName: item.authorName,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            const SliverToBoxAdapter(
              child: SectionHeader(title: '常逛的吧', subtitle: '挑一个感兴趣的角落'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 116,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: shortcuts.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final forum = shortcuts[index];
                    return _ForumShortcut(
                      forum: forum,
                      onTap: () => _openForum(forum.name),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: '热门讨论',
                subtitle: '来自原神吧的实时动态',
                action: '换一换',
                onAction: _load,
              ),
            ),
            if (_loading && _threads.isEmpty)
              const SliverToBoxAdapter(child: _ThreadSkeleton())
            else if (_error != null && _threads.isEmpty)
              SliverToBoxAdapter(
                child: _ErrorCard(message: _error!, onRetry: _load),
              )
            else if (_threads.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text('这个吧暂时还没有帖子', textAlign: TextAlign.center),
                ),
              )
            else
              SliverList.builder(
                itemCount: _threads.length,
                itemBuilder: (context, index) {
                  final thread = _threads[index];
                  final user = _users[thread.authorId];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                    child: ThreadCard(
                      thread: thread,
                      authorName: user?.displayName as String?,
                      authorAvatar: user?.avatarUrl as String?,
                      forumName: '原神吧',
                      onTap: () => _openThread(thread),
                    ),
                  );
                },
              ),
            SliverToBoxAdapter(
              child: SectionHeader(title: '探索更多', subtitle: '从这些方向开始'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final topic in <String>[
                      '游戏',
                      '二次元',
                      '数码',
                      '体育',
                      '生活',
                      '摄影',
                    ])
                      ActionChip(
                        label: Text(topic),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => SearchPage(initialKeyword: topic),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _RecentThreadCard extends StatelessWidget {
  const _RecentThreadCard({required this.item, required this.onTap});

  final LocalThread item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 210,
          padding: const EdgeInsets.fromLTRB(13, 11, 13, 10),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge,
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.history_rounded,
                    size: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.forumName.isEmpty ? '浏览过的帖子' : item.forumName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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

class _SearchEntry extends StatelessWidget {
  const _SearchEntry({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: <Widget>[
              Icon(Icons.search_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '搜索贴吧，或直接输入吧名',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary.withValues(alpha: 0.75),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: theme.colorScheme.primary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForumShortcut extends StatelessWidget {
  const _ForumShortcut({required this.forum, required this.onTap});

  final _HotForum forum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 146,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: forum.color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(forum.icon, size: 20, color: forum.color),
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
                forum.tag,
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
            margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
            padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: line,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      width: 112,
                      height: 10,
                      decoration: BoxDecoration(
                        color: line,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 48,
                      height: 9,
                      decoration: BoxDecoration(
                        color: line.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: line,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 190,
                  height: 10,
                  decoration: BoxDecoration(
                    color: line.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 82,
                  decoration: BoxDecoration(
                    color: line.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ],
            ),
          ),
      ],
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
      margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
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
            child: Text('加载失败，检查网络后再试', style: theme.textTheme.bodySmall),
          ),
          TextButton(onPressed: onRetry, child: const Text('重试')),
        ],
      ),
    );
  }
}

class _HotForum {
  const _HotForum(this.name, this.tag, this.color, this.icon);

  final String name;
  final String tag;
  final Color color;
  final IconData icon;
}
