import 'package:material_ui/material_ui.dart';

import '../core/session.dart';
import '../core/tieba_api.dart';
import '../protocol/models/notification.dart';
import 'format.dart';
import 'login_page.dart';
import 'thread_page.dart';
import 'route_transitions.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/empty_state.dart';
import 'widgets/name_avatar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _filter = 0;
  bool _loading = false;
  String? _error;
  List<TiebaReply> _replies = <TiebaReply>[];
  List<TiebaAt> _ats = <TiebaAt>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _openLogin() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (!mounted) return;
    setState(() {});
    if (Session.instance.isLoggedIn) _load();
  }

  Future<void> _load() async {
    if (!Session.instance.isLoggedIn) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await Future.wait<Object>(<Future<Object>>[
        TiebaApi.instance.replies(),
        TiebaApi.instance.ats(),
      ]);
      if (!mounted) return;
      setState(() {
        _replies = results[0] as List<TiebaReply>;
        _ats = results[1] as List<TiebaAt>;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = tiebaErrorMessage(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Object> get _items {
    final items = <Object>[
      if (_filter != 2) ..._replies,
      if (_filter != 1) ..._ats,
    ];
    items.sort((a, b) => _timeOf(b).compareTo(_timeOf(a)));
    return items;
  }

  int _timeOf(Object item) {
    if (item is TiebaReply) return item.createTime;
    if (item is TiebaAt) return item.createTime;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loggedIn = Session.instance.isLoggedIn;
    final items = _items;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('消息', style: theme.textTheme.headlineSmall),
                          if (!loggedIn) ...<Widget>[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                '游客',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '回复、@ 和系统通知都会出现在这里',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Row(
                  children: <Widget>[
                    for (var i = 0; i < 3; i++) ...<Widget>[
                      if (i > 0) const SizedBox(width: 8),
                      ChoiceChip(
                        label: Text(<String>['全部', '回复我的', '@ 我的'][i]),
                        selected: _filter == i,
                        onSelected: (_) => setState(() => _filter = i),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (!loggedIn) ...<Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.info_outline_rounded,
                          size: 19,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            '浏览、搜索和收藏都不需要登录；登录后才能同步回复和 @。',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.mark_email_unread_outlined,
                  title: '登录后同步消息',
                  description: '游客可以继续浏览和收藏；登录贴吧账号后，回复、@ 和系统通知会同步到这里。',
                  action: FilledButton(
                    onPressed: _openLogin,
                    child: const Text('去登录'),
                  ),
                ),
              ),
            ] else if (_loading && items.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: LoadingIndicator(),
              )
            else if (_error != null && items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: '消息加载失败',
                  description: _error,
                  action: FilledButton(
                    onPressed: _load,
                    child: const Text('重试'),
                  ),
                ),
              )
            else if (items.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: '暂时没有新消息',
                  description: '有新回复、@ 或系统通知时会在这里提醒你。',
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 24),
                sliver: SliverList.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) =>
                      _NotificationCard(item: items[index]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final Object item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReply = item is TiebaReply;
    final reply = isReply ? item as TiebaReply : null;
    final at = isReply ? null : item as TiebaAt;
    final user = reply?.user ?? at?.user;
    final name = user?.displayName ?? '贴吧用户';
    final text = reply?.text ?? at?.text ?? '';
    final fname = reply?.fname ?? at?.fname ?? '';
    final time = reply?.createTime ?? at?.createTime ?? 0;
    final tid = reply?.tid ?? at?.tid ?? 0;
    final type = isReply ? '回复' : '@ 我';
    final icon = isReply
        ? Icons.chat_bubble_outline_rounded
        : Icons.alternate_email_rounded;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: tid == 0
            ? null
            : () => Navigator.of(context).push(
                threadPageRoute<void>(ThreadPage(tid: tid, forumName: fname)),
              ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  NameAvatar(name: name, imageUrl: user?.avatarUrl, size: 34),
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
                        const SizedBox(height: 2),
                        Text(
                          <String>[
                            type,
                            if (fname.isNotEmpty) fname,
                            relativeTime(time),
                          ].where((part) => part.isNotEmpty).join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(icon, size: 17, color: theme.colorScheme.primary),
                ],
              ),
              if (text.isNotEmpty) ...<Widget>[
                const SizedBox(height: 9),
                Text(
                  text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}