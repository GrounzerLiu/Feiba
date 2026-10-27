import 'package:flutter/material.dart';

import '../data/models/forum_search.dart';
import '../data/tieba_repository.dart';
import 'forum_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.initialKeyword = ''});

  final String initialKeyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TiebaRepository _repo = TiebaRepository();
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialKeyword);

  List<ForumSearchResult> _results = const <ForumSearchResult>[];
  bool _loading = false;
  String? _error;
  bool _searched = false;

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
    final kw = _controller.text.trim();
    if (kw.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
      _searched = true;
    });
    try {
      final results = await _repo.searchForums(kw);
      if (!mounted) return;
      setState(() => _results = results);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: widget.initialKeyword.isEmpty,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: '搜索贴吧',
            border: InputBorder.none,
          ),
          onSubmitted: (_) => _search(),
        ),
        actions: <Widget>[
          IconButton(onPressed: _search, icon: const Icon(Icons.search)),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(onPressed: _search, child: const Text('重试')),
            ],
          ),
        ),
      );
    }
    if (!_searched) {
      return const Center(child: Text('输入关键词搜索贴吧'));
    }
    if (_results.isEmpty) {
      return const Center(child: Text('没有找到相关贴吧'));
    }
    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final forum = _results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            backgroundImage:
                forum.avatar != null ? NetworkImage(forum.avatar!) : null,
            child: forum.avatar == null
                ? Text(forum.displayName.characters.first)
                : null,
          ),
          title: Text(forum.displayName),
          subtitle: Text(
            '关注 ${forum.memberNumText ?? forum.memberNum} · 贴子 ${forum.postNumText ?? forum.postNum}',
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ForumPage(forumName: forum.name),
            ),
          ),
        );
      },
    );
  }
}
