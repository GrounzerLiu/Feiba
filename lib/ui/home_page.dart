import 'package:flutter/material.dart';

import 'forum_page.dart';

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
    'ns吧',
    '明日方舟',
  ];

  void _open(String name) {
    final kw = name.trim();
    if (kw.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ForumPage(forumName: kw)),
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
      appBar: AppBar(title: const Text('Feiba')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '输入吧名，例如「原神」',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: _open,
          ),
          const SizedBox(height: 24),
          Text('热门吧', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _hotForums
                .map((e) => ActionChip(label: Text(e), onPressed: () => _open(e)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
