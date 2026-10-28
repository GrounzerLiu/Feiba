import 'package:flutter/material.dart';

import '../core/local_library.dart';
import '../data/models/forum_search.dart';
import '../data/protocol_browse_repository.dart';
import '../protocol/models/search.dart';
import 'format.dart';
import 'forum_page.dart';
import 'thread_page.dart';
import 'widgets/empty_state.dart';
import 'widgets/name_avatar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.initialKeyword = ''});

  final String initialKeyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialKeyword,
  );

  List<ForumSearchResult> _forums = const <ForumSearchResult>[];
  List<SearchGlobal> _results = const <SearchGlobal>[];
  bool _loading = false;
  String? _error;
  bool _searched = false;

  static const List<String> _suggestions = <String>[
    '原神',
    '孙笑川',
    'steam',
    '明日方舟',
    '崩坏星穹铁道',
    '摄影',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialKeyword.trim().isNotEmpty) _search();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final keyword = _controller.text.trim();
    if (keyword.isEmpty) return;
    LocalLibrary.instance.recordSearch(keyword);
    FocusScope.of(context).unfocus();
    setState(() {
      _loading = true;
      _error = null;
      _searched = true;
    });

    List<ForumSearchResult> forums = const <ForumSearchResult>[];
    List<SearchGlobal> discussions = const <SearchGlobal>[];
    Object? failure;
    final forumFuture = _repo.searchForums(keyword);
    final discussionFuture = _repo.searchGlobal(keyword);
    try {
      forums = await forumFuture;
    } catch (error) {
      failure = error;
    }
    try {
      discussions = await discussionFuture;
    } catch (error) {
      failure ??= error;
    }
    if (!mounted) return;
    setState(() {
      _forums = forums;
      _results = discussions;
      _loading = false;
      _error = forums.isEmpty && discussions.isEmpty && failure != null
          ? failure.toString()
          : null;
    });
  }

  void _openThread(SearchGlobal item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadPage(
          tid: item.tid,
          title: item.title,
          forumName: item.forumName,
          authorName: item.authorShowName,
        ),
      ),
    );
  }

  void _openForum(String name) {
    if (name.trim().isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ForumPage(forumName: name.trim()),
      ),
    );
  }

  void _showAllForums() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return FractionallySizedBox(
          heightFactor: 0.78,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Text(
                  '相关贴吧 ${_forums.length}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                  itemCount: _forums.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final forum = _forums[index];
                    return _ForumSearchTile(
                      forum: forum,
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        _openForum(forum.name);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyword = _controller.text.trim();
    final empty = _forums.isEmpty && _results.isEmpty;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 16, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        autofocus: widget.initialKeyword.isEmpty,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _search(),
                        decoration: InputDecoration(
                          hintText: '搜索吧和全站讨论',
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: _controller.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    _controller.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _search,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 46),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('搜索'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!_searched)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (LocalLibrary
                        .instance
                        .recentSearches
                        .isNotEmpty) ...<Widget>[
                      Row(
                        children: <Widget>[
                          Text('最近搜索', style: theme.textTheme.titleMedium),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              LocalLibrary.instance.clearSearches();
                              setState(() {});
                            },
                            child: const Text('清空'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: <Widget>[
                          for (final recent
                              in LocalLibrary.instance.recentSearches)
                            ActionChip(
                              label: Text(recent),
                              onPressed: () {
                                _controller.text = recent;
                                _search();
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                    Text('热门搜索', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        for (final suggestion in _suggestions)
                          ActionChip(
                            label: Text(suggestion),
                            onPressed: () {
                              _controller.text = suggestion;
                              _search();
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    const EmptyState(
                      icon: Icons.travel_explore_rounded,
                      title: '从一个关键词开始',
                      description: '同时搜索相关贴吧和全站讨论。',
                    ),
                  ],
                ),
              ),
            )
          else if (_loading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error != null && empty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: Icons.cloud_off_rounded,
                title: '搜索失败',
                description: '检查网络后再试一次。',
                action: FilledButton(
                  onPressed: _search,
                  child: const Text('重试'),
                ),
              ),
            )
          else if (empty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: Icons.search_off_rounded,
                title: '没有找到相关内容',
                description: '换个关键词试试，或者直接进入这个吧。',
                action: OutlinedButton(
                  onPressed: keyword.isEmpty ? null : () => _openForum(keyword),
                  child: Text(keyword.isEmpty ? '进入吧' : '进入「$keyword」吧'),
                ),
              ),
            )
          else ...<Widget>[
            if (_forums.isNotEmpty) ...<Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 4),
                  child: Row(
                    children: <Widget>[
                      Text('相关贴吧', style: theme.textTheme.titleMedium),
                      const SizedBox(width: 7),
                      Text(
                        '${_forums.length}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.55,
                  children: <Widget>[
                    for (final forum in _forums.take(6))
                      _ForumResultCard(
                        forum: forum,
                        onTap: () => _openForum(forum.name),
                      ),
                  ],
                ),
              ),
              if (_forums.length > 6)
                SliverToBoxAdapter(
                  child: Center(
                    child: TextButton(
                      onPressed: _showAllForums,
                      child: Text('查看全部 ${_forums.length} 个吧'),
                    ),
                  ),
                ),
            ],
            if (_results.isNotEmpty) ...<Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Row(
                    children: <Widget>[
                      Text('相关讨论', style: theme.textTheme.titleMedium),
                      const SizedBox(width: 7),
                      Text(
                        '${_results.length}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                sliver: SliverList.separated(
                  itemCount: _results.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = _results[index];
                    return _SearchResultCard(
                      item: item,
                      onTap: () => _openThread(item),
                    );
                  },
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _ForumResultCard extends StatelessWidget {
  const _ForumResultCard({required this.forum, required this.onTap});

  final ForumSearchResult forum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: <Widget>[
              NameAvatar(
                name: forum.displayName,
                imageUrl: forum.avatar,
                size: 34,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      forum.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${compactCount(forum.memberNum)} 关注',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForumSearchTile extends StatelessWidget {
  const _ForumSearchTile({required this.forum, required this.onTap});

  final ForumSearchResult forum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        onTap: onTap,
        leading: NameAvatar(
          name: forum.displayName,
          imageUrl: forum.avatar,
          size: 40,
        ),
        title: Text(
          forum.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${compactCount(forum.memberNum)} 关注 · ${compactCount(forum.postNum)} 帖子',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.item, required this.onTap});

  final SearchGlobal item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = item.title.trim().isEmpty ? item.content : item.title;
    final snippet = item.content.trim();
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NameAvatar(
                name: item.forumName.isEmpty ? '吧' : item.forumName,
                size: 42,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (snippet.isNotEmpty && snippet != title) ...<Widget>[
                      const SizedBox(height: 5),
                      Text(
                        snippet,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 7),
                    Text(
                      <String>[
                        if (item.forumName.isNotEmpty) item.forumName,
                        if (item.authorShowName.isNotEmpty) item.authorShowName,
                        if (item.postNum > 0)
                          '${compactCount(item.postNum)} 回复',
                        relativeTime(item.createTime),
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
