import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/last_replyers.dart';
import '../models/page.dart';
import '../models/user.dart';

/// Fetches a thread list that includes each thread's last replyer.
Future<TiebaLastReplyers> fetchLastReplyers(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  int rn = 30,
  int sort = 6,
  bool isGood = false,
}) async {
  checkRn('rn', rn, 1, 100);
  final request = pb.FrsPageReqIdl4lp();
  final data = request.ensureData();
  data.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = '6.0.1';
  data.kw = fname;
  data.pn = pn == 1 ? 0 : pn;
  data.rn = rn;
  data.rnNeed = rn + 5;
  data.isGood = isGood ? 1 : 0;
  data.sortType = sort;

  final bytes = await http.postProto(
    '/c/f/frs/page',
    301001,
    request.writeToBuffer(),
  );
  final response = pb.FrsPageResIdl4lp.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  final forum = response.data.forum;
  return TiebaLastReplyers(
    objs: <LastReplyerThread>[
      for (final item in response.data.threadList)
        LastReplyerThread(
          title: item.title,
          fid: forum.id.toInt(),
          fname: forum.name,
          tid: item.id.toInt(),
          pid: item.firstPostId.toInt(),
          author: TiebaUser.fromProtoOrNull(item.author),
          lastReplyer: TiebaUser.fromProtoOrNull(item.lastReplyer),
          isGood: item.isGood != 0,
          isTop: item.isTop != 0,
          createTime: item.createTime,
          lastTime: item.lastTimeInt,
        ),
    ],
    page: TiebaPage.fromProto(response.data.page, normalizeFirstPage: true),
    forumFid: forum.id.toInt(),
    forumFname: forum.name,
  );
}
