import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:feiba/ui/main_shell.dart';
import 'package:feiba/ui/theme.dart';

void main() {
  testWidgets('shell renders home feed and bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );

    expect(find.text('贴吧'), findsWidgets);
    expect(find.text('热门讨论'), findsOneWidget);
    expect(find.text('常逛的吧'), findsOneWidget);
    expect(find.text('首页'), findsOneWidget);
    expect(find.text('发现'), findsOneWidget);
    expect(find.text('消息'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });

  testWidgets('discover tab is reachable', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const MainShell(loadFeed: false),
      ),
    );

    await tester.tap(find.text('发现'));
    await tester.pumpAndSettle();
    expect(find.text('按兴趣逛'), findsOneWidget);
    expect(find.text('游戏'), findsWidgets);
  });
}
