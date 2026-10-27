import 'package:feiba/protocol/models/follow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fans response uses nested user_list and page', () {
    final fans = TiebaFans.fromJson(<String, dynamic>{
      'error_code': '0',
      'data': <String, dynamic>{
        'user_list': <dynamic>[
          <String, dynamic>{
            'id': 1,
            'portrait': 'tb.1.a',
            'name': 'alice',
            'name_show': 'Alice',
          },
        ],
        'page': <String, dynamic>{
          'current_page': 1,
          'total_count': 42,
          'has_more': 1,
          'has_prev': 0,
        },
      },
    });
    expect(fans.objs, hasLength(1));
    expect(fans.objs.first.userName, 'alice');
    expect(fans.page.currentPage, 1);
    expect(fans.page.totalCount, 42);
    expect(fans.hasMore, isTrue);
  });
}
