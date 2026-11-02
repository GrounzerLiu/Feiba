import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/forum_summary.dart';

/// Persists the last account followed-forum list so the follow tab can render
/// immediately while the network request refreshes it in the background.
class FollowedForumCache {
  FollowedForumCache._();

  static const String _key = 'followed_forums_cache_v1';

  static Future<List<ForumSummary>> load({String? account}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return const <ForumSummary>[];
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return const <ForumSummary>[];
      final cachedAccount = (decoded['account'] ?? '').toString();
      if (account != null &&
          account.isNotEmpty &&
          cachedAccount.isNotEmpty &&
          cachedAccount != account) {
        return const <ForumSummary>[];
      }
      final items = decoded['forums'];
      if (items is! List) return const <ForumSummary>[];
      return items.whereType<Map>().map((item) {
        final json = item.cast<String, dynamic>();
        return ForumSummary(
          fid: (json['fid'] as num?)?.toInt() ?? 0,
          name: (json['name'] ?? '').toString(),
          memberNum: (json['memberNum'] as num?)?.toInt() ?? 0,
          threadNum: (json['threadNum'] as num?)?.toInt() ?? 0,
          isFollowed: json['isFollowed'] == true,
          level: (json['level'] as num?)?.toInt() ?? 0,
          hotNum: (json['hotNum'] as num?)?.toInt() ?? 0,
          todayThreadNum: (json['todayThreadNum'] as num?)?.toInt() ?? 0,
          isSigned: json['isSigned'] == true,
        );
      }).where((forum) => forum.name.isNotEmpty).toList(growable: false);
    } catch (_) {
      return const <ForumSummary>[];
    }
  }

  static Future<void> save({
    required List<ForumSummary> forums,
    String? account,
  }) async {
    if (forums.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final payload = <String, dynamic>{
        'account': account ?? '',
        'forums': <Map<String, dynamic>>[
          for (final forum in forums.take(60))
            <String, dynamic>{
              'fid': forum.fid,
              'name': forum.name,
              'memberNum': forum.memberNum,
              'threadNum': forum.threadNum,
              'isFollowed': forum.isFollowed,
              'level': forum.level,
              'hotNum': forum.hotNum,
              'todayThreadNum': forum.todayThreadNum,
              'isSigned': forum.isSigned,
            },
        ],
      };
      await prefs.setString(_key, jsonEncode(payload));
    } catch (_) {
      // Cache is best effort; restricted app-data directories keep memory state.
    }
  }
}
