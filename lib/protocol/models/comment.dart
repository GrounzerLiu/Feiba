import '../generated/generated.dart' as pb;
import 'contents.dart';
import 'forum.dart';
import 'page.dart';
import 'post.dart';
import 'thread.dart';
import 'user.dart';

/// A sub-post (comment) inside a floor.
class TiebaComment {
  TiebaComment({
    required this.contents,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.ppid,
    required this.pid,
    required this.user,
    required this.authorId,
    required this.replyToId,
    required this.floor,
    required this.agree,
    required this.disagree,
    required this.createTime,
    required this.isThreadAuthor,
  });

  final Contents contents;

  int fid;
  String fname;
  int tid;
  int ppid;
  final int pid;
  TiebaUser? user;
  final int authorId;
  final int replyToId;
  int floor;
  final int agree;
  final int disagree;
  final int createTime;
  bool isThreadAuthor;

  String get text => contents.text;

  String get displayText => contents.displayText;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory TiebaComment.fromProto(pb.SubPostList proto) {
    final contents = Contents.fromComment(proto);
    final replyToId = contents.stripReplyPrefix();
    final user = TiebaUser.fromProtoOrNull(proto.author);
    final authorId = proto.authorId.toInt() != 0
        ? proto.authorId.toInt()
        : (user?.userId ?? 0);
    return TiebaComment(
      contents: contents,
      fid: 0,
      fname: '',
      tid: 0,
      ppid: 0,
      pid: proto.id.toInt(),
      user: user,
      authorId: authorId,
      replyToId: replyToId,
      floor: proto.floor,
      agree: proto.agree.agreeNum.toInt(),
      disagree: proto.agree.disagreeNum.toInt(),
      createTime: proto.time,
      isThreadAuthor: false,
    );
  }
}

/// One page of sub-posts.
class TiebaComments {
  const TiebaComments({
    required this.objs,
    required this.page,
    required this.forum,
    required this.thread,
    required this.post,
  });

  final List<TiebaComment> objs;
  final TiebaPage page;
  final TiebaForum forum;
  final TiebaThread thread;
  final TiebaPost post;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory TiebaComments.fromProto(pb.PbFloorResIdl_DataRes data) {
    final page = TiebaPage.fromProto(data.page, computeHasMore: true);
    final forum = TiebaForum.fromSimpleProto(data.forum);
    final thread = TiebaThread.fromProto(data.thread)
      ..fid = forum.fid
      ..fname = forum.fname;
    final post = TiebaPost.fromProto(data.post)
      ..fid = forum.fid
      ..fname = forum.fname
      ..tid = thread.tid;

    final comments = <TiebaComment>[];
    for (final proto in data.subpostList) {
      final comment = TiebaComment.fromProto(proto)
        ..fid = forum.fid
        ..fname = forum.fname
        ..tid = thread.tid
        ..ppid = post.pid
        ..floor = post.floor;
      comment.isThreadAuthor = thread.authorId == comment.authorId;
      comments.add(comment);
    }

    return TiebaComments(
      objs: comments,
      page: page,
      forum: forum,
      thread: thread,
      post: post,
    );
  }
}
