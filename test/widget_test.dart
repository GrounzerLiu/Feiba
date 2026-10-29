import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:feiba/ui/main_shell.dart';
import 'package:feiba/ui/theme.dart';

void main() {
  testWidgets('shell renders following and square navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );

    expect(find.text('关注'), findsWidgets);
    expect(find.text('动态'), findsOneWidget);
    expect(find.text('吧友'), findsOneWidget);
    expect(find.textContaining('关注的吧'), findsOneWidget);
    expect(find.text('广场'), findsWidgets);
    expect(find.text('消息'), findsWidgets);
    expect(find.text('我的'), findsWidgets);
  });

  testWidgets('adaptive shell switches between bottom bar and rail', (
    WidgetTester tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.binding.setSurfaceSize(const Size(1200, 900));
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );
    await tester.pump();
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );
    await tester.pump();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('square tab exposes real-data sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );

    await tester.tap(find.byIcon(Icons.explore_outlined));
    await tester.pumpAndSettle();
    expect(find.text('话题'), findsOneWidget);
    expect(find.text('推荐'), findsOneWidget);
    expect(find.text('热吧'), findsOneWidget);
    expect(find.text('热帖'), findsOneWidget);
    await tester.tap(find.text('推荐'));
    await tester.pumpAndSettle();
    expect(find.text('游戏'), findsWidgets);
  });
}