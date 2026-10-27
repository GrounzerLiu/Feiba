import 'package:flutter/material.dart';

import '../data/models/forum_page.dart';
import '../data/tieba_repository.dart';
import 'thread_page.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key, required this.forumName});

  final String forumName;

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TiebaRepository _repo = TiebaRepository();
  final ScrollController _scroll = ScrollController();

  final List<ThreadSummary> _threads = <ThreadSummary>[];
  TiebaForum? _forum;
  Map<int, dynamic> _users = const <int, dynamic>{};
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
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
        _threads.clear();
      }
    });
    try {
      final data = await _repo.forumPage(widget.forumName, pn: _page);
      if (!mounted) return;
      setState(() {
        _forum = data.forum ?? _forum;
        _users = data.users;
        _threads.addAll(data.threads);
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
    final title = _forum?.name ?? widget.forumName;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            tooltip: '刷新',
            onPressed: () => _load(reset: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_threads.isEmpty) {
      if (_loading) return const Center(child: CircularProgressIndicator());
      if (_error != null) {
        return _ErrorView(
          message: _error!,
          onRetry: () => _load(reset: true),
        );
      }
      return const Center(child: Text('这个吧还没有帖子'));
    }

    return RefreshIndicator(
      onRefresh: () => _load(reset: true),
      child: ListView.separated(
        controller: _scroll,
        itemCount: _threads.length + (_hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index >= _threads.length) {
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
          final thread = _threads[index];
          return _ThreadTile(
            thread: thread,
            authorName: _users[thread.authorId]?.displayName as String?,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => ThreadPage(tid: thread.tid, title: thread.title),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.thread, this.authorName, this.onTap});

  final ThreadSummary thread;
  final String? authorName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = thread.preview;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (thread.isTop)
                  Padding(
                    padding: const EdgeInsets.only(right: 6, top: 2),
                    child: _Badge(text: '置顶', color: theme.colorScheme.error),
                  ),
                if (thread.isGood)
                  Padding(
                    padding: const EdgeInsets.only(right: 6, top: 2),
                    child: _Badge(text: '精品', color: theme.colorScheme.primary),
                  ),
                Expanded(
                  child: Text(
                    thread.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (preview.isNotEmpty) ...<Widget>[
              const SizedBox(height: 6),
              Text(
                preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                if (authorName != null && authorName!.isNotEmpty)
                  Flexible(
                    child: Text(
                      authorName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                const Spacer(),
                Icon(Icons.chat_bubble_outline,
                    size: 13, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 3),
                Text('${thread.replyNum}', style: theme.textTheme.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: color)),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

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
            const Icon(Icons.cloud_off_outlined, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
