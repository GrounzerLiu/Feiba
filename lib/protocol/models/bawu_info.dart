import '../generated/generated.dart' as pb;
import 'bawu_enums.dart';

/// One member of a forum's moderator team.
class BawuTeamUser {
  const BawuTeamUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
    required this.level,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;
  final int level;

  /// New-style nickname.
  String get nickName => nickNameNew;

  /// Preferred display name: nickname first, then user name.
  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  /// Name used in logs.
  String get displayName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return '$nickNameNew/$portrait';
    return '$userId';
  }

  factory BawuTeamUser.fromProto(
    pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub proto,
  ) {
    return BawuTeamUser(
      userId: proto.userId.toInt(),
      portrait: proto.portrait,
      userName: proto.userName,
      nickNameNew: proto.nameShow,
      level: proto.userLevel,
    );
  }
}

/// The moderator team of a forum, grouped by role.
///
/// Named `BawuTeamInfo` because `BawuInfo` already denotes a single forum
/// moderator entry in `models/forum.dart`.
class BawuTeamInfo {
  const BawuTeamInfo({
    required this.all,
    required this.admin,
    required this.manager,
    required this.voiceEditor,
    required this.imageEditor,
    required this.videoEditor,
    required this.broadcastEditor,
    required this.journalChiefEditor,
    required this.journalEditor,
    required this.professAdmin,
    required this.fourthAdmin,
  });

  /// Every moderator, in the order returned by the server.
  final List<BawuTeamUser> all;

  /// Forum owners.
  final List<BawuTeamUser> admin;

  /// Assistant moderators.
  final List<BawuTeamUser> manager;

  final List<BawuTeamUser> voiceEditor;
  final List<BawuTeamUser> imageEditor;
  final List<BawuTeamUser> videoEditor;
  final List<BawuTeamUser> broadcastEditor;
  final List<BawuTeamUser> journalChiefEditor;
  final List<BawuTeamUser> journalEditor;
  final List<BawuTeamUser> professAdmin;
  final List<BawuTeamUser> fourthAdmin;

  bool get isEmpty => all.isEmpty;

  factory BawuTeamInfo.fromProto(pb.GetBawuInfoResIdl_DataRes data) {
    final all = <BawuTeamUser>[];
    final grouped = <BawuType, List<BawuTeamUser>>{};
    for (final team in data.bawuTeamInfo.bawuTeamList) {
      for (final role in team.roleInfo) {
        final type = BawuType.fromValue(role.roleName);
        if (type == BawuType.unknown) continue;
        final user = BawuTeamUser.fromProto(role);
        all.add(user);
        grouped.putIfAbsent(type, () => <BawuTeamUser>[]).add(user);
      }
    }
    List<BawuTeamUser> extract(BawuType type) =>
        grouped[type] ?? const <BawuTeamUser>[];
    return BawuTeamInfo(
      all: all,
      admin: extract(BawuType.admin),
      manager: extract(BawuType.manager),
      voiceEditor: extract(BawuType.voiceEditor),
      imageEditor: extract(BawuType.imageEditor),
      videoEditor: extract(BawuType.videoEditor),
      broadcastEditor: extract(BawuType.broadcastEditor),
      journalChiefEditor: extract(BawuType.journalChiefEditor),
      journalEditor: extract(BawuType.journalEditor),
      professAdmin: extract(BawuType.professAdmin),
      fourthAdmin: extract(BawuType.fourthAdmin),
    );
  }
}
