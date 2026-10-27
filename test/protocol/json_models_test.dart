import 'package:feiba/protocol/tieba_protocol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JSON models', () {
    test('forum parses managers and counters', () {
      final forum = TiebaForum.fromJson(<String, dynamic>{
        'id': 3193775,
        'name': '原神',
        'first_class': '游戏',
        'second_class': '手游',
        'avatar': 'https://example.com/a.png',
        'slogan': 'slogan',
        'member_num': 1,
        'post_num': 2,
        'thread_num': 3,
        'managers': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 7,
            'name': 'admin',
            'show_name': 'Admin',
            'portrait': 'tb.1.abc?t=1',
          },
        ],
      });
      expect(forum.fid, 3193775);
      expect(forum.fname, '原神');
      expect(forum.admins.single.displayName, 'Admin');
      expect(forum.admins.single.portrait, 'tb.1.abc');
      expect(forum.hasBawu, isTrue);
    });

    test('search result parses page and content type', () {
      final result = TiebaSearchInForums.fromJson(<String, dynamic>{
        'page': <String, dynamic>{
          'page_size': 20,
          'current_page': 1,
          'total_page': 2,
          'total_count': 25,
          'has_more': 1,
          'has_prev': 0,
        },
        'post_list': <Map<String, dynamic>>[
          <String, dynamic>{
            'content': 'hello',
            'title': 'title',
            'fname': 'bar',
            'tid': '123',
            'pid': '456',
            'cid': '789',
            'is_floor': '1',
            'time': '1700000000',
            'author': <String, dynamic>{'name_show': 'Nick'},
          },
        ],
      });
      expect(result.hasMore, isTrue);
      expect(result.objs.single.tid, 123);
      expect(result.objs.single.pid, 789);
      expect(result.objs.single.contentType, ContentType.comment);
      expect(result.objs.single.showName, 'Nick');
    });

    test('follow page parses counters', () {
      final follows = TiebaFollows.fromJson(<String, dynamic>{
        'pn': 2,
        'total_follow_num': 100,
        'has_more': 1,
        'follow_list': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 5,
            'name': 'user',
            'name_show': 'Nick',
            'portrait': 'tb.1.abc?t=1',
          },
        ],
      });
      expect(follows.objs.single.userId, 5);
      expect(follows.page.currentPage, 2);
      expect(follows.page.hasPrev, isTrue);
      expect(follows.hasMore, isTrue);
      expect(follows.page.totalCount, 100);
    });

    test('user JSON map parses nickname and portrait', () {
      final user = TiebaUser.fromJsonMap(<String, dynamic>{
        'id': 7,
        'name': 'user',
        'name_show': 'Nick',
        'portrait': 'tb.1.abc?t=1',
        'level_id': 12,
        'priv_sets': <String, dynamic>{'like': 1, 'reply': 1},
      });
      expect(user.userId, 7);
      expect(user.displayName, 'Nick');
      expect(user.portrait, 'tb.1.abc');
      expect(user.level, 12);
    });
  });

  group('write validation', () {
    test('agree rejects missing credentials before networking', () async {
      final http = TiebaHttpCore(account: TiebaAccount());
      await expectLater(
        setAgree(http, tid: 1),
        throwsA(isA<TiebaValueException>()),
      );
    });

    test('signForum rejects missing credentials before networking', () async {
      final http = TiebaHttpCore(account: TiebaAccount());
      await expectLater(
        signForum(http, '原神'),
        throwsA(isA<TiebaValueException>()),
      );
    });

    test('account validates credential lengths', () {
      expect(() => TiebaAccount(bduss: 'short'), throwsArgumentError);
      expect(() => TiebaAccount(stoken: 'short'), throwsArgumentError);
      expect(TiebaAccount().isLoggedIn, isFalse);
    });
  });
}
