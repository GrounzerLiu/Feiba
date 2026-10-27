import 'package:flutter/material.dart';

import '../core/session.dart';
import 'login_page.dart';
import 'widgets/name_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _openLogin() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (mounted) setState(() {});
  }

  Future<void> _logout() async {
    await Session.instance.clear();
    if (mounted) setState(() {});
  }

  void _todo(String title) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$title功能正在接入中')));
  }

  void _about() {
    showAboutDialog(
      context: context,
      applicationName: 'Feiba',
      applicationVersion: '0.1.0',
      applicationLegalese: '非官方贴吧客户端 · 协议层基于 aiotieba',
      children: const <Widget>[
        SizedBox(height: 12),
        Text('Feiba 是一个开源的第三方贴吧客户端，使用 Flutter 构建。'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loggedIn = Session.instance.isLoggedIn;
    final name = Session.instance.userName?.trim();
    final displayName = (name == null || name.isEmpty) ? '未登录' : name;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.paddingOf(context).top + 18,
              20,
              26,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  theme.colorScheme.primary.withValues(alpha: 0.95),
                  theme.colorScheme.primary.withValues(alpha: 0.62),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    NameAvatar(name: displayName, size: 64),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            displayName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            loggedIn ? '已连接贴吧账号' : '登录后同步关注和消息',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!loggedIn)
                      FilledButton.tonal(
                        onPressed: _openLogin,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.18),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('登录'),
                      ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: <Widget>[
                    const _Stat(label: '关注', value: '—'),
                    _divider(),
                    const _Stat(label: '粉丝', value: '—'),
                    _divider(),
                    const _Stat(label: '发帖', value: '—'),
                    const Spacer(),
                    if (loggedIn)
                      TextButton(
                        onPressed: _logout,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white.withValues(alpha: 0.9),
                        ),
                        child: const Text('退出登录'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Text('我的空间', style: theme.textTheme.titleMedium),
          ),
          _MenuCard(
            children: <Widget>[
              _MenuItem(
                icon: Icons.people_alt_outlined,
                title: '我的关注',
                onTap: () => _todo('关注列表'),
              ),
              _MenuItem(
                icon: Icons.history_rounded,
                title: '浏览历史',
                onTap: () => _todo('浏览历史'),
              ),
              _MenuItem(
                icon: Icons.bookmark_border_rounded,
                title: '我的收藏',
                onTap: () => _todo('收藏'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Text('设置', style: theme.textTheme.titleMedium),
          ),
          _MenuCard(
            children: <Widget>[
              _MenuItem(
                icon: Icons.palette_outlined,
                title: '外观',
                trailing: '跟随系统',
                onTap: () => _todo('外观设置'),
              ),
              _MenuItem(
                icon: Icons.cleaning_services_outlined,
                title: '清理缓存',
                onTap: () => _todo('缓存清理'),
              ),
              _MenuItem(
                icon: Icons.info_outline_rounded,
                title: '关于 Feiba',
                onTap: _about,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Center(
            child: Text(
              'Feiba · 非官方贴吧客户端',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 28,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white.withValues(alpha: 0.22),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.72),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            for (var i = 0; i < children.length; i++) ...<Widget>[
              if (i > 0) const Divider(height: 1, indent: 52),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 22),
      title: Text(title, style: theme.textTheme.bodyMedium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (trailing != null)
            Text(
              trailing!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(width: 4),
          Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      minLeadingWidth: 22,
    );
  }
}
