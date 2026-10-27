import 'package:flutter/material.dart';

import '../data/models/thread_page.dart';
import '../data/models/tieba_user.dart';
import '../data/tieba_repository.dart';
import 'widgets/content_view.dart';

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
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 400) {
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
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Loads every page of sub posts (楼中楼) for [post].
  Future<void> _expandSubs(PostItem post) async {
    if (_subLoading.contains(post.id)) return;
    setState(() => _subLoading.add(post.id));
    final collected = <int, SubPost>{};
    try {
      var pn = 1;
      var more = true;
      while (more && pn <= 10) {
        final page = await _repo.subPosts(tid: widget.tid, pid: post.id, pn: pn);
        for (final sub in page.posts) {
          collected[sub.id] = sub;
        }
        more = page.hasMore && page.posts.isNotEmpty;
        pn += 1;
      }
      if (!mounted) return;
      setState(() => _expandedSubs[post.id] = collected.values.toList());
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载楼中楼失败：$e')),
      );
    } finally {
      if (mounted) setState(() => _subLoading.remove(post.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title.isEmpty ? '帖子' : _title, maxLines: 1)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_posts.isEmpty) {
      if (_loading) return const Center(child: CircularProgressIndicator());
      if (_error != null) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => _load(reset: true),
                child: const Text('重试'),
              ),
            ],
          ),
        );
      }
      return const Center(child: Text('没有内容'));
    }

    return ListView.separated(
      controller: _scroll,
      itemCount: _posts.length + (_hasMore ? 1 : 0),
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index >= _posts.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        final post = _posts[index];
        final expanded = _expandedSubs[post.id];
        return _PostTile(
          post: post,
          author: _users[post.authorId],
          subs: expanded ?? post.subPosts,
          loadingSubs: _subLoading.contains(post.id),
          onExpand: expanded == null &&
                  (post.subPostNumber > 0 || post.subPosts.isNotEmpty)
              ? () => _expandSubs(post)
              : null,
        );
      },
    );
  }
}

class _PostTile extends StatelessWidget {
  const _PostTile({
    required this.post,
    this.author,
    this.subs = const <SubPost>[],
    this.loadingSubs = false,
    this.onExpand,
  });

  final PostItem post;
  final TiebaUser? author;
  final List<SubPost> subs;
  final bool loadingSubs;
  final VoidCallback? onExpand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                backgroundImage:
                    author?.avatarUrl != null ? NetworkImage(author!.avatarUrl!) : null,
                child: author?.avatarUrl == null
                    ? Text(
                        (author?.displayName ?? '?').characters.first,
                        style: const TextStyle(fontSize: 11),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  author?.displayName ?? '未知用户',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              Text('${post.floor}楼', style: theme.textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          ContentView(nodes: post.content),
          if (subs.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final sub in subs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (sub.authorName != null && sub.authorName!.isNotEmpty)
                            Text(
                              sub.authorName!,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ContentView(
                            nodes: sub.content,
                            style: theme.textTheme.bodySmall,
                            maxImages: 0,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (loadingSubs)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else if (onExpand != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: InkWell(
                onTap: onExpand,
                child: Text(
                  post.subPostNumber > 0
                      ? '共 ${post.subPostNumber} 条回复，点击查看全部'
                      : '查看楼中楼',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
