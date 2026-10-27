import 'package:feiba/data/models/content_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:feiba/data/models/forum_page.dart';
import 'package:feiba/ui/theme.dart';
import 'package:feiba/ui/widgets/thread_card.dart';

void main() {
  testWidgets('thread card renders metadata in dark theme', (
    WidgetTester tester,
  ) async {
    final thread = ThreadSummary(
      tid: 1,
      title: '一个安静的测试主题帖',
      content: const <ContentNode>[],
      replyNum: 12,
      viewNum: 345,
      agreeNum: 6,
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.dark),
        home: Scaffold(
          body: ThreadCard(
            thread: thread,
            authorName: '测试用户',
            forumName: '原神吧',
          ),
        ),
      ),
    );

    expect(find.text('一个安静的测试主题帖'), findsOneWidget);
    expect(find.text('测试用户'), findsOneWidget);
    expect(find.text('原神吧'), findsOneWidget);
  });
}
