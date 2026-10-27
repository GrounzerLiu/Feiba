/// A forum entry returned by the forum search endpoint.
class ForumSearchResult {
  const ForumSearchResult({
    required this.id,
    required this.name,
    this.nameShow,
    this.avatar,
    this.postNum = 0,
    this.memberNum = 0,
    this.postNumText,
    this.memberNumText,
  });

  factory ForumSearchResult.fromJson(Map<String, dynamic> json) {
    return ForumSearchResult(
      id: (json['forum_id'] as num?)?.toInt() ?? 0,
      name: (json['forum_name'] ?? '').toString(),
      nameShow: json['forum_name_show']?.toString(),
      avatar: json['avatar']?.toString(),
      postNum: (json['post_num_ori'] as num?)?.toInt() ?? 0,
      memberNum: (json['concern_num_ori'] as num?)?.toInt() ?? 0,
      postNumText: json['post_num']?.toString(),
      memberNumText: json['concern_num']?.toString(),
    );
  }

  final int id;
  final String name;
  final String? nameShow;
  final String? avatar;
  final int postNum;
  final int memberNum;
  final String? postNumText;
  final String? memberNumText;

  String get displayName => (nameShow != null && nameShow!.isNotEmpty) ? nameShow! : name;
}
