import '../core/utils.dart';

/// One followed forum of a user, as returned by the PC web endpoint.
///
/// Mirrors aiotieba's `PcFollowForum`.
class PcFollowForum {
  const PcFollowForum({
    required this.fid,
    required this.fname,
    required this.level,
  });

  final int fid;
  final String fname;

  /// Level of the user inside the forum.
  final int level;

  factory PcFollowForum.fromJson(Map<String, dynamic> json) {
    return PcFollowForum(
      fid: parseInt(json['forum_id']),
      fname: parseString(json['forum_name']),
      level: parseInt(json['level_id']),
    );
  }

  @override
  bool operator ==(Object other) => other is PcFollowForum && other.fid == fid;

  @override
  int get hashCode => fid.hashCode;
}

/// One page of followed forums.
///
/// Mirrors aiotieba's `PcFollowForums`.
class PcFollowForums {
  const PcFollowForums({required this.objs, required this.hasMore});

  final List<PcFollowForum> objs;
  final bool hasMore;

  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  factory PcFollowForums.fromJson(Map<String, dynamic> data) {
    final like = data['like'];
    return PcFollowForums(
      objs: <PcFollowForum>[
        if (like is List)
          for (final item in like.whereType<Map>())
            PcFollowForum.fromJson(item.cast<String, dynamic>()),
      ],
      hasMore: parseInt(data['has_more']) != 0,
    );
  }
}
