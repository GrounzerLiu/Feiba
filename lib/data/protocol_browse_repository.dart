import '../protocol/api/get_comments.dart';
import '../protocol/api/get_forum.dart';
import '../protocol/api/get_posts.dart';
import '../protocol/api/get_threads.dart';
import '../protocol/api/search_global.dart';
import '../protocol/core/account.dart';
import '../protocol/core/enums.dart';
import '../protocol/core/http_core.dart';
import '../protocol/models/comment.dart' as protocol_comment;
import '../protocol/models/contents.dart' as protocol_contents;
import '../protocol/models/forum.dart' as protocol_forum;
import '../protocol/models/search.dart';
import '../protocol/models/thread.dart' as protocol_thread;
import '../protocol/models/user.dart' as protocol_user;
import 'models/content_node.dart';
import 'models/forum_page.dart';
import 'models/forum_search.dart';
import 'models/thread_page.dart';
import 'models/tieba_user.dart';

/// Protocol-backed browsing for forum and thread pages.
///
/// Reads are anonymous by default; the protocol account is only used to keep
/// device identifiers consistent. Account-bound writes live in
/// `lib/core/tieba_api.dart`.
class ProtocolBrowseRepository {
  ProtocolBrowseRepository();

  TiebaHttpCore? _http;
  final Map<String, Future<String?>> _forumAvatarFutures =
      <String, Future<String?>>{};

  static List<dynamic> _list(dynamic value) =>
      value is List ? value : const <dynamic>[];

  TiebaHttpCore get _core => _http ??= TiebaHttpCore(account: TiebaAccount());

  Future<ForumPageData> forumPage(
    String kw, {
    int pn = 1,
    int sortType = 0,
    bool isGood = false,
  }) async {
    final sort = sortType == 1
        ? ThreadSortType.create
        : sortType == 2
        ? ThreadSortType.hot
        : ThreadSortType.reply;
    final page = await fetchThreads(
      _core,
      fname: kw,
      pn: pn,
      rn: 20,
      sort: sort,
      isGood: isGood,
    );
    var forum = page.forum;
    try {
      // FrsPage does not include the forum avatar/slogan; the bottom endpoint
      // does, and still belongs to the ported protocol layer.
      forum = await fetchForum(_core, kw);
    } catch (_) {
      // Fall back to the fields embedded in the thread page.
    }
    final users = <int, TiebaUser>{};
    final threads = <ThreadSummary>[];
    for (final thread in page.objs) {
      final user = thread.user;
      if (user != null) users[user.userId] = _mapUser(user);
      threads.add(_mapThread(thread));
    }
    return ForumPageData(
      forum: _mapForum(forum),
      threads: threads,
      users: users,
      currentPage: page.page.currentPage,
      totalPage: page.page.totalPage,
      hasMore: page.hasMore,
    );
  }

  /// Resolves a forum avatar lazily; repeated cards share one request.
  Future<String?> forumAvatar(String name) {
    final key = name.trim();
    if (key.isEmpty) return Future<String?>.value();
    return _forumAvatarFutures.putIfAbsent(key, () async {
      try {
        final forum = await fetchForum(_core, key);
        return forum.avatarUrl?.replaceFirst('http://', 'https://');
      } catch (_) {
        return null;
      }
    });
  }

  Future<List<ForumSearchResult>> searchForums(String keyword) async {
    final json = await _core.webGetJson(
      '/mo/q/search/forum',
      query: <String, String>{'word': keyword, 'pn': '1', 'rn': '20'},
    );
    final data = json['data'];
    if (data is! Map) return const <ForumSearchResult>[];
    final raw = <dynamic>[
      ..._list(data['exactMatch']),
      ..._list(data['fuzzyMatch']),
    ];
    return raw
        .whereType<Map>()
        .map((item) => ForumSearchResult.fromJson(item.cast<String, dynamic>()))
        .where((item) => item.name.isNotEmpty)
        .toList(growable: false);
  }

  Future<List<SearchGlobal>> searchGlobal(String query, {int pn = 1}) async {
    final page = await fetchSearchGlobal(_core, query: query, pn: pn, rn: 20);
    return page.objs;
  }

  Future<ThreadPageData> threadPage(int tid, {int pn = 1}) async {
    final page = await fetchPosts(
      _core,
      tid: tid,
      pn: pn,
      rn: 20,
      withComments: true,
      commentRn: 4,
    );
    final users = <int, TiebaUser>{};
    final threadUser = page.thread.user;
    if (threadUser != null) users[threadUser.userId] = _mapUser(threadUser);
    final posts = <PostItem>[];
    for (final post in page.objs) {
      final user = post.user;
      if (user != null) users[user.userId] = _mapUser(user);
      final subs = <SubPost>[];
      for (final comment in post.comments) {
        final commentUser = comment.user;
        if (commentUser != null) {
          users[commentUser.userId] = _mapUser(commentUser);
        }
        subs.add(_mapComment(comment));
      }
      posts.add(
        PostItem(
          id: post.pid,
          floor: post.floor,
          content: _contentsToNodes(post.contents),
          authorId: post.authorId,
          time: post.createTime,
          agreeNum: post.agree,
          subPostNumber: post.replyNum,
          subPosts: subs,
        ),
      );
    }
    return ThreadPageData(
      posts: posts,
      users: users,
      title: page.thread.title,
      currentPage: page.page.currentPage,
      totalPage: page.page.totalPage,
      hasMore: page.hasMore,
    );
  }

  Future<SubPostPage> subPosts({
    required int tid,
    required int pid,
    int pn = 1,
    int rn = 20,
  }) async {
    final page = await fetchComments(_core, tid: tid, pid: pid, pn: pn);
    return SubPostPage(
      posts: page.objs.map(_mapComment).toList(growable: false),
      total: page.page.totalCount > 0 ? page.page.totalCount : page.objs.length,
      hasMore: page.hasMore,
    );
  }

  ThreadSummary _mapThread(protocol_thread.TiebaThread thread) {
    return ThreadSummary(
      tid: thread.tid,
      title: thread.title,
      content: _contentsToNodes(thread.contents),
      abstract: thread.preview,
      replyNum: thread.replyNum,
      viewNum: thread.viewNum,
      agreeNum: thread.agree,
      authorId: thread.authorId,
      createTime: thread.createTime,
      lastTime: thread.lastTime,
      isTop: thread.isTop,
      isGood: thread.isGood,
    );
  }

  SubPost _mapComment(protocol_comment.TiebaComment comment) {
    final user = comment.user;
    return SubPost(
      id: comment.pid,
      content: _contentsToNodes(comment.contents),
      authorId: comment.authorId,
      time: comment.createTime,
      authorName: user?.displayName,
      authorPortrait: user?.portrait,
    );
  }

  TiebaUser _mapUser(protocol_user.TiebaUser user) {
    return TiebaUser(
      id: user.userId,
      name: user.userName,
      nameShow: user.nickNameNew,
      portrait: user.portrait,
      levelId: user.level,
    );
  }

  TiebaForum _mapForum(protocol_forum.TiebaForum forum) {
    return TiebaForum(
      id: forum.fid,
      name: forum.fname,
      memberNum: forum.memberNum,
      postNum: forum.postNum,
      slogan: forum.slogan,
      avatar: forum.avatarUrl?.replaceFirst('http://', 'https://'),
    );
  }

  List<ContentNode> _contentsToNodes(protocol_contents.Contents contents) {
    final nodes = <ContentNode>[];
    for (final fragment in contents.objs) {
      if (fragment is protocol_contents.FragText) {
        nodes.add(ContentNode(type: 0, text: fragment.text));
      } else if (fragment is protocol_contents.FragEmoji) {
        final id = fragment.id;
        if (id.startsWith('image_')) {
          nodes.add(ContentNode(type: 2, text: id));
        } else if (id.isNotEmpty) {
          // Newer responses carry Unicode emoji instead of the legacy
          // image_emoticon id; render those as text.
          nodes.add(ContentNode(type: 0, text: id));
        }
      } else if (fragment is protocol_contents.FragImage) {
        if (fragment.imageUrl.isEmpty) continue;
        nodes.add(
          ContentNode(
            type: 3,
            cdnSrc: fragment.src.isEmpty ? null : fragment.src,
            bigCdnSrc: fragment.imageUrl,
            width: fragment.showWidth,
            height: fragment.showHeight,
            bsize: fragment.showWidth > 0 && fragment.showHeight > 0
                ? '${fragment.showWidth},${fragment.showHeight}'
                : null,
          ),
        );
      } else if (fragment is protocol_contents.FragLink) {
        nodes.add(
          ContentNode(
            type: 1,
            text: fragment.title.isNotEmpty ? fragment.title : fragment.text,
            link: fragment.uri.toString(),
          ),
        );
      } else if (fragment is protocol_contents.FragAt) {
        nodes.add(ContentNode(type: 0, text: fragment.text));
      } else if (fragment is protocol_contents.FragVideo) {
        nodes.add(const ContentNode(type: 0, text: '[视频]'));
      } else if (fragment is protocol_contents.FragVoice) {
        nodes.add(const ContentNode(type: 0, text: '[语音]'));
      } else if (fragment is protocol_contents.FragTiebaPlus) {
        nodes.add(ContentNode(type: 18, text: fragment.text));
      }
    }
    return nodes;
  }
}
