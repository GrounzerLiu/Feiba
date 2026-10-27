import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/notification.dart';
import '../models/user.dart';
import '../models/user_extra.dart';
import '_common.dart';

Future<TiebaBlacklistOld> fetchBlacklistOld(
  TiebaHttpCore http, {
  int pn = 1,
  int rn = 10,
}) async {
  final request = pb.UserMuteQueryReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.pn = pn;
  data.rn = rn;
  final bytes = await http.postProto(
    '/c/u/user/userMuteQuery',
    303028,
    request.writeToBuffer(),
  );
  final response = pb.UserMuteQueryResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaBlacklistOld(
    objs: <BlacklistOldUser>[
      for (final item in response.data.muteUser)
        BlacklistOldUser(
          userId: item.userId.toInt(),
          portrait: normalizePortrait(item.portrait),
          userName: item.userName,
          nickNameOld: item.nameShow,
          untilTime: item.muteTime,
        ),
    ],
    page: NotificationPage.fromProto(response.data.page),
  );
}

Future<TiebaDislikeForums> fetchDislikeForums(
  TiebaHttpCore http, {
  int pn = 1,
  int rn = 20,
}) async {
  final request = pb.GetDislikeListReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.pn = pn;
  data.rn = rn;
  final bytes = await http.postProto(
    '/c/u/user/getDislikeList',
    309692,
    request.writeToBuffer(),
  );
  final response = pb.GetDislikeListResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaDislikeForums(
    objs: <DislikeForum>[
      for (final item in response.data.forumList)
        DislikeForum(
          fid: item.forumId.toInt(),
          fname: item.forumName,
          memberNum: item.memberCount,
          postNum: item.postNum.toInt(),
          threadNum: item.threadNum.toInt(),
        ),
    ],
    page: DislikeForumsPage.fromProto(response.data),
  );
}

Future<TiebaUser?> fetchUserByTiebaUid(TiebaHttpCore http, int tiebaUid) async {
  final request = pb.GetUserByTiebaUidReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.tiebaUid = '$tiebaUid';
  final bytes = await http.postProto(
    '/c/u/user/getUserByTiebaUid',
    309702,
    request.writeToBuffer(),
  );
  final response = pb.GetUserByTiebaUidResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaUser.fromProtoOrNull(response.data.user);
}

Future<TiebaStatistics> fetchStatistics(TiebaHttpCore http, int fid) async {
  final json = await http.postForm(
    '/c/f/forum/getforumdata',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('forum_id', '$fid'),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final data = json['data'];
  List<int> series(int index) {
    if (data is! List || index >= data.length) return const <int>[];
    final item = data[index];
    if (item is! Map) return const <int>[];
    final group = item['group'];
    if (group is! List || group.length < 2) return const <int>[];
    final second = group[1];
    if (second is! Map) return const <int>[];
    final values = second['values'];
    if (values is! List) return const <int>[];
    return <int>[
      for (final value in values.reversed)
        if (value is Map) parseInt(value['value']),
    ];
  }

  return TiebaStatistics(
    view: series(0),
    thread: series(1),
    newMember: series(2),
    post: series(3),
    signRatio: series(4),
    avgTime: series(5),
    avgTimes: series(6),
    recommend: series(7),
  );
}
