import 'package:flutter/material.dart';

import 'forum_page.dart';
import 'search_page.dart';
import 'widgets/name_avatar.dart';
import 'widgets/section_header.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  static const List<_Category> _categories = <_Category>[
    _Category('游戏', Icons.sports_esports_rounded, Color(0xFF5B8DEF)),
    _Category('二次元', Icons.auto_awesome_rounded, Color(0xFF8A6BE8)),
    _Category('数码', Icons.devices_rounded, Color(0xFF3FAE8F)),
    _Category('体育', Icons.sports_basketball_rounded, Color(0xFFE08A4D)),
    _Category('生活', Icons.local_cafe_rounded, Color(0xFFD9647A)),
    _Category('摄影', Icons.camera_alt_rounded, Color(0xFF4C9DBD)),
  ];

  static const List<String> _forums = <String>[
    '原神',
    '孙笑川',
    '李毅',
    'steam',
    '明日方舟',
    '崩坏星穹铁道',
    '抗压背锅',
    '弱智',
    '王者荣耀',
    '和平精英',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    Text('发现', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      '从兴趣出发，找到同好',
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
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Material(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const SearchPage()),
                  ),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.search_rounded,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '搜索贴吧 / 帖子 / 用户',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(title: '按兴趣逛', subtitle: '选一个方向开始'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: <Widget>[
                for (final category in _categories)
                  _CategoryCard(
                    category: category,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            SearchPage(initialKeyword: category.title),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(title: '热门吧', subtitle: '大家最近都在逛'),
          ),
          SliverList.builder(
            itemCount: _forums.length,
            itemBuilder: (context, index) {
              final name = _forums[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                child: Material(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ForumPage(forumName: name),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      child: Row(
                        children: <Widget>[
                          NameAvatar(name: name, size: 38),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              name,
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          Text(
                            '进入',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '小提示：在首页搜索框输入吧名可以直接进入贴吧；帖子内支持图片查看和楼中楼展开。',
                      style: theme.textTheme.bodySmall?.copyWith(height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});

  final _Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: category.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(category.icon, color: category.color, size: 24),
              const Spacer(),
              Text(
                category.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: category.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Category {
  const _Category(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final Color color;
}
