import 'package:feiba/core/session.dart';
import 'package:feiba/core/tieba_api.dart';
import 'package:feiba/ui/login_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    TiebaApi.instance.reset();
    await Session.instance.clear();
  });

  testWidgets('login validates BDUSS through the protocol bridge', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.enterText(find.byType(TextField).first, 'short');
    await tester.tap(find.widgetWithText(FilledButton, '登录'));
    await tester.pumpAndSettle();

    expect(find.textContaining('BDUSS 长度异常'), findsOneWidget);
  });
}