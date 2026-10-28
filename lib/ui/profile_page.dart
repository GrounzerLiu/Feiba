import 'package:material_ui/material_ui.dart';

import '../core/image_cache.dart';
import '../core/local_library.dart';
import '../core/session.dart';
import '../core/tieba_api.dart';
import '../core/theme_controller.dart';
import '../protocol/models/user.dart' as protocol;
import 'format.dart';
import 'library_page.dart';
import 'login_page.dart';
import 'widgets/name_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scroll = ScrollController();
  protocol.TiebaUser? _profile;
  bool _profileLoading = false;
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _loadProfile();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scroll.hasClients && _scroll.offset > 2;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  Future<void> _loadProfile() async {
    if (!Session.instance.isLoggedIn) {
      if (mounted) setState(() => _profile = null);
      return;
    }
    setState(() => _profileLoading = true);
    try {
      final profile = await TiebaApi.instance.selfProfile(refresh: true);
      if (mounted) setState(() => _profile = profile);
    } catch (_) {
      // Keep the account shell usable when the profile endpoint is unavailable.
    } finally {
      if (mounted) setState(() => _profileLoading = false);
    }
  }

  Future<void> _openLogin() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
    if (!mounted) return;
    setState(() {});
    _loadProfile();
  }

  Future<void> _logout() async {
    TiebaApi.instance.reset();
    await Session.instance.clear();
    if (!mounted) return;
    setState(() => _profile = null);
  }

  Future<void> _openLibrary({required int initialTab}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LibraryPage(initialTab: initialTab),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _openFollowing() => _openLibrary(initialTab: 2);

  Future<void> _chooseTheme() async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final current = ThemeController.instance.mode;
        final options = <(ThemeMode, String, IconData)>[
          (ThemeMode.system, '跟随系统', Icons.brightness_auto_rounded),
          (ThemeMode.light, '浅色', Icons.light_mode_rounded),
          (ThemeMode.dark, '深色', Icons.dark_mode_rounded),
        ];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            18 + MediaQuery.viewPaddingOf(sheetContext).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: Text('外观', style: theme.textTheme.titleMedium),
              ),
              for (final option in options)
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  leading: Icon(option.$3),
                  title: Text(option.$2),
                  trailing: current == option.$1
                      ? Icon(
                          Icons.check_rounded,
                          color: theme.colorScheme.primary,
                        )
                      : null,
                  onTap: () => Navigator.of(sheetContext).pop(option.$1),
                ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      await ThemeController.instance.setMode(selected);
      if (mounted) setState(() {});
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('清理图片缓存？'),
        content: const Text('会清理头像、帖子图片的磁盘和内存缓存，不会删除浏览记录和收藏。'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('清理'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await FeibaImageCache.clear();
    PaintingBinding.instance.imageCache
      ..clear()
      ..clearLiveImages();
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('图片缓存已清理')));
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
        SizedBox(height: 8),
        Text('游客可以浏览、搜索和收藏；登录后同步账号功能。'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        LocalLibrary.instance,
        ThemeController.instance,
      ]),
      builder: (context, _) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final theme = Theme.of(context);
    final library = LocalLibrary.instance;
    final loggedIn = Session.instance.isLoggedIn;
    final profile = _profile;
    final name = Session.instance.userName?.trim();
    final displayName = loggedIn
        ? (profile?.displayName ??
              (name == null || name.isEmpty ? '已登录' : name))
        : '未登录';
    final topInset = MediaQuery.viewPaddingOf(context).top > 0
        ? MediaQuery.viewPaddingOf(context).top
        : 24.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            controller: _scroll,
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
                        NameAvatar(
                          name: displayName,
                          imageUrl: profile?.avatarUrl,
                          size: 64,
                        ),
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
                                loggedIn
                                    ? (_profileLoading
                                          ? '正在同步账号资料…'
                                          : '已连接贴吧账号')
                                    : '游客模式 · 数据保存在本机',
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
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.18,
                              ),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('登录'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: <Widget>[
                        if (loggedIn) ...<Widget>[
                          _Stat(
                            label: '关注',
                            value: profile == null
                                ? '—'
                                : compactCount(profile.followNum),
                          ),
                          _divider(),
                          _Stat(
                            label: '粉丝',
                            value: profile == null
                                ? '—'
                                : compactCount(profile.fanNum),
                          ),
                          _divider(),
                          _Stat(
                            label: '发帖',
                            value: profile == null
                                ? '—'
                                : compactCount(profile.postNum),
                          ),
                        ] else ...<Widget>[
                          _Stat(
                            label: '浏览',
                            value: compactCount(library.historyCount),
                          ),
                          _divider(),
                          _Stat(
                            label: '收藏',
                            value: compactCount(library.favoriteCount),
                          ),
                          _divider(),
                          const _Stat(label: '关注', value: '—'),
                        ],
                        const Spacer(),
                        if (loggedIn)
                          TextButton(
                            onPressed: _logout,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white.withValues(
                                alpha: 0.9,
                              ),
                            ),
                            child: const Text('退出登录'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!loggedIn)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
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
                            '不登录也能浏览、搜索和收藏。登录后可同步关注、消息和账号数据。',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
                child: Text('我的空间', style: theme.textTheme.titleMedium),
              ),
              _MenuCard(
                children: <Widget>[
                  _MenuItem(
                    icon: Icons.people_alt_outlined,
                    title: '我的关注',
                    trailing: library.followedForums.isEmpty
                        ? null
                        : compactCount(library.followedForums.length),
                    onTap: _openFollowing,
                  ),
                  _MenuItem(
                    icon: Icons.history_rounded,
                    title: '浏览历史',
                    trailing: library.historyCount > 0
                        ? compactCount(library.historyCount)
                        : null,
                    onTap: () => _openLibrary(initialTab: 0),
                  ),
                  _MenuItem(
                    icon: Icons.bookmark_border_rounded,
                    title: '我的收藏',
                    trailing: library.favoriteCount > 0
                        ? compactCount(library.favoriteCount)
                        : null,
                    onTap: () => _openLibrary(initialTab: 1),
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
                    icon: ThemeController.instance.icon,
                    title: '外观',
                    trailing: ThemeController.instance.label,
                    onTap: _chooseTheme,
                  ),
                  _MenuItem(
                    icon: Icons.cleaning_services_outlined,
                    title: '清理图片缓存',
                    onTap: _clearCache,
                  ),
                  _MenuItem(
                    icon: Icons.info_outline_rounded,
                    title: '关于 Feiba',
                    onTap: _about,
                  ),
                  _MenuItem(
                    icon: Icons.description_outlined,
                    title: '开源许可',
                    onTap: () => showLicensePage(
                      context: context,
                      applicationName: 'Feiba',
                      applicationVersion: '0.1.0',
                    ),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topInset + 48,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                color: _scrolled
                    ? theme.scaffoldBackgroundColor
                    : Colors.transparent,
                padding: EdgeInsets.only(top: topInset),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _scrolled ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('我的空间', style: theme.textTheme.titleMedium),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
