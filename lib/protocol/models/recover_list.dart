import '../core/enums.dart';
import '../core/utils.dart';
import 'bawu_parse.dart';
import 'page.dart';

/// The author of a post that is waiting to be restored.
class RecoverUserInfo {
  const RecoverUserInfo({
    required this.userName,
    required this.portrait,
    required this.nickNameNew,
  });

  final String userName;
  final String portrait;
  final String nickNameNew;

  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get displayName =>
      userName.isNotEmpty ? userName : '$nickNameNew/$portrait';

  factory RecoverUserInfo.fromJson(Map<String, dynamic> json) {
    return RecoverUserInfo(
      userName: parseString(json['user_name']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      nickNameNew: parseString(json['user_nickname']),
    );
  }
}

/// The parent post of a comment that is waiting to be restored.
class RecoverPostRef {
  const RecoverPostRef({
    required this.pid,
    required this.text,
    required this.user,
  });

  final int pid;
  final String text;
  final RecoverUserInfo user;

  bool get isNotEmpty => pid != 0;

  factory RecoverPostRef.fromJson(Map<String, dynamic> json) {
    return RecoverPostRef(
      pid: parseInt(json['pid']),
      text: parseString(json['abstract']),
      user: RecoverUserInfo.fromJson(json),
    );
  }
}

/// The thread a post waiting to be restored belongs to.
class RecoverThreadRef {
  const RecoverThreadRef({
    required this.tid,
    required this.title,
    required this.text,
    required this.user,
  });

  final int tid;
  final String title;
  final String text;
  final RecoverUserInfo user;

  bool get isNotEmpty => tid != 0;

  factory RecoverThreadRef.fromJson(Map<String, dynamic> json) {
    return RecoverThreadRef(
      tid: parseInt(json['tid']),
      title: parseString(json['title']),
      text: parseString(json['abstract']),
      user: RecoverUserInfo.fromJson(json),
    );
  }
}

/// A post waiting to be restored.
class TiebaRecover {
  const TiebaRecover({
    required this.text,
    required this.tid,
    required this.pid,
    required this.user,
    required this.post,
    required this.thread,
    required this.opShowName,
    required this.opTime,
    required this.contentType,
    required this.isHide,
  });

  final String text;

  /// Thread the deleted object belongs to.
  final int tid;

  /// Deleted post id; 0 when [contentType] is [ContentType.thread].
  final int pid;

  /// Author of the deleted object.
  final RecoverUserInfo user;

  /// Parent post; only filled when [contentType] is [ContentType.comment].
  final RecoverPostRef post;

  /// Thread the deleted object belongs to; the deleted object itself when
  /// [contentType] is [ContentType.thread].
  final RecoverThreadRef thread;

  final String opShowName;

  /// Ten-digit UNIX timestamp in seconds.
  final int opTime;

  final ContentType contentType;

  /// Whether the object was hidden instead of deleted.
  final bool isHide;

  factory TiebaRecover.fromJson(Map<String, dynamic> json) {
    final threadInfo = bawuMap(json['thread_info']);
    final postInfo = bawuMap(json['post_info']);
    final subPostInfo = bawuMap(json['sub_post_info']);
    final thread = RecoverThreadRef.fromJson(threadInfo);

    late final ContentType contentType;
    late final RecoverPostRef post;
    late final String text;
    late final int pid;
    late final RecoverUserInfo user;

    if (subPostInfo.isNotEmpty) {
      contentType = ContentType.comment;
      post = RecoverPostRef.fromJson(postInfo);
      text = parseString(subPostInfo['abstract']);
      pid = parseInt(subPostInfo['pid']);
      user = RecoverUserInfo.fromJson(subPostInfo);
    } else if (postInfo.isNotEmpty) {
      contentType = ContentType.post;
      post = const RecoverPostRef(
        pid: 0,
        text: '',
        user: RecoverUserInfo(userName: '', portrait: '', nickNameNew: ''),
      );
      text = parseString(postInfo['abstract']);
      pid = parseInt(postInfo['pid']);
      user = RecoverUserInfo.fromJson(postInfo);
    } else {
      contentType = ContentType.thread;
      post = const RecoverPostRef(
        pid: 0,
        text: '',
        user: RecoverUserInfo(userName: '', portrait: '', nickNameNew: ''),
      );
      text = thread.text;
      pid = 0;
      user = thread.user;
    }

    final opInfo = bawuMap(json['op_info']);
    return TiebaRecover(
      text: text,
      tid: thread.tid,
      pid: pid,
      user: user,
      post: post,
      thread: thread,
      opShowName: parseString(opInfo['name']),
      opTime: parseInt(opInfo['time']),
      contentType: contentType,
      isHide: bawuFlag(json['is_frs_mask']),
    );
  }
}

/// One page of posts waiting to be restored.
class TiebaRecovers {
  const TiebaRecovers({required this.objs, required this.page});

  final List<TiebaRecover> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory TiebaRecovers.fromJson(Map<String, dynamic> json) {
    final data = bawuMap(json['data']);
    final page = bawuMap(data['page']);
    final currentPage = parseInt(page['pn']);
    return TiebaRecovers(
      objs: <TiebaRecover>[
        for (final item in bawuList(data['thread_list']))
          TiebaRecover.fromJson(bawuMap(item)),
      ],
      page: TiebaPage(
        pageSize: parseInt(page['rn']),
        currentPage: currentPage,
        totalPage: 0,
        totalCount: 0,
        hasMore: bawuFlag(page['has_more']),
        hasPrev: currentPage > 1,
      ),
    );
  }
}
