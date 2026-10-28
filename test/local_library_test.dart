import 'package:feiba/core/local_library.dart';
import 'package:feiba/core/theme_controller.dart';
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
  });

  test('local library keeps history and favorites without login', () async {
    final library = LocalLibrary.instance;
    expect(library.historyCount, 0);
    expect(library.isFavorite(42), isFalse);

    await library.recordThread(
      tid: 42,
      title: '游客也能收藏的帖子',
      forumName: '原神吧',
      authorName: '旅行者',
    );
    expect(library.historyCount, 1);
    expect(library.history.first.title, '游客也能收藏的帖子');
    expect(library.recentForums, <String>['原神吧']);

    final added = await library.toggleFavorite(
      tid: 42,
      title: '游客也能收藏的帖子',
      forumName: '原神吧',
    );
    expect(added, isTrue);
    expect(library.isFavorite(42), isTrue);
    expect(library.favoriteCount, 1);

    await library.toggleForumFollow('原神');
    expect(library.isForumFollowed('原神'), isTrue);
    expect(library.followedForums, contains('原神'));

    await library.recordSearch('原神');
    await library.recordSearch('摄影');
    expect(library.recentSearches, <String>['摄影', '原神']);

    await library.recordThread(tid: 42, title: '更新后的标题', forumName: '原神吧');
    expect(library.historyCount, 1);
    expect(library.history.first.title, '更新后的标题');

    await library.clearAll();
    expect(library.historyCount, 0);
    expect(library.favoriteCount, 0);
    expect(library.followedForums, isEmpty);
    expect(library.recentSearches, isEmpty);
  });

  test('forum visits are ordered by click time', () async {
    final library = LocalLibrary.instance;
    await library.recordForumVisit('甲吧');
    await Future<void>.delayed(const Duration(milliseconds: 2));
    await library.recordForumVisit('乙吧');
    expect(library.recentForums.take(2), <String>['乙吧', '甲吧']);
    expect(library.forumVisitedAt('乙吧'), isNotNull);
  });

  test('theme controller persists and reloads the selected mode', () async {
    expect(ThemeController.instance.mode, ThemeMode.system);
    await ThemeController.instance.setMode(ThemeMode.dark);
    expect(ThemeController.instance.mode, ThemeMode.dark);
    expect(ThemeController.instance.label, '深色');

    await ThemeController.instance.load();
    expect(ThemeController.instance.mode, ThemeMode.dark);
  });
}