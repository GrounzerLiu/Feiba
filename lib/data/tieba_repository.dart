import '../core/tieba_client.dart';
import 'models/forum_page.dart';
import 'models/thread_page.dart';
import 'models/tieba_user.dart';

/// Read-only data access for forums and threads.
class TiebaRepository {
  TiebaRepository({TiebaClient? client}) : client = client ?? TiebaClient();

  final TiebaClient client;

  static int _int(dynamic v, [int fallback = 0]) =>
      v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? fallback;

  static List<dynamic> _list(dynamic v) => v is List ? v : const <dynamic>[];

  /// Thread list of a forum.
  Future<ForumPageData> forumPage(String kw, {int pn = 1}) async {
    final json = await client.post('/c/f/frs/page', {
      'kw': kw,
      'pn': '$pn',
      'rn': '20',
      'sort_type': '0',
      'q_type': '2',
      'st_type': 'tb_forumlist',
      'with_group': '0',
    });

    final forumJson = json['forum'];
    final page = json['page'];
    final threadsJson = _list(json['thread_list'] ?? json['threadList']);

    return ForumPageData(
      forum: forumJson is Map
          ? TiebaForum.fromJson(forumJson.cast<String, dynamic>())
          : null,
      threads: threadsJson
          .whereType<Map>()
          .map((e) => ThreadSummary.fromJson(e.cast<String, dynamic>()))
          .toList(growable: false),
      users: TiebaUser.parseUserList(json['user_list']),
      currentPage: page is Map ? _int(page['current_page'], pn) : pn,
      totalPage: page is Map ? _int(page['total_page'], 1) : 1,
      hasMore: page is Map ? _int(page['has_more']) != 0 : false,
    );
  }

  /// Posts of a thread.
  Future<ThreadPageData> threadPage(int tid, {int pn = 1}) async {
    final json = await client.post('/c/f/pb/page', {
      'kz': '$tid',
      'pn': '$pn',
      'rn': '20',
      'with_floor': '1',
      'st_type': 'tb_frslist',
      'back': '0',
      'floor_rn': '3',
      'mark': '0',
    });

    final page = json['page'];
    final postsJson = _list(json['post_list'] ?? json['postList']);
    final posts = postsJson
        .whereType<Map>()
        .map((e) => PostItem.fromJson(e.cast<String, dynamic>()))
        .toList(growable: false);

    String title = '';
    if (postsJson.isNotEmpty && postsJson.first is Map) {
      title = (postsJson.first as Map)['title']?.toString() ?? '';
    }

    return ThreadPageData(
      posts: posts,
      users: TiebaUser.parseUserList(json['user_list']),
      title: title,
      currentPage: page is Map ? _int(page['current_page'], pn) : pn,
      totalPage: page is Map ? _int(page['total_page'], 1) : 1,
      hasMore: page is Map ? _int(page['has_more']) != 0 : false,
    );
  }
}
