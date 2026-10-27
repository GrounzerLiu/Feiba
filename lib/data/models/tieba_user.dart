/// A user entry from the page-level `user_list`.
class TiebaUser {
  const TiebaUser({
    required this.id,
    required this.name,
    this.nameShow,
    this.portrait,
    this.levelId,
  });

  factory TiebaUser.fromJson(Map<String, dynamic> json) {
    return TiebaUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      nameShow: json['name_show']?.toString(),
      portrait: json['portrait']?.toString(),
      levelId: (json['level_id'] as num?)?.toInt(),
    );
  }

  static Map<int, TiebaUser> parseUserList(dynamic value) {
    if (value is! List) return const <int, TiebaUser>{};
    final result = <int, TiebaUser>{};
    for (final item in value.whereType<Map>()) {
      final user = TiebaUser.fromJson(item.cast<String, dynamic>());
      if (user.id != 0) result[user.id] = user;
    }
    return result;
  }

  final int id;
  final String name;
  final String? nameShow;
  final String? portrait;
  final int? levelId;

  String get displayName => (nameShow != null && nameShow!.isNotEmpty) ? nameShow! : name;

  String? get avatarUrl {
    if (portrait == null || portrait!.isEmpty) return null;
    return 'https://himg.bdimg.com/sys/portrait/item/$portrait';
  }
}
