import 'package:flutter/material.dart';

import '../core/session.dart';
import 'forum_page.dart';
import 'login_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  static const List<String> _hotForums = <String>[
    '原神',
    '孙笑川',
    '李毅',
    'steam',
    '明日方舟',
    '崩坏星穹铁道',
  ];

  void _openForum(String name) {
    final kw = name.trim();
    if (kw.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: kw)),
    );
  }

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SearchPage(initialKeyword: _controller.text.trim()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feiba'),
        actions: <Widget>[
          IconButton(
            tooltip: Session.instance.isLoggedIn ? '账号' : '登录',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const LoginPage()),
              );
              if (mounted) setState(() {});
            },
            icon: Icon(
              Session.instance.isLoggedIn
                  ? Icons.account_circle
                  : Icons.account_circle_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '搜索贴吧，或直接输入吧名',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => _openSearch(),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              FilledButton.tonalIcon(
                onPressed: _openSearch,
                icon: const Icon(Icons.travel_explore),
                label: const Text('搜索贴吧'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => _openForum(_controller.text),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('直接进入'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('热门吧', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _hotForums
                .map((e) => ActionChip(label: Text(e), onPressed: () => _openForum(e)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
