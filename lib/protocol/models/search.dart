import '../core/enums.dart';
import '../core/utils.dart';
import 'page.dart';

/// One result of an in-forum search.
class SearchInForum {
  const SearchInForum({
    required this.text,
    required this.title,
    required this.fname,
    required this.tid,
    required this.ppid,
    required this.pid,
    required this.showName,
    required this.contentType,
    required this.createTime,
  });

  final String text;
  final String title;
  final String fname;
  final int tid;
  final int ppid;
  final int pid;
  final String showName;
  final ContentType contentType;
  final int createTime;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory SearchInForum.fromJson(Map<String, dynamic> json) {
    final isComment = parseInt(json['is_floor']) != 0;
    final author = json['author'];
    final authorMap = author is Map
        ? author.cast<String, dynamic>()
        : <String, dynamic>{};
    return SearchInForum(
      text: parseString(json['content']),
      title: parseString(json['title']),
      fname: parseString(json['fname']),
      tid: parseInt(json['tid']),
      ppid: parseInt(json['pid']),
      pid: isComment ? parseInt(json['cid']) : parseInt(json['pid']),
      showName: parseString(authorMap['name_show']),
      contentType: isComment ? ContentType.comment : ContentType.post,
      createTime: parseInt(json['time']),
    );
  }
}

/// One page of in-forum search results.
class TiebaSearchInForums {
  const TiebaSearchInForums({required this.objs, required this.page});

  final List<SearchInForum> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;

  factory TiebaSearchInForums.fromJson(Map<String, dynamic> json) {
    final pageMap = json['page'];
    final page = pageMap is Map
        ? TiebaPage.fromJson(pageMap.cast<String, dynamic>())
        : TiebaPage.empty();
    final list = json['post_list'];
    return TiebaSearchInForums(
      objs: list is List
          ? <SearchInForum>[
              for (final item in list.whereType<Map>())
                SearchInForum.fromJson(item.cast<String, dynamic>()),
            ]
          : const <SearchInForum>[],
      page: page,
    );
  }
}

/// One result of a global (all-forum) search.
class SearchGlobal {
  const SearchGlobal({
    required this.tid,
    required this.pid,
    required this.title,
    required this.content,
    required this.createTime,
    required this.forumId,
    required this.forumName,
    required this.postNum,
    required this.pbUrl,
    required this.authorId,
    required this.authorName,
    required this.authorShowName,
  });

  final int tid;
  final int pid;
  final String title;
  final String content;
  final int createTime;
  final int forumId;
  final String forumName;
  final int postNum;
  final String pbUrl;
  final int authorId;
  final String authorName;
  final String authorShowName;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory SearchGlobal.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final userMap = user is Map
        ? user.cast<String, dynamic>()
        : <String, dynamic>{};
    final authorName = parseString(userMap['user_name']);
    return SearchGlobal(
      tid: parseInt(json['tid']),
      pid: parseInt(json['pid']),
      title: parseString(json['title']),
      content: parseString(json['content']),
      createTime: parseInt(json['create_time']),
      forumId: parseInt(json['forum_id']),
      forumName: parseString(json['forum_name']),
      postNum: tbnum2int(json['post_num'], 'W'),
      pbUrl: parseString(json['pb_url']),
      authorId: parseInt(userMap['user_id']),
      authorName: authorName,
      authorShowName: parseString(userMap['show_nickname']).isEmpty
          ? authorName
          : parseString(userMap['show_nickname']),
    );
  }
}

/// One page of global search results.
class TiebaSearchGlobals {
  const TiebaSearchGlobals({
    required this.objs,
    required this.hasMore,
    required this.currentPage,
  });

  final List<SearchGlobal> objs;
  final bool hasMore;
  final int currentPage;

  factory TiebaSearchGlobals.fromJson(Map<String, dynamic> data) {
    final list = data['post_list'];
    return TiebaSearchGlobals(
      objs: list is List
          ? <SearchGlobal>[
              for (final item in list.whereType<Map>())
                SearchGlobal.fromJson(item.cast<String, dynamic>()),
            ]
          : const <SearchGlobal>[],
      hasMore: data['has_more'] == true || parseInt(data['has_more']) != 0,
      currentPage: parseInt(data['current_page']),
    );
  }
}
