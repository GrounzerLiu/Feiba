import 'package:material_ui/material_ui.dart';

import '../core/local_library.dart';
import '../data/protocol_browse_repository.dart';
import '../protocol/core/enums.dart' show ContentType;
import '../protocol/models/search.dart';
import 'format.dart';
import 'route_transitions.dart';
import 'thread_page.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_indicator.dart';

/// Search posts inside one forum using the ported /c/s/searchpost API.
class ForumSearchPage extends StatefulWidget {
  const ForumSearchPage({
    super.key,
    required this.forumName,
    this.initialKeyword = '',
  });

  final String forumName;
  final String initialKeyword;

  @override
  State<ForumSearchPage> createState() => _ForumSearchPageState();
}

class _ForumSearchPageState extends State<ForumSearchPage> {
  final ProtocolBrowseRepository _repo = ProtocolBrowseRepository();
  final ScrollController _scroll = ScrollController();
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialKeyword,
  );

  final List<SearchInForum> _items = <SearchInForum>[];
  bool _loading = false;
  bool _loadingMore = false;
  bool _searched = false;
  bool _hasMore = false;
  String? _error;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    if (widget.initialKeyword.trim().isNotEmpty) _search();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final position = _scroll.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      _search(more: true);
    }
  }

  Future<void> _search({bool more = false}) async {
    final keyword = _controller.text.trim();
    if (keyword.isEmpty || _loading || _loadingMore) return;
    if (more && !_hasMore) return;
    final page = more ? _page + 1 : 1;
    FocusScope.of(context).unfocus();
    setState(() {
      _searched = true;
      _error = null;
      if (more) {
        _loadingMore = true;
      } else {
        _loading = true;
      }
    });
    if (!more) LocalLibrary.instance.recordSearch(keyword);

    try {
      final result = await _repo.searchInForum(
        widget.forumName,
        keyword,
        pn: page,
      );
      if (!mounted) return;
      setState(() {
        if (!more) _items.clear();
        final seen = <String>{
          for (final item in _items) '${item.tid}:${item.pid}',
        };
        for (final item in result.objs) {
          final key = '${item.tid}:${item.pid}';
          if (seen.add(key)) _items.add(item);
        }
        _page = page;
        _hasMore = result.hasMore;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadingMore = false;
        });
      }
    }
  }

  void _openThread(SearchInForum item) {
    Navigator.of(context).push(
      threadPageRoute<void>(
        ThreadPage(
          tid: item.tid,
          title: item.title,
          forumName: widget.forumName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.forumName} · 吧内搜索',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
              child: SearchBar(
                controller: _controller,
                hintText: '搜索帖子或回复',
                leading: const Icon(Icons.search_rounded),
                trailing: <Widget>[
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      tooltip: '清空',
                      onPressed: () => setState(_controller.clear),
                      icon: const Icon(Icons.close_rounded, size: 18),
                    ),
                  TextButton(
                    onPressed: () => _search(),
                    child: const Text('搜索'),
                  ),
                ],
                onSubmitted: (_) => _search(),
              ),
            ),
            Expanded(child: _buildBody(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_loading && _items.isEmpty) {
      return const LoadingIndicator(minHeight: 260);
    }
    if (_error != null && _items.isEmpty) {
      return EmptyState(
        icon: Icons.cloud_off_rounded,
        title: '搜索失败',
        description: _error,
        action: FilledButton(
          onPressed: () => _search(),
          child: const Text('重试'),
        ),
      );
    }
    if (!_searched) {
      return const EmptyState(
        icon: Icons.search_rounded,
        title: '搜索这个吧',
        description: '输入关键词，搜索帖子标题和回复内容。',
      );
    }
    if (_items.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off_rounded,
        title: '没有找到相关帖子',
        description: '换个关键词再试试。',
      );
    }

    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          if (_loadingMore) {
            return const LoadingIndicator(minHeight: 60);
          }
          return const SizedBox(height: 8);
        }
        final item = _items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _SearchResultCard(
            item: item,
            onTap: () => _openThread(item),
          ),
        );
      },
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.item, required this.onTap});

  final SearchInForum item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = item.title.trim().isEmpty ? '回复帖子' : item.title;
    final content = item.text.trim();
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    item.contentType == ContentType.comment
                        ? Icons.chat_bubble_outline_rounded
                        : Icons.article_outlined,
                    size: 15,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      item.showName.isEmpty ? '贴吧用户' : item.showName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    relativeTime(item.createTime),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              if (content.isNotEmpty) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}