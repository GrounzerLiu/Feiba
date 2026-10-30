import 'package:material_ui/material_ui.dart';

import '../core/tieba_api.dart';
import '../data/protocol_browse_repository.dart';
import '../protocol/models/rank_forums.dart';
import '../protocol/models/rank_member_users.dart';
import '../protocol/models/rank_users.dart';
import 'format.dart';
import 'forum_page.dart';
import 'widgets/forum_avatar.dart';
import 'widgets/level_badge.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/name_avatar.dart';

class ForumRankingPage extends StatelessWidget {
  const ForumRankingPage({super.key, required this.forumName});

  final String forumName;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$forumName · 榜单', maxLines: 1, overflow: TextOverflow.ellipsis),
          bottom: const TabBar(
            tabs: <Tab>[
              Tab(text: '签到榜'),
              Tab(text: '等级榜'),
              Tab(text: '最新成员'),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth.clamp(0.0, 1000.0);
            return Center(
              child: SizedBox(
                width: width,
                height: constraints.maxHeight,
                child: TabBarView(
                  children: <Widget>[
                    _SignRankTab(forumName: forumName),
                    _LevelRankTab(forumName: forumName),
                    _MemberRankTab(forumName: forumName),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RankResult<T> {
  const _RankResult(this.items, this.hasMore);

  final List<T> items;
  final bool hasMore;
}

class _PagedRankList<T> extends StatefulWidget {
  const _PagedRankList({
    super.key,
    required this.load,
    required this.itemBuilder,
    required this.emptyText,
  });

  final Future<_RankResult<T>> Function(int page) load;
  final Widget Function(BuildContext context, T item, int rank) itemBuilder;
  final String emptyText;

  @override
  State<_PagedRankList<T>> createState() => _PagedRankListState<T>();
}

class _PagedRankListState<T> extends State<_PagedRankList<T>> {
  final ScrollController _scroll = ScrollController();
  final List<T> _items = <T>[];
  int _page = 1;
  bool _loading = false;
  bool _loadingMore = false;
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
    if (!_scroll.hasClients || _loading || _loadingMore || !_hasMore) return;
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 240) {
      _load();
    }
  }

  Future<void> _load({bool reset = false}) async {
    if (_loading || _loadingMore) return;
    setState(() {
      if (reset) {
        _items.clear();
        _page = 1;
        _hasMore = true;
        _error = null;
        _loading = true;
      } else {
        _loadingMore = true;
      }
    });
    try {
      final result = await widget.load(_page);
      if (!mounted) return;
      setState(() {
        _items.addAll(result.items);
        _hasMore = result.hasMore;
        _page += 1;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = tiebaErrorMessage(error));
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && _items.isEmpty) {
      return const LoadingIndicator(minHeight: 260);
    }
    if (_error != null && _items.isEmpty) {
      return _RankError(message: _error!, onRetry: () => _load(reset: true));
    }
    if (_items.isEmpty) {
      return Center(
        child: Text(widget.emptyText, style: Theme.of(context).textTheme.bodyMedium),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _load(reset: true),
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        itemCount: _items.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: _loadingMore
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.2),
                      )
                    : TextButton(
                        onPressed: () => _load(),
                        child: const Text('加载更多'),
                      ),
              ),
            );
          }
          final rank = index + 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: widget.itemBuilder(context, _items[index], rank),
          );
        },
      ),
    );
  }
}

class _SignRankTab extends StatefulWidget {
  const _SignRankTab({required this.forumName});

  final String forumName;

  @override
  State<_SignRankTab> createState() => _SignRankTabState();
}

class _SignRankTabState extends State<_SignRankTab> {
  static const List<RankForumType> _types = <RankForumType>[
    RankForumType.today,
    RankForumType.yesterday,
    RankForumType.weekly,
    RankForumType.monthly,
  ];
  static const List<String> _labels = <String>['今日', '昨日', '周榜', '月榜'];
  int _typeIndex = 2;
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Row(
            children: <Widget>[
              for (var i = 0; i < _types.length; i++)
                Padding(
                  padding: EdgeInsets.only(right: i == _types.length - 1 ? 0 : 8),
                  child: ChoiceChip(
                    label: Text(_labels[i]),
                    selected: _typeIndex == i,
                    onSelected: (_) => setState(() => _typeIndex = i),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: _PagedRankList<RankForum>(
            key: ValueKey<int>(_typeIndex),
            load: (page) async {
              final result = await TiebaApi.instance.forumSignRanking(
                widget.forumName,
                pn: page,
                type: _types[_typeIndex],
              );
              return _RankResult<RankForum>(result.objs, result.hasMore);
            },
            emptyText: '这个吧还没有签到数据',
            itemBuilder: (context, item, rank) {
              return _RankRow(
                rank: rank,
                title: Row(
                  children: <Widget>[
                    ForumAvatar(name: item.fname, repo: _repo, size: 32),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.fname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: '${compactCount(item.signNum)} 签到 · ${compactCount(item.memberNum)} 成员',
                trailing: item.hasBawu
                    ? const _RankTag(label: '吧务')
                    : null,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ForumPage(forumName: item.fname),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LevelRankTab extends StatelessWidget {
  const _LevelRankTab({required this.forumName});

  final String forumName;

  @override
  Widget build(BuildContext context) {
    return _PagedRankList<RankUser>(
      load: (page) async {
        final result = await TiebaApi.instance.forumLevelRanking(
          forumName,
          pn: page,
        );
        return _RankResult<RankUser>(result.objs, result.hasMore);
      },
      emptyText: '这个吧还没有等级排名',
      itemBuilder: (context, item, rank) {
        return _RankRow(
          rank: rank,
          title: Row(
            children: <Widget>[
              NameAvatar(name: item.userName, size: 32),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (item.isVip)
                const Icon(Icons.workspace_premium_rounded, size: 16),
            ],
          ),
          subtitle: '${item.exp} 经验',
          trailing: LevelBadge(level: item.level),
        );
      },
    );
  }
}

class _MemberRankTab extends StatelessWidget {
  const _MemberRankTab({required this.forumName});

  final String forumName;

  @override
  Widget build(BuildContext context) {
    return _PagedRankList<MemberUser>(
      load: (page) async {
        final result = await TiebaApi.instance.forumMemberRanking(
          forumName,
          pn: page,
        );
        return _RankResult<MemberUser>(result.objs, result.hasMore);
      },
      emptyText: '这个吧还没有成员数据',
      itemBuilder: (context, item, rank) {
        return _RankRow(
          rank: rank,
          title: Row(
            children: <Widget>[
              NameAvatar(
                name: item.userName,
                imageUrl: item.portrait,
                size: 32,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          subtitle: '最近加入',
          trailing: LevelBadge(level: item.level),
        );
      },
    );
  }
}

class _RankRow extends StatelessWidget {
  const _RankRow({
    required this.rank,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final int rank;
  final Widget title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 9, 12, 9),
          child: Row(
            children: <Widget>[
              _RankNumber(rank: rank),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...<Widget>[
                const SizedBox(width: 8),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RankNumber extends StatelessWidget {
  const _RankNumber({required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (rank) {
      1 => const Color(0xFFD9A441),
      2 => const Color(0xFF9AA3B2),
      3 => const Color(0xFFB8754A),
      _ => theme.colorScheme.onSurfaceVariant,
    };
    return SizedBox(
      width: 30,
      child: Text(
        '$rank',
        textAlign: TextAlign.center,
        style: theme.textTheme.titleSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RankTag extends StatelessWidget {
  const _RankTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _RankError extends StatelessWidget {
  const _RankError({required this.message, required this.onRetry});

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
            const Icon(Icons.cloud_off_rounded, size: 34),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}