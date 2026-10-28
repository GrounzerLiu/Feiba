import 'package:flutter/material.dart';

import '../core/local_library.dart';
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
    try {
      final results = await _repo.searchGlobal(keyword);
      if (!mounted) return;
      setState(() => _results = results);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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

  void _openForum([String? name]) {
    final keyword = (name ?? _controller.text).trim();
    if (keyword.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: keyword)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyword = _controller.text.trim();
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
                          hintText: '搜索全站帖子，或直接输入吧名',
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
                      description: '搜索全站讨论，或直接输入完整的吧名进入贴吧。',
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
          else if (_error != null)
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
          else if (_results.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: Icons.search_off_rounded,
                title: '没有找到相关讨论',
                description: '换个关键词试试，或直接进入这个吧。',
                action: OutlinedButton(
                  onPressed: keyword.isEmpty ? null : () => _openForum(keyword),
                  child: Text(keyword.isEmpty ? '进入吧' : '进入「$keyword」吧'),
                ),
              ),
            )
          else ...<Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
                child: Row(
                  children: <Widget>[
                    Text(
                      '找到 ${_results.length} 条讨论',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: keyword.isEmpty
                          ? null
                          : () => _openForum(keyword),
                      icon: const Icon(Icons.forum_outlined, size: 16),
                      label: Text('进入「$keyword」吧'),
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
