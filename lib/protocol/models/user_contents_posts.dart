import '../core/enums.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import 'contents.dart';

/// Author stub embedded in user content responses.
///
/// Mirrors aiotieba's `UserInfo_u`.
class UserInfoU {
  const UserInfoU({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
  });

  const UserInfoU.empty()
    : userId = 0,
      portrait = '',
      userName = '',
      nickNameNew = '';

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;

  bool get isValid => userId != 0;

  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get logName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return '$nickNameNew/$portrait';
    return '$userId';
  }

  /// Reads the user fields flattened onto the first post-list item.
  factory UserInfoU.fromProto(pb.PostInfoList proto) {
    return UserInfoU(
      userId: proto.userId.toInt(),
      portrait: normalizePortrait(proto.userPortrait),
      userName: proto.userName,
      nickNameNew: proto.nameShow,
    );
  }

  @override
  String toString() {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return portrait;
    return '$userId';
  }
}

/// Parent thread info of a user reply.
///
/// Mirrors aiotieba's `Thread_up`.
class ThreadUp {
  const ThreadUp({
    required this.fid,
    required this.tid,
    required this.title,
    required this.type,
    required this.viewNum,
    required this.replyNum,
    required this.createTime,
  });

  const ThreadUp.empty()
    : fid = 0,
      tid = 0,
      title = '',
      type = ThreadType.unknown,
      viewNum = 0,
      replyNum = 0,
      createTime = 0;

  final int fid;
  final int tid;
  final String title;

  final ThreadType type;
  final int viewNum;
  final int replyNum;
  final int createTime;

  bool get isValid => tid != 0;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory ThreadUp.fromProto(pb.PostInfoList proto) {
    return ThreadUp(
      fid: proto.forumId.toInt(),
      tid: proto.threadId.toInt(),
      // The server prefixes reply titles with '回复：'; titles do not have it.
      title: _stripReplyPrefix(proto.title),
      type: ThreadType.fromValue(proto.threadType.toInt()),
      viewNum: proto.freqNum,
      replyNum: proto.replyNum,
      createTime: proto.createTime,
    );
  }

  static String _stripReplyPrefix(String title) =>
      title.startsWith('回复：') ? title.substring(3) : title;

  @override
  bool operator ==(Object other) => other is ThreadUp && other.tid == tid;

  @override
  int get hashCode => tid.hashCode;
}

/// One reply published by a user.
///
/// Mirrors aiotieba's `UserPost`.
class UserPost {
  UserPost({
    required this.contents,
    required this.fid,
    required this.tid,
    required this.pid,
    required this.user,
    required this.thread,
    required this.contentType,
    required this.createTime,
  });

  final Contents contents;

  int fid;
  int tid;
  final int pid;

  /// Author of the reply; filled in from the enclosing [UserPosts].
  UserInfoU user;

  /// Parent thread; filled in from the enclosing [UserPosts].
  ThreadUp thread;

  final ContentType contentType;
  final int createTime;

  String get text => contents.text;

  int get authorId => user.userId;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory UserPost.fromProto(pb.PostInfoList_PostInfoContent proto) {
    return UserPost(
      contents: _buildContents(proto.postContent),
      fid: 0,
      tid: 0,
      pid: proto.postId.toInt(),
      user: const UserInfoU.empty(),
      thread: const ThreadUp.empty(),
      contentType: _contentType(proto.postType.toInt()),
      createTime: proto.createTime.toInt(),
    );
  }

  static ContentType _contentType(int postType) {
    // 0 -> reply, 1 ->楼中楼 comment.
    if (postType == 0) return ContentType.post;
    if (postType == 1) return ContentType.comment;
    return ContentType.unknown;
  }

  @override
  bool operator ==(Object other) => other is UserPost && other.pid == pid;

  @override
  int get hashCode => pid.hashCode;
}

/// Replies grouped by their parent thread.
///
/// Mirrors aiotieba's `UserPosts`.
class UserPosts {
  const UserPosts({
    required this.objs,
    required this.fid,
    required this.tid,
    required this.thread,
  });

  final List<UserPost> objs;
  final int fid;
  final int tid;
  final ThreadUp thread;

  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  factory UserPosts.fromProto(pb.PostInfoList proto) {
    final fid = proto.forumId.toInt();
    final tid = proto.threadId.toInt();
    final thread = ThreadUp.fromProto(proto);
    final objs = <UserPost>[];
    for (final item in proto.content) {
      objs.add(
        UserPost.fromProto(item)
          ..fid = fid
          ..tid = tid
          ..thread = thread,
      );
    }
    return UserPosts(objs: objs, fid: fid, tid: tid, thread: thread);
  }
}

/// All replies of one page of a user's history.
///
/// Mirrors aiotieba's `UserPostss`.
class UserPostss {
  const UserPostss({required this.objs});

  final List<UserPosts> objs;

  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  /// Flattens the per-thread groups into a single reply list.
  List<UserPost> get flat => <UserPost>[
    for (final posts in objs) ...posts.objs,
  ];

  factory UserPostss.fromProto(pb.UserPostResIdl_DataRes data) {
    final objs = <UserPosts>[
      for (final proto in data.postList) UserPosts.fromProto(proto),
    ];
    if (objs.isNotEmpty) {
      // Every item belongs to the requested user, so one author stub is
      // shared by all replies, matching aiotieba.
      final user = UserInfoU.fromProto(data.postList.first);
      for (final posts in objs) {
        for (final post in posts.objs) {
          post.user = user;
        }
      }
    }
    return UserPostss(objs: objs);
  }
}

/// Builds rich contents from the flattened reply fragment list.
///
/// Fragment kinds are the subset aiotieba's `Contents_up` understands;
/// unknown fragments carry no renderable payload and are skipped.
Contents _buildContents(
  Iterable<pb.PostInfoList_PostInfoContent_Abstract> content,
) {
  final objs = <ContentFragment>[];
  final texts = <ContentFragment>[];
  final imgs = <FragImage>[];
  final ats = <FragAt>[];
  final links = <FragLink>[];
  FragVoice? voice;

  for (final proto in content) {
    final type = proto.type;
    if (proto.src.isNotEmpty) {
      // Thumbnail responses mark images with a src instead of a type.
      final fragment = FragImage(
        src: proto.src,
        bigSrc: '',
        originSrc: '',
        originSize: 0,
        showWidth: 0,
        showHeight: 0,
        hash: _imageHash(proto.src),
      );
      imgs.add(fragment);
      objs.add(fragment);
    } else if (type == 0 ||
        type == 9 ||
        type == 18 ||
        type == 27 ||
        type == 40) {
      final fragment = FragText(proto.text);
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 1) {
      final fragment = FragLink(
        text: proto.link,
        title: proto.text,
        rawUri: Uri.tryParse(proto.link) ?? Uri(),
      );
      links.add(fragment);
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 4) {
      // The reply endpoint only carries the mentioned user name.
      final fragment = FragAt(proto.text, 0, '');
      ats.add(fragment);
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 10) {
      // Voice duration is serialized as seconds * 1000 in a string field.
      final fragment = FragVoice(
        proto.voiceMd5,
        parseInt(proto.duringTime) / 1000,
      );
      voice = fragment;
      objs.add(fragment);
    }
  }

  return Contents(
    objs: objs,
    texts: texts,
    emojis: const <FragEmoji>[],
    imgs: imgs,
    ats: ats,
    links: links,
    tiebaPluses: const <FragTiebaPlus>[],
    voice: voice,
  );
}

final RegExp _imageHashPattern = RegExp(r'/([a-z0-9]{32,})\.');

String _imageHash(String src) {
  final match = _imageHashPattern.firstMatch(src);
  return match == null ? '' : (match.group(1) ?? '');
}
