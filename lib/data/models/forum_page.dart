import 'content_node.dart';
import 'tieba_user.dart';

class TiebaForum {
  const TiebaForum({
    required this.id,
    required this.name,
    this.memberNum = 0,
    this.postNum = 0,
    this.slogan,
    this.avatar,
  });

  factory TiebaForum.fromJson(Map<String, dynamic> json) {
    return TiebaForum(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      memberNum: (json['member_num'] as num?)?.toInt() ?? 0,
      postNum: (json['post_num'] as num?)?.toInt() ?? 0,
      slogan: json['slogan']?.toString(),
      avatar: json['avatar']?.toString(),
    );
  }

  final int id;
  final String name;
  final int memberNum;
  final int postNum;
  final String? slogan;
  final String? avatar;
}

class ThreadSummary {
  const ThreadSummary({
    required this.tid,
    required this.title,
    required this.content,
    this.abstract,
    this.replyNum = 0,
    this.viewNum = 0,
    this.agreeNum = 0,
    this.authorId = 0,
    this.createTime = 0,
    this.lastTime = 0,
    this.isTop = false,
    this.isGood = false,
  });

  factory ThreadSummary.fromJson(Map<String, dynamic> json) {
    return ThreadSummary(
      tid: (json['tid'] ?? json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      content: ContentNode.parseList(json['first_post_content']),
      abstract: json['abstract']?.toString(),
      replyNum: (json['reply_num'] as num?)?.toInt() ?? 0,
      viewNum: (json['view_num'] as num?)?.toInt() ?? 0,
      agreeNum: (json['agree_num'] as num?)?.toInt() ?? 0,
      authorId: (json['author_id'] as num?)?.toInt() ?? 0,
      createTime: (json['create_time'] as num?)?.toInt() ?? 0,
      lastTime: (json['last_time_int'] as num?)?.toInt() ?? 0,
      isTop: ((json['is_top'] as num?)?.toInt() ?? 0) != 0,
      isGood: ((json['is_good'] as num?)?.toInt() ?? 0) != 0,
    );
  }

  final int tid;
  final String title;
  final List<ContentNode> content;
  final String? abstract;
  final int replyNum;
  final int viewNum;
  final int agreeNum;
  final int authorId;
  final int createTime;
  final int lastTime;
  final bool isTop;
  final bool isGood;

  String get preview => nodesToPlainText(content);

  DateTime get createDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);
}

class ForumPageData {
  const ForumPageData({
    required this.forum,
    required this.threads,
    required this.users,
    this.currentPage = 1,
    this.totalPage = 1,
    this.hasMore = false,
  });

  final TiebaForum? forum;
  final List<ThreadSummary> threads;
  final Map<int, TiebaUser> users;
  final int currentPage;
  final int totalPage;
  final bool hasMore;

  TiebaUser? userOf(int id) => users[id];
}
