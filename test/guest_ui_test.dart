import 'package:feiba/core/local_library.dart';
import 'package:feiba/core/session.dart';
import 'package:feiba/core/theme_controller.dart';
import 'package:feiba/ui/library_page.dart';
import 'package:feiba/ui/profile_page.dart';
import 'package:feiba/ui/theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await LocalLibrary.instance.load();
    await LocalLibrary.instance.clearAll();
    await ThemeController.instance.load();
    await Session.instance.clear();
  });

  testWidgets('guest profile offers local history and favorites', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const ProfilePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('未登录'), findsOneWidget);
    expect(find.text('游客模式 · 数据保存在本机'), findsOneWidget);
    expect(find.text('登录'), findsOneWidget);
    expect(find.text('浏览历史'), findsOneWidget);
    expect(find.text('我的收藏'), findsOneWidget);
    expect(find.text('外观'), findsOneWidget);
  });

  testWidgets('library page exposes guest history, favorites and follows', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: const LibraryPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('历史 0'), findsOneWidget);
    expect(find.text('收藏 0'), findsOneWidget);
    expect(find.text('关注 0'), findsOneWidget);
    expect(find.text('还没有浏览记录'), findsOneWidget);
  });
}
