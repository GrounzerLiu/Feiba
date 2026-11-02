import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../core/local_library.dart';
import '../core/session.dart';
import '../core/tieba_api.dart';
import '../data/models/thread_page.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'auth_gate.dart';
import 'forum_page.dart';
import 'user_page.dart';
import 'format.dart';
import 'widgets/content_view.dart';
import 'widgets/dismissible_sheet.dart';
import 'widgets/name_avatar.dart';
import 'widgets/level_badge.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/forum_chip.dart';

const double kThreadPageMaxWidth = 1040;

class ThreadPage extends StatefulWidget {
  const ThreadPage({
    super.key,
    required this.tid,
    this.title,
    this.forumName,
    this.authorName,
    this.showForumChip = true,
  });

  final int tid;
  final String? title;
  final String? forumName;
  final String? authorName;
  final bool showForumChip;

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
  bool _descending = false;
  bool _onlyAuthor = false;
  int? _opAuthorId;
  int _replyNum = 0;
  int _viewNum = 0;
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

  void _openForum() {
    final name = widget.forumName;
    if (name == null || name.isEmpty) return;
    LocalLibrary.instance.recordForumVisit(name);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: name)),
    );
  }

  void _openUser(int userId, String name) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => UserPage(
          userId: userId,
          initialName: name,
          forumName: widget.forumName,
        ),
      ),
    );
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
      final data = await _repo.threadPage(
        widget.tid,
        pn: _page,
        descending: _descending,
        onlyAuthor: _onlyAuthor,
      );
      if (!mounted) return;
      setState(() {
        _posts.addAll(data.posts);
        _users = data.users;
        if (data.title.isNotEmpty) _title = data.title;
        if (data.replyNum > 0) _replyNum = data.replyNum;
        if (data.viewNum > 0) _viewNum = data.viewNum;
        _hasMore = data.hasMore;
        _page += 1;
        if (_opAuthorId == null &&
            data.posts.isNotEmpty &&
            !_descending) {
          _opAuthorId = data.posts.first.authorId;
        }
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
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kThreadPageMaxWidth,
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
        ),
      ),
    );
  }

  Widget _threadAppBar(ThemeData theme) {
    final hasForum = widget.showForumChip &&
        widget.forumName != null &&
        widget.forumName!.isNotEmpty;
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      toolbarHeight: 56,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: IconButton(
        tooltip: '返回',
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: hasForum
          ? ForumChip(
              name: widget.forumName!,
              repo: _repo,
              dense: true,
              recordVisit: false,
              onPressed: _openForum,
            )
          : const Text('帖子'),
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
        IconButton(
          tooltip: '更多',
          onPressed: _showThreadMenu,
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }

  Widget _threadTitleBlock(ThemeData theme) {
    final title = _title.isEmpty ? '帖子' : _title;
    final stats = <String>[
      if (_replyNum > 0) '${compactCount(_replyNum)} 回复',
      if (_viewNum > 0) '${compactCount(_viewNum)} 浏览',
    ];
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kThreadPageMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                if (stats.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 6),
                  Text(
                    stats.join('  ·  '),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setOrder(bool descending) {
    if (_descending == descending) return;
    setState(() => _descending = descending);
    _load(reset: true);
  }

  void _toggleOnlyAuthor() {
    setState(() => _onlyAuthor = !_onlyAuthor);
    _load(reset: true);
  }

  void _scrollToTop() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollToBottom() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      _scroll.position.maxScrollExtent,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _showThreadMenu() async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return _ThreadMenuSheet(
          descending: _descending,
          onlyAuthor: _onlyAuthor,
          onToggleOrder: () {
            Navigator.of(sheetContext).pop();
            _setOrder(!_descending);
          },
          onToggleOnlyAuthor: () {
            Navigator.of(sheetContext).pop();
            _toggleOnlyAuthor();
          },
          onTop: () {
            Navigator.of(sheetContext).pop();
            _scrollToTop();
          },
          onBottom: () {
            Navigator.of(sheetContext).pop();
            _scrollToBottom();
          },
          onShare: () {
            Navigator.of(sheetContext).pop();
            _copyLink();
          },
          onCopyLink: () {
            Navigator.of(sheetContext).pop();
            _copyLink();
          },
        );
      },
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_posts.isEmpty) {
      return CustomScrollView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          _threadAppBar(theme),
          _threadTitleBlock(theme),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _loading
                ? const LoadingIndicator(minHeight: 260)
                : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.cloud_off_rounded, size: 38),
                        const SizedBox(height: 12),
                        const Text('加载失败，检查网络后再试'),
                        const SizedBox(height: 14),
                        FilledButton(
                          onPressed: () => _load(reset: true),
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  )
                : const Center(child: Text('没有内容')),
          ),
        ],
      );
    }

    return CustomScrollView(
      controller: _scroll,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        _threadAppBar(theme),
        _threadTitleBlock(theme),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
          sliver: SliverList.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = _posts[index];
              final author = _users[post.authorId];
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: kThreadPageMaxWidth,
                  ),
                  child: _PostCard(
                    post: post,
                    isOp: _opAuthorId != null && post.authorId == _opAuthorId,
                    author: author,
                    onAuthorTap: author == null
                        ? null
                        : () => _openUser(post.authorId, author.displayName),
                    users: _users,
                    subs: post.subPosts,
                    onExpand: post.subPostNumber > 0 || post.subPosts.isNotEmpty
                        ? () => _openSubPosts(post)
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        if (_hasMore && _loading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ThreadMenuSheet extends StatelessWidget {
  const _ThreadMenuSheet({
    required this.descending,
    required this.onlyAuthor,
    required this.onToggleOrder,
    required this.onToggleOnlyAuthor,
    required this.onTop,
    required this.onBottom,
    required this.onShare,
    required this.onCopyLink,
  });

  final bool descending;
  final bool onlyAuthor;
  final VoidCallback onToggleOrder;
  final VoidCallback onToggleOnlyAuthor;
  final VoidCallback onTop;
  final VoidCallback onBottom;
  final VoidCallback onShare;
  final VoidCallback onCopyLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actions = <Widget>[
      _SheetAction(
        icon: onlyAuthor
            ? Icons.person_off_outlined
            : Icons.person_outline_rounded,
        label: onlyAuthor ? '取消只看楼主' : '只看楼主',
        selected: onlyAuthor,
        onTap: onToggleOnlyAuthor,
      ),
      _SheetAction(
        icon: descending
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded,
        label: descending ? '切换正序' : '倒序浏览',
        selected: descending,
        onTap: onToggleOrder,
      ),
      _SheetAction(
        icon: Icons.vertical_align_top_rounded,
        label: '回到顶部',
        onTap: onTop,
      ),
      _SheetAction(
        icon: Icons.vertical_align_bottom_rounded,
        label: '回到底部',
        onTap: onBottom,
      ),
      _SheetAction(
        icon: Icons.ios_share_rounded,
        label: '分享',
        onTap: onShare,
      ),
      _SheetAction(
        icon: Icons.link_rounded,
        label: '复制链接',
        onTap: onCopyLink,
      ),
    ];

    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '帖子选项',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: '关闭',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: actions.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 56,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                  itemBuilder: (context, index) => actions[index],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(52),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
    if (selected) {
      return FilledButton.tonalIcon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: style,
      );
    }
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: style,
    );
  }
}

String? _roleLabel(String? value) {
  if (value == null || value.isEmpty) return null;
  return value == 'manager' || value == '吧主' ? '吧主' : '吧务';
}

enum _RoleBadgeColor { op, owner, manager }

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.label, required this.color});

  final String label;
  final _RoleBadgeColor color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = switch (color) {
      _RoleBadgeColor.op => theme.colorScheme.primary,
      _RoleBadgeColor.owner => theme.colorScheme.error,
      _RoleBadgeColor.manager => theme.colorScheme.tertiary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
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
    this.onAuthorTap,
  });

  final PostItem post;
  final bool isOp;
  final TiebaUser? author;
  final Map<int, TiebaUser> users;
  final List<SubPost> subs;
  final VoidCallback? onExpand;
  final VoidCallback? onAuthorTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = author?.displayName ?? '未知用户';
    final time = relativeTime(post.time);
    final role = _roleLabel(author?.role);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 11),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onAuthorTap,
                child: NameAvatar(
                  name: name,
                  imageUrl: author?.avatarUrl,
                  size: 32,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (author?.levelId != null &&
                            author!.levelId! > 0) ...<Widget>[
                          const SizedBox(width: 5),
                          LevelBadge(level: author!.levelId!),
                        ],
                        if (isOp) ...<Widget>[
                          const SizedBox(width: 4),
                          const _RoleBadge(
                            label: '楼主',
                            color: _RoleBadgeColor.op,
                          ),
                        ],
                        if (role != null) ...<Widget>[
                          const SizedBox(width: 4),
                          _RoleBadge(
                            label: role,
                            color: role == '吧主'
                                ? _RoleBadgeColor.owner
                                : _RoleBadgeColor.manager,
                          ),
                        ],
                      ],
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
                post.floor > 0 ? '${post.floor}楼' : '',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
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