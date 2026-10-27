import 'package:flutter/material.dart';

import '../data/models/thread_page.dart';
import '../data/models/tieba_user.dart';
import '../data/tieba_repository.dart';
import 'format.dart';
import 'widgets/content_view.dart';
import 'widgets/name_avatar.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({super.key, required this.tid, this.title});

  final int tid;
  final String? title;

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final TiebaRepository _repo = TiebaRepository();
  final ScrollController _scroll = ScrollController();

  final List<PostItem> _posts = <PostItem>[];
  final Map<int, List<SubPost>> _expandedSubs = <int, List<SubPost>>{};
  final Set<int> _subLoading = <int>{};

  Map<int, TiebaUser> _users = const <int, TiebaUser>{};
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;
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
        _expandedSubs.clear();
      }
    });
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
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _expandSubs(PostItem post) async {
    if (_subLoading.contains(post.id)) return;
    setState(() => _subLoading.add(post.id));
    final collected = <int, SubPost>{};
    try {
      var pn = 1;
      var more = true;
      while (more && pn <= 100) {
        final page = await _repo.subPosts(
          tid: widget.tid,
          pid: post.id,
          pn: pn,
        );
        for (final sub in page.posts) {
          collected[sub.id] = sub;
        }
        more = page.hasMore && page.posts.isNotEmpty;
        pn += 1;
      }
      if (!mounted) return;
      setState(() => _expandedSubs[post.id] = collected.values.toList());
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('加载楼中楼失败：$error')));
    } finally {
      if (mounted) setState(() => _subLoading.remove(post.id));
    }
  }

  void _showReplyComposer() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('回复编辑器正在接入中')));
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
            tooltip: '分享',
            onPressed: () =>
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('分享功能正在接入中'))),
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
                tooltip: '点赞',
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('点赞功能正在接入中'))),
                icon: const Icon(Icons.favorite_border_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_posts.isEmpty) {
      if (_loading) return const Center(child: CircularProgressIndicator());
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
        final expanded = _expandedSubs[post.id];
        return _PostCard(
          post: post,
          isOp: index == 0,
          author: _users[post.authorId],
          subs: expanded ?? post.subPosts,
          loadingSubs: _subLoading.contains(post.id),
          onExpand:
              expanded == null &&
                  (post.subPostNumber > 0 || post.subPosts.isNotEmpty)
              ? () => _expandSubs(post)
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
    this.subs = const <SubPost>[],
    this.loadingSubs = false,
    this.onExpand,
  });

  final PostItem post;
  final bool isOp;
  final TiebaUser? author;
  final List<SubPost> subs;
  final bool loadingSubs;
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
                      child: _SubPostRow(sub: sub),
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
          if (loadingSubs)
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 17,
                height: 17,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else if (onExpand != null)
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
  const _SubPostRow({required this.sub});

  final SubPost sub;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = sub.authorName ?? '用户';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        NameAvatar(name: name, imageUrl: sub.avatarUrl, size: 20),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 1),
              ContentView(
                nodes: sub.content,
                style: theme.textTheme.bodySmall?.copyWith(height: 1.45),
                maxImages: 0,
              ),
            ],
          ),
        ),
      ],
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
