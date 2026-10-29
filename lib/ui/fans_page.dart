import 'package:material_ui/material_ui.dart';

import '../core/tieba_api.dart';
import '../protocol/models/follow.dart';
import 'user_page.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/name_avatar.dart';

class FansPage extends StatefulWidget {
  const FansPage({super.key, required this.userId, this.userName});

  final int userId;
  final String? userName;

  @override
  State<FansPage> createState() => _FansPageState();
}

class _FansPageState extends State<FansPage> {
  final ScrollController _scroll = ScrollController();
  final List<FollowUser> _users = <FollowUser>[];
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
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 300) {
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
        _users.clear();
      }
    });
    try {
      final page = await TiebaApi.instance.fans(widget.userId, pn: _page);
      if (!mounted) return;
      setState(() {
        _users.addAll(page.objs);
        _hasMore = page.hasMore;
        _page += 1;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = tiebaErrorMessage(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasName = widget.userName != null && widget.userName!.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hasName ? '${widget.userName!}的粉丝' : '粉丝',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _load(reset: true),
        child: _users.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: _loading
                        ? const LoadingIndicator(minHeight: 200)
                        : _error != null
                        ? EmptyState(
                            icon: Icons.lock_outline_rounded,
                            title: '粉丝列表加载失败',
                            description: _error!,
                            action: FilledButton(
                              onPressed: () => _load(reset: true),
                              child: const Text('重试'),
                            ),
                          )
                        : const EmptyState(
                            icon: Icons.people_outline_rounded,
                            title: '还没有粉丝',
                            description: '这个用户暂时没有公开粉丝。',
                          ),
                  ),
                ],
              )
            : ListView.separated(
                controller: _scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                itemCount: _users.length + (_hasMore ? 1 : 0),
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  if (index >= _users.length) {
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
                  final user = _users[index];
                  return Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surface,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      leading: NameAvatar(
                        name: user.displayName,
                        imageUrl: user.avatarUrl,
                        size: 42,
                      ),
                      title: Text(
                        user.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: user.userName.isEmpty
                          ? null
                          : Text(
                              '@${user.userName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => UserPage(
                            userId: user.userId,
                            initialName: user.displayName,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}