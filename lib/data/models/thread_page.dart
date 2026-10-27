import 'content_node.dart';
import 'tieba_user.dart';

class SubPost {
  const SubPost({
    required this.id,
    required this.content,
    this.authorId = 0,
    this.time = 0,
    this.authorName,
    this.authorPortrait,
  });

  factory SubPost.fromJson(Map<String, dynamic> json) {
    final author = json['author'];
    final authorMap = author is Map ? author.cast<String, dynamic>() : null;
    final name = authorMap?['name_show']?.toString();
    return SubPost(
      id: (json['id'] as num?)?.toInt() ?? 0,
      content: ContentNode.parseList(json['content']),
      authorId: (authorMap?['id'] as num?)?.toInt() ??
          (json['author_id'] as num?)?.toInt() ??
          0,
      time: (json['time'] as num?)?.toInt() ?? 0,
      authorName: (name != null && name.isNotEmpty)
          ? name
          : authorMap?['name']?.toString(),
      authorPortrait: authorMap?['portrait']?.toString(),
    );
  }

  final int id;
  final List<ContentNode> content;
  final int authorId;
  final int time;
  final String? authorName;
  final String? authorPortrait;

  String get plainText => nodesToPlainText(content);

  String? get avatarUrl {
    if (authorPortrait == null || authorPortrait!.isEmpty) return null;
    return 'https://himg.bdimg.com/sys/portrait/item/$authorPortrait';
  }
}

/// One page of sub posts.
class SubPostPage {
  const SubPostPage({
    required this.posts,
    this.total = 0,
    this.hasMore = false,
  });

  final List<SubPost> posts;
  final int total;
  final bool hasMore;
}

class PostItem {
  const PostItem({
    required this.id,
    required this.floor,
    required this.content,
    this.authorId = 0,
    this.time = 0,
    this.agreeNum = 0,
    this.subPostNumber = 0,
    this.subPosts = const <SubPost>[],
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    final agree = json['agree'];
    final sub = json['sub_post_list'];
    final subList = sub is Map ? sub['sub_post_list'] : null;
    return PostItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      floor: (json['floor'] as num?)?.toInt() ?? 0,
      content: ContentNode.parseList(json['content']),
      authorId: (json['author_id'] as num?)?.toInt() ?? 0,
      time: (json['time'] as num?)?.toInt() ?? 0,
      agreeNum: agree is Map ? ((agree['agree_num'] as num?)?.toInt() ?? 0) : 0,
      subPostNumber: (json['sub_post_number'] as num?)?.toInt() ?? 0,
      subPosts: subList is List
          ? subList
              .whereType<Map>()
              .map((e) => SubPost.fromJson(e.cast<String, dynamic>()))
              .toList(growable: false)
          : const <SubPost>[],
    );
  }

  final int id;
  final int floor;
  final List<ContentNode> content;
  final int authorId;
  final int time;
  final int agreeNum;
  final int subPostNumber;
  final List<SubPost> subPosts;

  String get plainText => nodesToPlainText(content);

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(time * 1000);
}

class ThreadPageData {
  const ThreadPageData({
    required this.posts,
    required this.users,
    required this.title,
    this.currentPage = 1,
    this.totalPage = 1,
    this.hasMore = false,
  });

  final List<PostItem> posts;
  final Map<int, TiebaUser> users;
  final String title;
  final int currentPage;
  final int totalPage;
  final bool hasMore;

  TiebaUser? userOf(int id) => users[id];
}
