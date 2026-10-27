import 'package:flutter/material.dart';

import '../core/session.dart';
import 'login_page.dart';
import 'widgets/empty_state.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _filter = 0;

  Future<void> _openLogin() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loggedIn = Session.instance.isLoggedIn;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('消息', style: theme.textTheme.headlineSmall),
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
          SliverFillRemaining(
            hasScrollBody: false,
            child: loggedIn
                ? const EmptyState(
                    icon: Icons.notifications_none_rounded,
                    title: '暂时没有新消息',
                    description: '有新回复、@ 或系统通知时会在这里提醒你。',
                  )
                : EmptyState(
                    icon: Icons.mark_email_unread_outlined,
                    title: '登录后同步消息',
                    description: '登录贴吧账号后，可以在这里查看回复、@ 和系统通知。',
                    action: FilledButton(
                      onPressed: _openLogin,
                      child: const Text('去登录'),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
