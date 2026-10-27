import 'package:fixnum/fixnum.dart';

import '../core/cache.dart';
import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/forum_detail.dart';
import '../models/page.dart';
import '_common.dart';

Future<TiebaForumDetail> fetchForumDetail(TiebaHttpCore http, int fid) async {
  final request = pb.GetForumDetailReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.forumId = Int64(fid);
  final bytes = await http.postProto(
    '/c/f/forum/getforumdetail',
    303021,
    request.writeToBuffer(),
  );
  final response = pb.GetForumDetailResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  final info = response.data.forumInfo;
  final result = TiebaForumDetail(
    fid: info.forumId.toInt(),
    fname: info.forumName,
    category: info.lv1Name,
    smallAvatar: info.avatar,
    originAvatar: info.avatarOrigin,
    slogan: info.slogan,
    memberNum: info.memberCount,
    postNum: info.threadCount,
    hasBawu: response.data.electionTab.newStrategyText == '已有吧主',
  );
  ForumInfoCache.put(fid: result.fid, fname: result.fname);
  return result;
}

Future<TiebaForumLevel> fetchForumLevel(TiebaHttpCore http, int fid) async {
  final request = pb.GetLevelInfoReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.forumId = Int64(fid);
  final bytes = await http.postProto(
    '/c/f/forum/getLevelInfo',
    301005,
    request.writeToBuffer(),
  );
  final response = pb.GetLevelInfoResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaForumLevel(
    levelName: response.data.levelName,
    userLevel: response.data.userLevel,
    isLike: response.data.isLike != 0,
  );
}

Future<Map<String, int>> fetchTabMap(TiebaHttpCore http, String fname) async {
  final request = pb.SearchPostForumReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.fname = fname;
  final bytes = await http.postProto(
    '/c/f/forum/searchPostForum',
    309466,
    request.writeToBuffer(),
  );
  final response = pb.SearchPostForumResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return <String, int>{
    for (final tab in response.data.exactMatch.tabInfo) tab.tabName: tab.tabId,
  };
}

Future<TiebaSquareForums> fetchSquareForums(
  TiebaHttpCore http, {
  required String cname,
  int pn = 1,
  int rn = 20,
}) async {
  final request = pb.GetForumSquareReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.className = cname;
  data.pn = pn;
  data.rn = rn;
  final bytes = await http.postProto(
    '/c/f/forum/getForumSquare',
    309653,
    request.writeToBuffer(),
  );
  final response = pb.GetForumSquareResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaSquareForums(
    objs: <TiebaSquareForum>[
      for (final item in response.data.forumInfo)
        TiebaSquareForum(
          fid: item.forumId.toInt(),
          fname: item.forumName,
          memberNum: item.memberCount,
          threadNum: item.threadCount,
          isFollowed: item.isLike != 0,
        ),
    ],
    page: TiebaPage.fromProto(response.data.page),
  );
}

Future<TiebaRecomStatus> fetchRecomStatus(TiebaHttpCore http, int fid) async {
  final json = await http.postForm(
    '/c/f/bawu/getRecomThreadList',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('forum_id', '$fid'),
      const MapEntry<String, String>('pn', '1'),
      const MapEntry<String, String>('rn', '0'),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaRecomStatus(
    total: parseInt(json['total_recommend_num']),
    used: parseInt(json['used_recommend_num']),
  );
}
