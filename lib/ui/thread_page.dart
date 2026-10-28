import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../core/local_library.dart';
import '../core/session.dart';
import '../core/tieba_api.dart';
import '../data/models/thread_page.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'auth_gate.dart';
import 'format.dart';
import 'widgets/content_view.dart';
import 'widgets/dismissible_sheet.dart';
import 'widgets/name_avatar.dart';
import 'widgets/loading_indicator.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({
    super.key,
    required this.tid,
    this.title,
    this.forumName,
    this.authorName,
  });

  final int tid;
  final String? title;
  final String? forumName;
  final String? authorName;

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  final ScrollController _scroll = ScrollController();

  final List<PostItem> _posts = <PostItem>[];

  Map<int, TiebaUser> _users = const <int, TiebaUser>{};
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;
  bool _liked = false;
  String _title = '';

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? '';
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
        _posts.clear();
      }
    });
    final wasEmpty = _posts.isEmpty;
    try {
      final data = await _repo.threadPage(widget.tid, pn: _page);
      if (!mounted) return;
      setState(() {
        _posts.addAll(data.posts);
        _users = data.users;
        if (data.title.isNotEmpty) _title = data.title;
        _hasMore = data.hasMore;
        _page += 1;
      });
      if (wasEmpty) {
        final first = data.posts.isEmpty ? null : data.posts.first;
        final author = first == null
            ? widget.authorName
            : data.users[first.authorId]?.displayName ?? widget.authorName;
        await LocalLibrary.instance.recordThread(
          tid: widget.tid,
          title: _title,
          forumName: widget.forumName ?? '',
          authorName: author,
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _openSubPosts(PostItem post) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      enableDrag: false,
      showDragHandle: false,
      builder: (_) => DismissibleSheet(
        initialSize: post.subPostNumber <= 3
            ? 0.38
            : post.subPostNumber <= 10
            ? 0.58
            : 0.94,
        builder: (context, scrollController) => _SubPostsSheet(
          tid: widget.tid,
          pid: post.id,
          total: post.subPostNumber,
          initial: post.subPosts,
          users: _users,
          scrollController: scrollController,
        ),
      ),
    );
  }

  Future<void> _showReplyComposer() async {
    if (!Session.instance.isLoggedIn) {
      final loggedIn = await ensureLoggedIn(
        context,
        action: '回复帖子',
        description: '游客可以浏览所有帖子和楼中楼；登录后才能回复、点赞和收发消息。',
      );
      if (!loggedIn || !mounted) return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('回复编辑器正在接入中')));
  }

  Future<void> _toggleFavorite() async {
    final added = await LocalLibrary.instance.toggleFavorite(
      tid: widget.tid,
      title: _title,
      forumName: widget.forumName ?? '',
      authorName: widget.authorName,
    );
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(added ? '已收藏，可在“我的空间”查看' : '已取消收藏')));
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(
      ClipboardData(text: 'https://tieba.baidu.com/p/${widget.tid}'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('帖子链接已复制')));
  }

  Future<void> _requireLoginForLike() async {
    if (!Session.instance.isLoggedIn) {
      final loggedIn = await ensureLoggedIn(
        context,
        action: '点赞帖子',
        description: '浏览和搜索不需要登录；登录后可以为喜欢的楼层点赞。',
      );
      if (!loggedIn || !mounted) return;
    }
    try {
      final undo = _liked;
      await TiebaApi.instance.setThreadAgree(widget.tid, undo: undo);
      if (!mounted) return;
      setState(() => _liked = !undo);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(undo ? '已取消点赞' : '点赞成功')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('点赞失败：${tiebaErrorMessage(error)}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title.isEmpty ? '帖子' : _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          IconButton(
            tooltip: LocalLibrary.instance.isFavorite(widget.tid)
                ? '取消收藏'
                : '收藏',
            onPressed: _toggleFavorite,
            icon: Icon(
              LocalLibrary.instance.isFavorite(widget.tid)
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
            ),
          ),
          IconButton(
            tooltip: '分享',
            onPressed: _copyLink,
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _load(reset: true),
        child: _buildBody(theme),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(22),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: _showReplyComposer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),
                      child: Text(
                        '写回复…',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filledTonal(
                tooltip: _liked ? '取消点赞' : '点赞',
                onPressed: _requireLoginForLike,
                icon: Icon(
                  _liked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_posts.isEmpty) {
      if (_loading) return const LoadingIndicator(minHeight: 260);
      if (_error != null) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 120),
            const Icon(Icons.cloud_off_rounded, size: 38),
            const SizedBox(height: 12),
            const Text('加载失败，检查网络后再试', textAlign: TextAlign.center),
            const SizedBox(height: 14),
            Center(
              child: FilledButton(
                onPressed: () => _load(reset: true),
                child: const Text('重试'),
              ),
            ),
          ],
        );
      }
      return const Center(child: Text('没有内容'));
    }

    return ListView.builder(
      controller: _scroll,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
      itemCount: _posts.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _posts.length) {
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
        final post = _posts[index];
        return _PostCard(
          post: post,
          isOp: index == 0,
          author: _users[post.authorId],
          users: _users,
          subs: post.subPosts,
          onExpand: post.subPostNumber > 0 || post.subPosts.isNotEmpty
              ? () => _openSubPosts(post)
              : null,
        );
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    this.isOp = false,
    this.author,
    required this.users,
    this.subs = const <SubPost>[],
    this.onExpand,
  });

  final PostItem post;
  final bool isOp;
  final TiebaUser? author;
  final Map<int, TiebaUser> users;
  final List<SubPost> subs;
  final VoidCallback? onExpand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = author?.displayName ?? '未知用户';
    final time = relativeTime(post.time);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 11),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              NameAvatar(name: name, imageUrl: author?.avatarUrl, size: 32),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (time.isNotEmpty)
                      Text(
                        time,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                isOp ? '楼主' : '${post.floor}楼',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isOp
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('更多操作正在接入中'))),
                icon: Icon(
                  Icons.more_horiz_rounded,
                  size: 19,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ContentView(nodes: post.content),
          const SizedBox(height: 9),
          Row(
            children: <Widget>[
              _Action(
                icon: Icons.favorite_border_rounded,
                value: post.agreeNum,
                label: '赞',
              ),
              const SizedBox(width: 18),
              _Action(
                icon: Icons.mode_comment_outlined,
                value: post.subPostNumber,
                label: '回复',
              ),
              const Spacer(),
              Icon(
                Icons.more_horiz_rounded,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.7,
                ),
              ),
            ],
          ),
          if (subs.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.62,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final sub in subs.take(4))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: _SubPostRow(sub: sub, author: users[sub.authorId]),
                    ),
                  if (subs.length > 4 && onExpand != null)
                    Text(
                      '还有 ${subs.length - 4} 条回复',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (onExpand != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                onTap: onExpand,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        post.subPostNumber > 0
                            ? '共 ${post.subPostNumber} 条回复'
                            : '查看楼中楼',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 15,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SubPostRow extends StatelessWidget {
  const _SubPostRow({
    required this.sub,
    this.author,
    this.avatarSize = 20,
    this.large = false,
  });

  final SubPost sub;
  final TiebaUser? author;
  final double avatarSize;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authorName = author?.displayName;
    final name = (authorName == null || authorName.isEmpty)
        ? (sub.authorName ?? '用户')
        : authorName;
    final avatar = author?.avatarUrl ?? sub.avatarUrl;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        NameAvatar(name: name, imageUrl: avatar, size: avatarSize),
        SizedBox(width: large ? 10 : 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    (large
                            ? theme.textTheme.labelMedium
                            : theme.textTheme.labelSmall)
                        ?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
              ),
              SizedBox(height: large ? 3 : 1),
              ContentView(
                nodes: sub.content,
                style:
                    (large
                            ? theme.textTheme.bodyMedium
                            : theme.textTheme.bodySmall)
                        ?.copyWith(height: 1.5),
                maxImages: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubPostsSheet extends StatefulWidget {
  const _SubPostsSheet({
    required this.tid,
    required this.pid,
    required this.total,
    required this.initial,
    required this.users,
    required this.scrollController,
  });

  final int tid;
  final int pid;
  final int total;
  final List<SubPost> initial;
  final Map<int, TiebaUser> users;
  final ScrollController scrollController;

  @override
  State<_SubPostsSheet> createState() => _SubPostsSheetState();
}

class _SubPostsSheetState extends State<_SubPostsSheet> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  final List<SubPost> _items = <SubPost>[];
  int _pn = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _items.addAll(widget.initial);
    _loadMore();
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _repo.subPosts(
        tid: widget.tid,
        pid: widget.pid,
        pn: _pn,
      );
      if (!mounted) return;
      final existing = _items.map((e) => e.id).toSet();
      setState(() {
        for (final sub in page.posts) {
          if (existing.add(sub.id)) _items.add(sub);
        }
        _hasMore = page.hasMore && page.posts.isNotEmpty;
        _pn += 1;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = widget.total > 0 ? widget.total : _items.length;
    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
          child: Row(
            children: <Widget>[
              Text('楼中楼', style: theme.textTheme.titleMedium),
              const SizedBox(width: 8),
              Text(
                '共 $count 条',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: _items.isEmpty && _loading
              ? const LoadingIndicator(minHeight: 180)
              : _items.isEmpty && _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('加载失败'),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _loadMore,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  controller: widget.scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  itemCount: _items.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index >= _items.length) return _footer(theme);
                    final sub = _items[index];
                    return _SubPostRow(
                      sub: sub,
                      author: widget.users[sub.authorId],
                      avatarSize: 34,
                      large: true,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _footer(ThemeData theme) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    if (_error != null) {
      return Center(
        child: TextButton(onPressed: _loadMore, child: const Text('加载失败，重试')),
      );
    }
    if (_hasMore) {
      return Center(
        child: TextButton(onPressed: _loadMore, child: const Text('加载更多')),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          '没有更多了',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.value, required this.label});

  final IconData icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 15, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          value > 0 ? compactCount(value) : label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}