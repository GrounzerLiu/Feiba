import 'forum_page.dart';
import 'tieba_user.dart';

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    this.avatar,
    this.level = 0,
    this.postNum = 0,
    this.fanNum = 0,
    this.followNum = 0,
    this.forumNum = 0,
    this.sign = '',
    this.isVip = false,
  });

  final int id;
  final String name;
  final String? avatar;
  final int level;
  final int postNum;
  final int fanNum;
  final int followNum;
  final int forumNum;
  final String sign;
  final bool isVip;

  String get displayName => name.isEmpty ? '$id' : name;
}

class UserPageData {
  const UserPageData({
    required this.profile,
    required this.threads,
    required this.users,
  });

  final UserProfile? profile;
  final List<ThreadSummary> threads;
  final Map<int, TiebaUser> users;
}
