import 'package:feiba/core/session.dart';
import 'package:feiba/ui/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Session.instance.clear();
  });

  testWidgets('guest can dismiss the login gate and keep browsing', (
    WidgetTester tester,
  ) async {
    var result = true;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => FilledButton(
              onPressed: () async {
                result = await ensureLoggedIn(
                  context,
                  action: '点赞帖子',
                  description: '浏览不需要登录。',
                );
              },
              child: const Text('点赞'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('点赞'));
    await tester.pumpAndSettle();
    expect(find.text('登录后点赞帖子'), findsOneWidget);
    expect(find.text('先逛逛'), findsOneWidget);

    await tester.tap(find.text('先逛逛'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });
}
