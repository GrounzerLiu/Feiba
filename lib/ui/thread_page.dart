import 'package:flutter/material.dart';

import '../data/models/thread_page.dart';
import '../data/tieba_repository.dart';
import '../data/models/tieba_user.dart';
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
        return _PostTile(post: post, author: _users[post.authorId]);
      },
    );
  }
}

class _PostTile extends StatelessWidget {
  const _PostTile({required this.post, this.author});

  final PostItem post;
  final TiebaUser? author;

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
                backgroundImage: author?.avatarUrl != null
                    ? NetworkImage(author!.avatarUrl!)
                    : null,
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
          if (post.subPosts.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: post.subPosts.take(3).map((sub) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: ContentView(
                      nodes: sub.content,
                      style: theme.textTheme.bodySmall,
                      maxImages: 0,
                    ),
                  );
                }).toList(),
              ),
            ),
            if (post.subPostNumber > post.subPosts.length)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '共 ${post.subPostNumber} 条回复',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
