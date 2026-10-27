import '../generated/generated.dart' as pb;
import 'comment.dart';
import 'contents.dart';
import 'forum.dart';
import 'page.dart';
import 'thread.dart';
import 'user.dart';

/// A floor (reply) inside a thread.
class TiebaPost {
  TiebaPost({
    required this.contents,
    required this.sign,
    required this.comments,
    required this.isAiMeme,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.user,
    required this.authorId,
    required this.floor,
    required this.replyNum,
    required this.agree,
    required this.disagree,
    required this.createTime,
    required this.isThreadAuthor,
  });

  final Contents contents;
  final String sign;
  final List<TiebaComment> comments;
  final bool isAiMeme;

  int fid;
  String fname;
  int tid;
  final int pid;
  TiebaUser? user;
  final int authorId;

  final int floor;
  final int replyNum;
  final int agree;
  final int disagree;
  final int createTime;
  bool isThreadAuthor;

  String get text => sign.isEmpty ? contents.text : '${contents.text}\n$sign';

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory TiebaPost.fromProto(pb.Post proto) {
    final sign = StringBuffer();
    for (final part in proto.signature.content) {
      if (part.type == 0) sign.write(part.text);
    }
    return TiebaPost(
      contents: Contents.fromPost(proto),
      sign: sign.toString(),
      comments: <TiebaComment>[
        for (final sub in proto.subPostList.subPostList)
          TiebaComment.fromProto(sub),
      ],
      isAiMeme: proto.spriteMemeInfo.memeId.toInt() != 0,
      fid: 0,
      fname: '',
      tid: 0,
      pid: proto.id.toInt(),
      user: TiebaUser.fromProtoOrNull(proto.author),
      authorId: proto.authorId.toInt(),
      floor: proto.floor,
      replyNum: proto.subPostNumber,
      agree: proto.agree.agreeNum.toInt(),
      disagree: proto.agree.disagreeNum.toInt(),
      createTime: proto.time,
      isThreadAuthor: false,
    );
  }
}

/// One page of replies.
class TiebaPosts {
  const TiebaPosts({
    required this.objs,
    required this.page,
    required this.forum,
    required this.thread,
  });

  final List<TiebaPost> objs;
  final TiebaPage page;
  final TiebaForum forum;
  final TiebaThread thread;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory TiebaPosts.fromProto(pb.PbPageResIdl_DataRes data) {
    final page = TiebaPage.fromProto(data.page);
    final forum = TiebaForum.fromSimpleProto(data.forum);
    final origin = data.thread.originThreadInfo;
    final isShare = data.thread.isShareThread != 0 && origin.pid.toInt() != 0;
    final thread =
        TiebaThread.fromProto(
            data.thread,
            contentsOverride: isShare
                ? Contents.empty()
                : Contents.fromThreadOrigin(origin),
            voteInfoOverride: isShare
                ? null
                : VoteInfo.fromProto(origin.pollInfo),
            shareOriginOverride: isShare ? ShareThread.fromProto(origin) : null,
          )
          ..fid = forum.fid
          ..fname = forum.fname;
    final users = <int, TiebaUser>{
      for (final user in data.userList)
        user.id.toInt(): TiebaUser.fromProto(user),
    };

    final posts = <TiebaPost>[];
    for (final proto in data.postList) {
      if (proto.chatContent.botUk.isNotEmpty) continue;
      final post = TiebaPost.fromProto(proto)
        ..fid = forum.fid
        ..fname = forum.fname
        ..tid = thread.tid;
      final user = users[post.authorId];
      if (user != null) post.user = user;
      post.isThreadAuthor = thread.authorId == post.authorId;
      for (final comment in post.comments) {
        comment
          ..fid = post.fid
          ..fname = post.fname
          ..tid = post.tid
          ..ppid = post.pid
          ..floor = post.floor;
        final commentUser = users[comment.authorId];
        if (commentUser != null) comment.user = commentUser;
        comment.isThreadAuthor = thread.authorId == comment.authorId;
      }
      posts.add(post);
    }

    return TiebaPosts(objs: posts, page: page, forum: forum, thread: thread);
  }
}
