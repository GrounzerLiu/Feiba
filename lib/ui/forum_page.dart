import 'package:material_ui/material_ui.dart';

import '../core/local_library.dart';
import '../core/session.dart';
import '../core/tieba_api.dart';
import '../data/models/forum_page.dart';
import '../data/protocol_browse_repository.dart';
import 'auth_gate.dart';
import 'format.dart';
import 'thread_page.dart';
import 'route_transitions.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/name_avatar.dart';
import 'widgets/thread_card.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key, required this.forumName});

  final String forumName;

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  final ScrollController _scroll = ScrollController();

  final List<ThreadSummary> _threads = <ThreadSummary>[];
  TiebaForum? _forum;
  Map<int, dynamic> _users = const <int, dynamic>{};
  int _page = 1;
  int _sort = 0;
  bool _loading = false;
  bool _hasMore = true;
  bool? _accountFollowed;
  String? _error;

  @override
  void initState() {
    super.initState();
    LocalLibrary.instance.recordForumVisit(widget.forumName);
    _scroll.addListener(_onScroll);
    _load(reset: true);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients || _loading || !_hasMore) return;
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 500) {
      _load();
    }
  }

  Future<void> _load({bool reset = false}) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      if (reset) {
        _error = null;
        _page = 1;
        _hasMore = true;
        _threads.clear();
      }
    });
    try {
      final data = await _repo.forumPage(
        widget.forumName,
        pn: _page,
        sortType: _sort == 1 ? 1 : 0,
        isGood: _sort == 2,
      );
      if (!mounted) return;
      setState(() {
        _forum = data.forum ?? _forum;
        _users = data.users;
        _threads.addAll(data.threads);
        _hasMore = data.hasMore;
        _page += 1;
      });
      final fid = data.forum?.id ?? 0;
      if (Session.instance.isLoggedIn && fid > 0) {
        () async {
          try {
            final followed = await TiebaApi.instance.isForumFollowed(fid);
            if (mounted) setState(() => _accountFollowed = followed);
          } catch (_) {
            // Keep the unknown state; the follow button still works.
          }
        }();
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleFollow() async {
    final loggedIn = Session.instance.isLoggedIn;
    final currently = loggedIn
        ? (_accountFollowed ?? false)
        : LocalLibrary.instance.isForumFollowed(widget.forumName);
    if (loggedIn) {
      try {
        await TiebaApi.instance.followForum(
          widget.forumName,
          follow: !currently,
          fid: _forum?.id,
        );
      } catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('关注失败：${tiebaErrorMessage(error)}')),
        );
        return;
      }
    }
    if (loggedIn) {
      if (mounted) setState(() => _accountFollowed = !currently);
    } else {
      await LocalLibrary.instance.toggleForumFollow(widget.forumName);
      if (mounted) setState(() {});
    }
    final followed = !currently;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          followed ? (loggedIn ? '已关注（已同步账号）' : '已关注（保存在本机）') : '已取消关注',
        ),
      ),
    );
  }

  Future<void> _signForum() async {
    if (!Session.instance.isLoggedIn) {
      final loggedIn = await ensureLoggedIn(
        context,
        action: '签到',
        description: '登录后可以给这个吧签到；浏览和搜索仍然不需要登录。',
      );
      if (!loggedIn || !mounted) return;
    }
    try {
      await TiebaApi.instance.signForum(widget.forumName);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('签到成功')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('签到失败：${tiebaErrorMessage(error)}')),
      );
    }
  }

  void _changeSort(int value) {
    if (_sort == value) return;
    setState(() => _sort = value);
    _load(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _forum?.name ?? widget.forumName;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: <Widget>[
          if (Session.instance.isLoggedIn)
            IconButton(
              tooltip: '签到',
              onPressed: _signForum,
              icon: const Icon(Icons.how_to_reg_outlined),
            ),
          IconButton(
            tooltip: '刷新',
            onPressed: () => _load(reset: true),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _load(reset: true),
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: _ForumHeader(
                  forum: _forum,
                  fallbackName: widget.forumName,
                  followed: Session.instance.isLoggedIn
                      ? (_accountFollowed ?? false)
                      : LocalLibrary.instance.isForumFollowed(widget.forumName),
                  onFollow: _toggleFollow,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('帖子', style: theme.textTheme.titleMedium),
                    ),
                    for (var i = 0; i < 3; i++) ...<Widget>[
                      if (i > 0) const SizedBox(width: 6),
                      ChoiceChip(
                        label: Text(<String>['最新回复', '最新发布', '精品'][i]),
                        selected: _sort == i,
                        onSelected: (_) => _changeSort(i),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_threads.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _loading
                    ? const LoadingIndicator(minHeight: 280)
                    : _error != null
                    ? _ForumError(
                        message: _error!,
                        onRetry: () => _load(reset: true),
                      )
                    : const Center(child: Text('这个吧还没有帖子')),
              )
            else
              SliverList.builder(
                itemCount: _threads.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= _threads.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.2),
                        ),
                      ),
                    );
                  }
                  final thread = _threads[index];
                  final user = _users[thread.authorId];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                    child: ThreadCard(
                      thread: thread,
                      authorName: user?.displayName as String?,
                      authorAvatar: user?.avatarUrl as String?,
                      forumName: title,
                      onTap: () => Navigator.of(context).push(
                        threadPageRoute(
                          ThreadPage(
                            tid: thread.tid,
                            title: thread.title,
                            forumName: title,
                            authorName: user?.displayName as String?,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

class _ForumHeader extends StatelessWidget {
  const _ForumHeader({
    required this.forum,
    required this.fallbackName,
    required this.followed,
    required this.onFollow,
  });

  final TiebaForum? forum;
  final String fallbackName;
  final bool followed;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = forum?.name ?? fallbackName;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        theme.colorScheme.primary,
        theme.colorScheme.primary.withValues(alpha: 0.72),
      ],
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NameAvatar(name: name, imageUrl: forum?.avatar, size: 54),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      forum?.slogan?.trim().isNotEmpty == true
                          ? forum!.slogan!
                          : '欢迎来到 $name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: onFollow,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(
                    alpha: followed ? 0.9 : 0.18,
                  ),
                  foregroundColor: followed
                      ? theme.colorScheme.primary
                      : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(followed ? '已关注' : '关注'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              _HeaderMetric(
                value: compactCount(forum?.memberNum ?? 0),
                label: '成员',
              ),
              const SizedBox(width: 22),
              _HeaderMetric(
                value: compactCount(forum?.postNum ?? 0),
                label: '帖子',
              ),
              const Spacer(),
              Icon(
                Icons.verified_outlined,
                size: 16,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4),
              Text(
                '公开吧',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.68),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _ForumError extends StatelessWidget {
  const _ForumError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.cloud_off_rounded, size: 38),
            const SizedBox(height: 12),
            Text('加载失败，检查网络后再试', textAlign: TextAlign.center),
            const SizedBox(height: 14),
            FilledButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}