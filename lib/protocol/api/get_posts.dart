import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/post.dart';
import '_common.dart';

/// Fetches one page of replies from a thread.
Future<TiebaPosts> fetchPosts(
  TiebaHttpCore http, {
  required int tid,
  int pn = 1,
  int rn = 30,
  PostSortType sort = PostSortType.asc,
  bool onlyThreadAuthor = false,
  bool withComments = false,
  bool commentSortByAgree = true,
  int commentRn = 4,
}) async {
  checkRn('rn', rn, 2, 30);
  if (withComments) {
    checkRn('commentRn', commentRn, 1, 50);
  }

  final request = pb.PbPageReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.legacyVersion,
    bduss: withComments ? http.account.bduss : null,
  );
  data.kz = Int64(tid);
  data.pn = pn;
  data.rn = rn;
  data.r = sort.value;
  data.lz = onlyThreadAuthor ? 1 : 0;
  if (withComments) {
    data.withFloor = 1;
    data.floorSortType = commentSortByAgree ? 1 : 0;
    data.floorRn = commentRn;
  }

  final bytes = await http.postProto(
    '/c/f/pb/page',
    302001,
    request.writeToBuffer(),
  );
  final response = pb.PbPageResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaPosts.fromProto(response.data);
}
