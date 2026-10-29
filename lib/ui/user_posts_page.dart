import 'package:material_ui/material_ui.dart';

import '../data/models/feed.dart';
import '../data/models/forum_page.dart';
import '../data/models/tieba_user.dart';
import '../data/protocol_browse_repository.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/thread_grid.dart';

class UserPostsPage extends StatefulWidget {
  const UserPostsPage({super.key, required this.userId, this.userName});

  final int userId;
  final String? userName;

  @override
  State<UserPostsPage> createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  final ScrollController _scroll = ScrollController();
  final List<ThreadSummary> _threads = <ThreadSummary>[];
  final Map<int, TiebaUser> _users = <int, TiebaUser>{};
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
        _users.clear();
      }
    });
    try {
      final feed = await _repo.userThreads(widget.userId, pn: _page);
      if (!mounted) return;
      setState(() {
        _threads.addAll(feed.threads);
        _users.addAll(feed.users);
        _hasMore = feed.threads.length >= 20;
        _page += 1;
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
    final name = widget.userName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name == null || name.isEmpty ? '帖子' : '$name的帖子',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _load(reset: true),
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            if (_threads.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _loading
                    ? const LoadingIndicator(minHeight: 260)
                    : _error != null
                    ? EmptyState(
                        icon: Icons.cloud_off_rounded,
                        title: '帖子加载失败',
                        description: '检查网络后再试一次。',
                        action: FilledButton(
                          onPressed: () => _load(reset: true),
                          child: const Text('重试'),
                        ),
                      )
                    : const EmptyState(
                        icon: Icons.article_outlined,
                        title: '还没有公开帖子',
                        description: '这个用户暂时没有公开主题帖。',
                      ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                  child: ThreadGrid(
                    feed: ThreadFeed(threads: _threads, users: _users),
                    repo: _repo,
                  ),
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
        ),
      ),
    );
  }
}