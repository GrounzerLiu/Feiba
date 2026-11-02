import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:feiba/core/followed_forum_cache.dart';
import 'package:feiba/data/models/forum_summary.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('followed forum cache round-trips account forums', () async {
    await FollowedForumCache.save(
      forums: const <ForumSummary>[
        ForumSummary(
          fid: 1,
          name: '原神',
          memberNum: 100,
          threadNum: 20,
          isFollowed: true,
          level: 7,
        ),
      ],
      account: 'tester',
    );

    final loaded = await FollowedForumCache.load(account: 'tester');
    expect(loaded, hasLength(1));
    expect(loaded.single.name, '原神');
    expect(loaded.single.level, 7);
  });

  test('followed forum cache ignores another account', () async {
    await FollowedForumCache.save(
      forums: const <ForumSummary>[ForumSummary(fid: 1, name: '原神')],
      account: 'first',
    );

    final loaded = await FollowedForumCache.load(account: 'second');
    expect(loaded, isEmpty);
  });
}
