import 'package:flutter/material.dart';

import '../data/models/forum_page.dart';
import '../data/models/user_page.dart';
import '../data/protocol_browse_repository.dart';
import 'format.dart';
import 'thread_page.dart';
import 'widgets/empty_state.dart';
import 'widgets/name_avatar.dart';
import 'widgets/thread_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.userId, this.initialName});

  final int userId;
  final String? initialName;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  UserPageData? _data;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _repo.userHomepage(widget.userId);
      if (!mounted) return;
      setState(() => _data = data);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openThread(ThreadSummary thread) {
    final user = _data?.users[thread.authorId];
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadPage(
          tid: thread.tid,
          title: thread.title,
          forumName: thread.forumName,
          authorName: user?.displayName ?? _data?.profile?.displayName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = _data?.profile;
    final title = profile?.displayName ?? widget.initialName ?? '吧友主页';
    return Scaffold(
      appBar: AppBar(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: <Widget>[
          IconButton(
            tooltip: '刷新',
            onPressed: _load,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            if (_loading && _data == null)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            else if (_error != null && _data == null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: '主页加载失败',
                  description: '检查网络后再试一次。',
                  action: FilledButton(
                    onPressed: _load,
                    child: const Text('重试'),
                  ),
                ),
              )
            else if (profile == null)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.person_off_outlined,
                  title: '没有找到这个吧友',
                  description: '对方可能已经注销，或主页暂不可见。',
                ),
              )
            else ...<Widget>[
              SliverToBoxAdapter(child: _ProfileHeader(profile: profile)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
                  child: Row(
                    children: <Widget>[
                      Text('最近发帖', style: theme.textTheme.titleMedium),
                      const SizedBox(width: 8),
                      Text(
                        '${_data!.threads.length}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_data!.threads.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '这个吧友最近还没有公开主题帖。',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                SliverList.builder(
                  itemCount: _data!.threads.length,
                  itemBuilder: (context, index) {
                    final thread = _data!.threads[index];
                    final user = _data!.users[thread.authorId];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                      child: ThreadCard(
                        thread: thread,
                        authorName: user?.displayName ?? profile.displayName,
                        authorAvatar: user?.avatarUrl ?? profile.avatar,
                        forumName: thread.forumName,
                        onTap: () => _openThread(thread),
                      ),
                    );
                  },
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NameAvatar(
                name: profile.displayName,
                imageUrl: profile.avatar,
                size: 68,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            profile.displayName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        if (profile.isVip) ...<Widget>[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.workspace_premium_rounded,
                            size: 18,
                            color: Color(0xFFE0A33E),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Lv.${profile.level} · 吧龄 ${profile.postNum} 帖',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (profile.sign.isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            Text(
              profile.sign,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.5),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _Stat(label: '关注', value: profile.followNum),
              _Stat(label: '粉丝', value: profile.fanNum),
              _Stat(label: '发帖', value: profile.postNum),
              _Stat(label: '吧', value: profile.forumNum),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            compactCount(value),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
