import '../core/enums.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// A Tieba user, mirroring aiotieba's UserInfo family.
class TiebaUser {
  TiebaUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
    required this.level,
    required this.glevel,
    required this.gender,
    required this.ip,
    required this.icons,
    required this.isBawu,
    required this.isVip,
    required this.privLike,
    required this.privReply,
    required this.tiebaUid,
    this.age = 0,
    this.postNum = 0,
    this.threadNum = 0,
    this.agreeNum = 0,
    this.fanNum = 0,
    this.followNum = 0,
    this.forumNum = 0,
    this.sign = '',
    this.isBlocked = false,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;
  final int level;
  final int glevel;
  final Gender gender;
  final String ip;
  final List<String> icons;
  final bool isBawu;
  final bool isVip;
  final PrivLike privLike;
  final PrivReply privReply;
  final int tiebaUid;

  /// Account age in years.
  final double age;
  final int postNum;
  final int threadNum;
  int agreeNum;
  final int fanNum;
  final int followNum;
  final int forumNum;
  final String sign;
  bool isBlocked;

  bool get isValid => userId != 0;

  String get nickName => nickNameNew;

  String get displayName {
    if (nickNameNew.isNotEmpty) return nickNameNew;
    if (userName.isNotEmpty) return userName;
    return '$userId';
  }

  String? get avatarUrl {
    if (portrait.isEmpty) return null;
    return 'https://himg.bdimg.com/sys/portrait/item/$portrait';
  }

  factory TiebaUser.fromProto(pb.User proto) {
    final portrait = normalizePortrait(proto.portrait);
    final privSets = proto.privSets;
    return TiebaUser(
      userId: proto.id.toInt(),
      portrait: portrait,
      userName: proto.name,
      nickNameNew: proto.nameShow,
      level: proto.levelId,
      glevel: proto.userGrowth.levelId,
      gender: Gender.fromValue(proto.gender != 0 ? proto.gender : proto.sex),
      ip: proto.ipAddress,
      icons: <String>[
        for (final icon in proto.iconinfo)
          if (icon.name.isNotEmpty) icon.name,
      ],
      isBawu: proto.isBawu != 0,
      isVip: proto.isMem != 0,
      privLike: privSets.like == 0
          ? PrivLike.visible
          : PrivLike.fromValue(privSets.like),
      privReply: privSets.reply == 0
          ? PrivReply.all
          : PrivReply.fromValue(privSets.reply),
      tiebaUid: int.tryParse(proto.tiebaUid) ?? 0,
      age: double.tryParse(proto.tbAge) ?? 0,
      postNum: proto.postNum,
      threadNum: proto.threadNum,
      fanNum: proto.fansNum,
      followNum: proto.concernNum,
      forumNum: proto.myLikeNum,
      sign: proto.intro,
    );
  }

  /// Builds a minimal user from embedded name/portrait fields.
  factory TiebaUser.brief({
    required int userId,
    required String userName,
    required String nickName,
    required String portrait,
  }) {
    return TiebaUser(
      userId: userId,
      portrait: normalizePortrait(portrait),
      userName: userName,
      nickNameNew: nickName,
      level: 0,
      glevel: 0,
      gender: Gender.unknown,
      ip: '',
      icons: const <String>[],
      isBawu: false,
      isVip: false,
      privLike: PrivLike.visible,
      privReply: PrivReply.all,
      tiebaUid: 0,
    );
  }

  /// Parses a JSON user object (follow/at/forum responses).
  factory TiebaUser.fromJsonMap(Map<String, dynamic> json) {
    final priv = json['priv_sets'];
    final privMap = priv is Map
        ? priv.cast<String, dynamic>()
        : <String, dynamic>{};
    return TiebaUser(
      userId: parseInt(json['id'] ?? json['uid']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name'] ?? json['user_name']),
      nickNameNew: parseString(json['name_show'] ?? json['show_nickname']),
      level: parseInt(json['level_id']),
      glevel: 0,
      gender: Gender.fromValue(parseInt(json['gender'] ?? json['sex'])),
      ip: parseString(json['ip_address']),
      icons: <String>[
        if (json['iconinfo'] is List)
          for (final icon in (json['iconinfo'] as List).whereType<Map>())
            if (parseString(icon['name']).isNotEmpty) parseString(icon['name']),
      ],
      isBawu: parseInt(json['is_bawu']) != 0,
      isVip: parseInt(json['is_mem'] ?? json['is_vip']) != 0,
      privLike: PrivLike.fromValue(parseInt(privMap['like'], 1)),
      privReply: PrivReply.fromValue(parseInt(privMap['reply'], 1)),
      tiebaUid: int.tryParse(parseString(json['tieba_uid'])) ?? 0,
      age: double.tryParse(parseString(json['tb_age'])) ?? 0,
      postNum: parseInt(json['post_num']),
      threadNum: parseInt(json['thread_num']),
      fanNum: parseInt(json['fans_num']),
      followNum: parseInt(json['concern_num']),
      forumNum: parseInt(json['my_like_num']),
      sign: parseString(json['intro']),
    );
  }

  static TiebaUser? fromProtoOrNull(pb.User proto) {
    if (proto.id.toInt() == 0) return null;
    return TiebaUser.fromProto(proto);
  }

  @override
  String toString() => displayName;
}
