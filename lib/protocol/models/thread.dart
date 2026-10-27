import '../core/enums.dart';
import '../generated/generated.dart' as pb;
import 'contents.dart';
import 'forum.dart';
import 'page.dart';
import 'user.dart';

class VoteOption {
  const VoteOption({required this.voteNum, required this.text});

  final int voteNum;
  final String text;
}

class VoteInfo {
  const VoteInfo({
    required this.title,
    required this.isMulti,
    required this.options,
    required this.totalVote,
    required this.totalUser,
  });

  final String title;
  final bool isMulti;
  final List<VoteOption> options;
  final int totalVote;
  final int totalUser;

  bool get isValid => options.isNotEmpty;

  factory VoteInfo.fromProto(pb.PollInfo proto) {
    return VoteInfo(
      title: proto.title,
      isMulti: proto.isMulti != 0,
      options: <VoteOption>[
        for (final option in proto.options)
          VoteOption(voteNum: option.num.toInt(), text: option.text),
      ],
      totalVote: proto.totalPoll.toInt(),
      totalUser: proto.totalNum.toInt(),
    );
  }
}

/// A shared origin thread embedded in a share thread.
class ShareThread {
  const ShareThread({
    required this.contents,
    required this.title,
    required this.authorId,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.voteInfo,
    required this.replyNum,
    required this.shareNum,
    required this.agree,
    required this.disagree,
    required this.isDeleted,
  });

  final Contents contents;
  final String title;
  final int authorId;
  final int fid;
  final String fname;
  final int tid;
  final int pid;
  final VoteInfo? voteInfo;
  final int replyNum;
  final int shareNum;
  final int agree;
  final int disagree;
  final bool isDeleted;

  String get text => title.isEmpty ? contents.text : '$title\n${contents.text}';

  factory ShareThread.fromProto(pb.ThreadInfo_OriginThreadInfo proto) {
    final authorId = proto.author.id.toInt() != 0
        ? proto.author.id.toInt()
        : (proto.content.isNotEmpty ? proto.content.first.uid.toInt() : 0);
    return ShareThread(
      contents: Contents.fromThreadOrigin(proto),
      title: proto.title,
      authorId: authorId,
      fid: proto.fid.toInt(),
      fname: proto.fname,
      tid: int.tryParse(proto.tid) ?? 0,
      pid: proto.pid.toInt(),
      voteInfo: VoteInfo.fromProto(proto.pollInfo),
      replyNum: proto.replyNum,
      shareNum: proto.sharedNum,
      agree: proto.agree.agreeNum.toInt(),
      disagree: proto.agree.disagreeNum.toInt(),
      isDeleted: proto.isDeleted != 0,
    );
  }
}

/// A theme thread (topic) entry.
class TiebaThread {
  TiebaThread({
    required this.contents,
    required this.title,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.user,
    required this.authorId,
    required this.type,
    required this.tabId,
    required this.isGood,
    required this.isTop,
    required this.isShare,
    required this.isHide,
    required this.isLivepost,
    required this.voteInfo,
    required this.shareOrigin,
    required this.viewNum,
    required this.replyNum,
    required this.shareNum,
    required this.agree,
    required this.disagree,
    required this.collectNum,
    required this.validPostNum,
    required this.createTime,
    required this.lastTime,
  });

  final Contents contents;
  final String title;

  int fid;
  String fname;
  final int tid;
  final int pid;
  TiebaUser? user;
  int authorId;

  final ThreadType type;
  final int tabId;
  final bool isGood;
  final bool isTop;
  final bool isShare;
  final bool isHide;
  final bool isLivepost;

  final VoteInfo? voteInfo;
  final ShareThread? shareOrigin;

  final int viewNum;
  final int replyNum;
  final int shareNum;
  final int agree;
  final int disagree;
  final int collectNum;
  final int validPostNum;
  final int createTime;
  final int lastTime;

  String get text => title.isEmpty ? contents.text : '$title\n${contents.text}';

  String get preview => contents.displayText;

  DateTime get createDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  DateTime get lastDateTime =>
      DateTime.fromMillisecondsSinceEpoch(lastTime * 1000);

  factory TiebaThread.fromProto(
    pb.ThreadInfo proto, {
    Contents? contentsOverride,
    VoteInfo? voteInfoOverride,
    ShareThread? shareOriginOverride,
  }) {
    final user = TiebaUser.fromProtoOrNull(proto.author);
    final authorId = proto.authorId.toInt() != 0
        ? proto.authorId.toInt()
        : (user?.userId ?? 0);
    var isShare = proto.isShareThread != 0;
    if (isShare && proto.originThreadInfo.pid.toInt() == 0) {
      // A share thread without an origin is not a share thread in aiotieba.
      isShare = false;
    }
    final pid = proto.firstPostId.toInt() != 0
        ? proto.firstPostId.toInt()
        : proto.postId.toInt();
    return TiebaThread(
      contents: contentsOverride ?? Contents.fromThread(proto),
      title: proto.title,
      fid: proto.fid.toInt(),
      fname: proto.fname,
      tid: proto.id.toInt(),
      pid: pid,
      user: user,
      authorId: authorId,
      type: ThreadType.fromValue(proto.threadType),
      tabId: proto.tabId,
      isGood: proto.isGood != 0,
      isTop: proto.isTop != 0,
      isShare: isShare,
      isHide: proto.isFrsMask != 0,
      isLivepost: proto.isLivepost != 0,
      voteInfo: voteInfoOverride ?? VoteInfo.fromProto(proto.pollInfo),
      shareOrigin:
          shareOriginOverride ??
          (isShare ? ShareThread.fromProto(proto.originThreadInfo) : null),
      viewNum: proto.viewNum,
      replyNum: proto.replyNum,
      shareNum: proto.shareNum,
      agree: proto.agree.agreeNum.toInt(),
      disagree: proto.agree.disagreeNum.toInt(),
      collectNum: proto.collectNum,
      validPostNum: proto.validPostNum,
      createTime: proto.createTime,
      lastTime: proto.lastTimeInt,
    );
  }
}

/// One page of threads.
class TiebaThreads {
  const TiebaThreads({
    required this.objs,
    required this.page,
    required this.forum,
    required this.tabMap,
  });

  final List<TiebaThread> objs;
  final TiebaPage page;
  final TiebaForum forum;
  final Map<String, int> tabMap;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory TiebaThreads.fromProto(pb.FrsPageResIdl_DataRes data) {
    final page = TiebaPage.fromProto(data.page, normalizeFirstPage: true);
    final forum = TiebaForum.fromThreadsProto(data);
    final tabMap = <String, int>{
      for (final tab in data.navTabInfo.tab) tab.tabName: tab.tabId,
    };
    final users = <int, TiebaUser>{
      for (final user in data.userList)
        user.id.toInt(): TiebaUser.fromProto(user),
    };
    final threads = <TiebaThread>[];
    for (final proto in data.threadList) {
      final thread = TiebaThread.fromProto(proto);
      thread
        ..fid = forum.fid
        ..fname = forum.fname;
      final user = users[thread.authorId];
      if (user != null) thread.user = user;
      threads.add(thread);
    }
    return TiebaThreads(
      objs: threads,
      page: page,
      forum: forum,
      tabMap: tabMap,
    );
  }
}
