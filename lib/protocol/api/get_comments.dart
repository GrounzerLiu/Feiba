import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/comment.dart';
import '_common.dart';

/// Fetches one page of sub-posts (comments) of a floor.
Future<TiebaComments> fetchComments(
  TiebaHttpCore http, {
  required int tid,
  required int pid,
  int pn = 1,
  bool isComment = false,
  CommentSortType sort = CommentSortType.asc,
}) async {
  final request = pb.PbFloorReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.kz = Int64(tid);
  if (isComment) {
    data.spid = Int64(pid);
  } else {
    data.pid = Int64(pid);
  }
  data.pn = pn;
  data.sort = sort.value;

  final bytes = await http.postProto(
    '/c/f/pb/floor',
    302002,
    request.writeToBuffer(),
  );
  final response = pb.PbFloorResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaComments.fromProto(response.data);
}
