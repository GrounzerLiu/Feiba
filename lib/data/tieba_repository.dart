import '../core/tieba_client.dart';
import 'models/forum_page.dart';
import 'models/forum_search.dart';
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
  Future<ForumPageData> forumPage(
    String kw, {
    int pn = 1,
    int sortType = 0,
    bool isGood = false,
  }) async {
    final json = await client.post('/c/f/frs/page', {
      'kw': kw,
      'pn': '$pn',
      'rn': '20',
      'sort_type': '$sortType',
      'is_good': isGood ? '1' : '0',
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

  /// Searches forums by keyword via the mobile web endpoint.
  Future<List<ForumSearchResult>> searchForums(String keyword) async {
    final json = await client.webGetJson('/mo/q/search/forum', {
      'word': keyword,
      'pn': '1',
      'rn': '20',
    });
    final data = json['data'];
    if (data is! Map) return const <ForumSearchResult>[];
    final raw = <dynamic>[
      ..._list(data['exactMatch']),
      ..._list(data['fuzzyMatch']),
    ];
    return raw
        .whereType<Map>()
        .map((e) => ForumSearchResult.fromJson(e.cast<String, dynamic>()))
        .where((e) => e.name.isNotEmpty)
        .toList(growable: false);
  }

  /// Loads one page of sub posts (楼中楼) for a floor.
  Future<SubPostPage> subPosts({
    required int tid,
    required int pid,
    int pn = 1,
    int rn = 20,
  }) async {
    final json = await client.post('/c/f/pb/floor', <String, String>{
      'kz': '$tid',
      'pid': '$pid',
      'pn': '$pn',
      'rn': '$rn',
      'scr_dip': '2.75',
      'scr_h': '2400',
      'scr_w': '1080',
    });
    final list = _list(json['subpost_list'])
        .whereType<Map>()
        .map((e) => SubPost.fromJson(e.cast<String, dynamic>()))
        .toList(growable: false);
    final page = json['page'];
    final total = _int(json['subpost_num']);
    // `subpost_num` is the server's idea of the floor size and can exceed the
    // number of actually returned items (deleted replies are counted), so a
    // full page is the only reliable signal that more data exists.
    final hasMore =
        list.length >= rn || (page is Map && _int(page['has_more']) != 0);
    return SubPostPage(posts: list, total: total, hasMore: hasMore);
  }

  /// Raw sub-post (floor) response, used by the thread page to load replies.
  Future<Map<String, dynamic>> rawFloor({
    required int kz,
    required int pid,
    int pn = 1,
    int rn = 20,
  }) {
    return client.post('/c/f/pb/floor', <String, String>{
      'kz': '$kz',
      'pid': '$pid',
      'pn': '$pn',
      'rn': '$rn',
      'scr_dip': '2.75',
      'scr_h': '2400',
      'scr_w': '1080',
    });
  }

  /// Validates a BDUSS and returns the bound account, or null when invalid.
  Future<TiebaAccount?> checkAccount(String bduss) =>
      client.fetchAccount(bduss);

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
