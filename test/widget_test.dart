import 'package:flutter/material.dart';
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
    expect(find.text('看过'), findsOneWidget);
    expect(find.text('广场'), findsOneWidget);
    expect(find.text('消息'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
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

    await tester.tap(find.text('广场'));
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
