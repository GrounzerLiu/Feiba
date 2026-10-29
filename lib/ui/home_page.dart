import 'package:material_ui/material_ui.dart';

import '../core/local_library.dart';
import '../core/session.dart';
import '../core/tieba_api.dart';
import '../data/models/feed.dart';
import '../data/models/forum_page.dart';
import '../data/models/forum_summary.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'discover_page.dart';
import 'route_observer.dart';
import 'forum_page.dart';
import 'login_page.dart';
import 'search_page.dart';
import 'user_page.dart';
import 'widgets/forum_chip.dart';
import 'widgets/forum_follow_card.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/morphing_shape.dart';
import 'widgets/name_avatar.dart';
import 'widgets/thread_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.loadFeed = true, this.onExplore});

  final bool loadFeed;
  final VoidCallback? onExplore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();

  bool _loading = false;
  bool _pendingLibraryRefresh = false;
  ModalRoute<void>? _subscribedRoute;
  bool _loggedIn = false;
  String? _error;
  String? _accountWarning;
  List<ForumSummary> _forums = const <ForumSummary>[];
  List<TiebaUser> _people = const <TiebaUser>[];
  ThreadFeed _feed = ThreadFeed.empty;
  List<String> _recentForums = const <String>[];

  late final TabController _tabs = TabController(
    length: 3,
    vsync: this,
    initialIndex: 1,
  );

  @override
  void initState() {
    super.initState();
    LocalLibrary.instance.addListener(_onLibraryChanged);
    _syncLocal();
    if (widget.loadFeed) _load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is ModalRoute<void> && route != _subscribedRoute) {
      if (_subscribedRoute != null) appRouteObserver.unsubscribe(this);
      _subscribedRoute = route;
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void didPopNext() {
    if (_pendingLibraryRefresh) {
      _pendingLibraryRefresh = false;
      _syncLocal();
      setState(() {});
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    LocalLibrary.instance.removeListener(_onLibraryChanged);
    _tabs.dispose();
    super.dispose();
  }

  void _onLibraryChanged() {
    if (!mounted) return;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) {
      _pendingLibraryRefresh = true;
      return;
    }
    _syncLocal();
    setState(() {});
  }

  void _syncLocal() {
    _loggedIn = Session.instance.isLoggedIn;
    _recentForums = LocalLibrary.instance.recentForums;
  }

  Future<void> _load() async {
    if (!widget.loadFeed) {
      _syncLocal();
      setState(() => _loading = false);
      return;
    }
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
      _accountWarning = null;
    });

    final loggedIn = Session.instance.isLoggedIn;
    final accountForums = <ForumSummary>[];
    final accountPeople = <TiebaUser>[];
    String? warning;

    if (loggedIn) {
      try {
        final forums = await TiebaApi.instance.followedForums();
        accountForums.addAll(
          forums.map(
            (forum) => ForumSummary(
              fid: forum.fid,
              name: forum.fname,
              memberNum: forum.memberCount,
              threadNum: forum.threadNum,
              isFollowed: true,
              level: forum.level,
              hotNum: forum.hotNum,
              todayThreadNum: forum.todayThreadNum,
              isSigned: forum.isSigned,
            ),
          ),
        );
      } catch (error) {
        warning = '账号关注同步失败：${tiebaErrorMessage(error)}';
      }
      try {
        final users = await TiebaApi.instance.followedUsers();
        accountPeople.addAll(
          users.map(
            (user) => TiebaUser(
              id: user.userId,
              name: user.userName,
              nameShow: user.nickNameNew,
              portrait: user.portrait,
            ),
          ),
        );
      } catch (error) {
        warning ??= '关注的人同步失败：${tiebaErrorMessage(error)}';
      }
    }

    final localNames = LocalLibrary.instance.followedForums;
    final useLocal = !loggedIn || accountForums.isEmpty;
    final names = <String>[
      if (!useLocal)
        for (final forum in accountForums) forum.name,
      if (useLocal) ...localNames,
    ];
    final uniqueNames = <String>[];
    final seen = <String>{};
    for (final name in names) {
      if (name.trim().isNotEmpty && seen.add(name)) uniqueNames.add(name);
    }

    var forums = accountForums;
    if (useLocal) {
      final resolved = await Future.wait(
        uniqueNames.map((name) async {
          final info = await _repo.forumInfo(name);
          return info ?? ForumSummary(fid: 0, name: name, isLocal: true);
        }),
      );
      forums = resolved
          .where((forum) => forum.name.isNotEmpty)
          .toList(growable: false);
    }

    ThreadFeed feed = ThreadFeed.empty;
    if (uniqueNames.isNotEmpty) {
      final sources = uniqueNames.take(4).toList(growable: false);
      final feeds = await Future.wait(
        sources.map((name) async {
          try {
            return await _repo.forumFeed(name, limit: 20);
          } catch (_) {
            return ThreadFeed.empty;
          }
        }),
      );
      final threads = <ThreadSummary>[];
      final users = <int, TiebaUser>{};
      final seenThreads = <int>{};
      for (final source in feeds) {
        users.addAll(source.users);
        for (final thread in source.threads) {
          if (thread.tid == 0 || !seenThreads.add(thread.tid)) continue;
          threads.add(thread);
        }
      }
      threads.sort((a, b) {
        final at = a.lastTime > 0 ? a.lastTime : a.createTime;
        final bt = b.lastTime > 0 ? b.lastTime : b.createTime;
        return bt.compareTo(at);
      });
      feed = ThreadFeed(
        threads: threads.take(12).toList(growable: false),
        users: users,
      );
    }

    if (!mounted) return;
    setState(() {
      _loggedIn = loggedIn;
      _forums = forums;
      _people = accountPeople;
      _feed = feed;
      _recentForums = LocalLibrary.instance.recentForums;
      _accountWarning = warning;
      _loading = false;
      _error = uniqueNames.isEmpty && warning != null ? warning : null;
    });
  }

  void _openForum(String name) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: name)),
    );
  }

  void _openUser(TiebaUser user) => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => UserPage(userId: user.id, initialName: user.displayName),
    ),
  );

  Future<void> _openAccount() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (mounted) _load();
  }

  void _goExplore() {
    final callback = widget.onExplore;
    if (callback != null) {
      callback();
      return;
    }
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const DiscoverPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                      onTap: _goExplore,
                      child: Icon(
                        Icons.people_alt_rounded,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('关注', style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 3),
                          Text(
                            _loggedIn ? '你关注的人和吧，都在这里' : '本地关注 · 登录后同步贴吧账号',
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
                    IconButton.filledTonal(
                      tooltip: _loggedIn ? '账号' : '登录',
                      onPressed: _openAccount,
                      icon: Icon(
                        _loggedIn
                            ? Icons.account_circle_rounded
                            : Icons.account_circle_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TabBar(
              controller: _tabs,
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              tabs: <Widget>[
                Tab(text: '动态'),
                Tab(text: '吧'),
                Tab(text: '吧友'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: <Widget>[
                  _feedTab(),
                  _forumsTab(),
                  _peopleTab(),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget _feedTab() {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: <Widget>[
          if (_accountWarning != null && _loggedIn)
            _WarningNote(text: _accountWarning!),
          if (_loading && _feed.threads.isEmpty)
            const LoadingIndicator(minHeight: 220)
          else if (_error != null && _feed.threads.isEmpty)
            _ErrorCard(message: _error!, onRetry: _load)
          else if (_feed.threads.isEmpty)
            _TabEmpty(
              icon: Icons.forum_outlined,
              title: _forums.isEmpty ? '还没有关注动态' : '关注的吧暂时没有新帖',
              description: _forums.isEmpty
                  ? '先关注几个吧，这里会汇总他们最新的帖子。'
                  : '过一会儿刷新看看，或者去广场发现更多吧。',
              action: _forums.isEmpty ? '去广场' : '刷新',
              onAction: _forums.isEmpty ? _goExplore : _load,
            )
          else ...<Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                '来自 ${_feed.threads.map((e) => e.forumName).toSet().length} 个关注的吧',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ThreadGrid(
              feed: _feed,
              repo: _repo,
            ),
          ],
        ],
      ),
    );
  }

  Widget _forumsTab() {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: <Widget>[
          if (_recentForums.isNotEmpty) ...<Widget>[
            Text(
              '看过的吧',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _recentForums.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final name = _recentForums[index];
                  return ForumChipOpenContainer(
                    key: ValueKey<String>('recent-forum-$name'),
                    name: name,
                    repo: _repo,
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
          ],
          Text(
            _loggedIn ? '关注的吧' : '本地关注的吧',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 9),
          if (_loading && _forums.isEmpty)
            const LoadingIndicator(minHeight: 160)
          else if (_forums.isEmpty)
            _TabEmpty(
              icon: Icons.star_border_rounded,
              title: _loggedIn ? '还没有关注贴吧' : '还没有本地关注',
              description: '去广场挑几个感兴趣的吧，关注后会出现在这里。',
              action: '去广场看看',
              onAction: _goExplore,
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 64,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: _forums.length,
              itemBuilder: (context, index) {
                final forum = _forums[index];
                return ForumFollowCard(
                  key: ValueKey<String>('followed-forum-${forum.name}'),
                  forum: forum,
                  repo: _repo,
                  onTap: () => _openForum(forum.name),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _peopleTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: <Widget>[
        if (_loading && _people.isEmpty)
          const LoadingIndicator(minHeight: 220)
        else if (!_loggedIn)
          _TabEmpty(
            icon: Icons.people_outline_rounded,
            title: '登录后查看关注的人',
            description: '账号同步后，这里会显示你关注的吧友，点击可以查看对方主页。',
            action: '登录',
            onAction: _openAccount,
            embedded: true,
          )
        else if (_people.isEmpty)
          const _TabEmpty(
            icon: Icons.people_outline_rounded,
            title: '还没有关注的人',
            description: '在吧里遇到感兴趣的吧友，可以在对方主页关注。',
            embedded: true,
          )
        else ...<Widget>[
          Text(
            '已关注 ${_people.length} 人',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          for (final user in _people)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _PersonTile(user: user, onTap: () => _openUser(user)),
            ),
        ],
      ],
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.user, required this.onTap});

  final TiebaUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: onTap,
        leading: NameAvatar(
          name: user.displayName,
          imageUrl: user.avatarUrl,
          size: 44,
        ),
        title: Text(user.displayName),
        subtitle: Text(
          '查看主页和最近发帖',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _WarningNote extends StatelessWidget {
  const _WarningNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabEmpty extends StatelessWidget {
  const _TabEmpty({
    required this.icon,
    required this.title,
    required this.description,
    this.action,
    this.onAction,
    this.embedded = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? action;
  final VoidCallback? onAction;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: embedded ? EdgeInsets.zero : const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(height: 10),
          Text(title, style: theme.textTheme.titleSmall),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          if (action != null) ...<Widget>[
            const SizedBox(height: 12),
            FilledButton(onPressed: onAction, child: Text(action!)),
          ],
        ],
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
      margin: const EdgeInsets.only(top: 10),
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