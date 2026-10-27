import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// A forum (bar) entry.
class TiebaForum {
  const TiebaForum({
    required this.fid,
    required this.fname,
    required this.category,
    required this.subcategory,
    required this.smallAvatar,
    required this.slogan,
    required this.memberNum,
    required this.postNum,
    required this.threadNum,
    required this.admins,
    required this.hasBawu,
  });

  final int fid;
  final String fname;
  final String category;
  final String subcategory;
  final String smallAvatar;
  final String slogan;
  final int memberNum;
  final int postNum;
  final int threadNum;
  final List<BawuInfo> admins;
  final bool hasBawu;

  bool get isValid => fid != 0 || fname.isNotEmpty;

  String? get avatarUrl => smallAvatar.isEmpty ? null : smallAvatar;

  factory TiebaForum.fromJson(Map<String, dynamic> json) {
    final managers = json['managers'];
    return TiebaForum(
      fid: parseInt(json['id']),
      fname: parseString(json['name']),
      category: parseString(json['first_class']),
      subcategory: parseString(json['second_class']),
      smallAvatar: parseString(json['avatar']),
      slogan: parseString(json['slogan']),
      memberNum: parseInt(json['member_num']),
      postNum: parseInt(json['post_num']),
      threadNum: parseInt(json['thread_num']),
      admins: managers is List
          ? <BawuInfo>[
              for (final item in managers.whereType<Map>())
                BawuInfo.fromJson(item.cast<String, dynamic>()),
            ]
          : const <BawuInfo>[],
      hasBawu: managers is List && managers.isNotEmpty,
    );
  }

  factory TiebaForum.fromSimpleProto(pb.SimpleForum proto) {
    return TiebaForum(
      fid: proto.id.toInt(),
      fname: proto.name,
      category: proto.firstClass,
      subcategory: proto.secondClass,
      smallAvatar: '',
      slogan: '',
      memberNum: proto.memberNum,
      postNum: proto.postNum,
      threadNum: 0,
      admins: const <BawuInfo>[],
      hasBawu: false,
    );
  }

  factory TiebaForum.fromThreadsProto(pb.FrsPageResIdl_DataRes data) {
    final forum = data.forum;
    return TiebaForum(
      fid: forum.id.toInt(),
      fname: forum.name,
      category: forum.firstClass,
      subcategory: forum.secondClass,
      smallAvatar: '',
      slogan: '',
      memberNum: forum.memberNum,
      postNum: forum.postNum,
      threadNum: forum.threadNum,
      admins: const <BawuInfo>[],
      hasBawu: forum.managers.isNotEmpty,
    );
  }
}

/// A forum moderator entry returned by the forum endpoint.
class BawuInfo {
  const BawuInfo({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;

  String get displayName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  factory BawuInfo.fromJson(Map<String, dynamic> json) {
    return BawuInfo(
      userId: parseInt(json['id']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name']),
      nickNameNew: parseString(json['show_name']),
    );
  }
}
