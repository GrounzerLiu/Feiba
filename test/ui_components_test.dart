import 'package:feiba/data/models/content_node.dart';
import 'package:feiba/data/models/forum_page.dart';
import 'package:feiba/ui/theme.dart';
import 'package:feiba/ui/widgets/morphing_shape.dart';
import 'package:feiba/ui/widgets/name_avatar.dart';
import 'package:feiba/ui/widgets/thread_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

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

  testWidgets('expressive shape morph surface responds to press', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: Scaffold(
          body: Center(
            child: MorphingShape(
              size: 64,
              color: Colors.blue,
              child: const Icon(Icons.star_rounded),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(MorphingShape), findsOneWidget);
    await tester.tap(find.byType(MorphingShape));
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.byType(MorphingShape), findsOneWidget);
  });

  testWidgets('avatar clips its content into a circle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const Scaffold(body: NameAvatar(name: '测试', size: 48)),
      ),
    );

    expect(find.byType(ClipOval), findsOneWidget);
  });
}