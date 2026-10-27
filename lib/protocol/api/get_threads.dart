import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/thread.dart';
import '_common.dart';

/// Fetches one page of threads from a forum.
Future<TiebaThreads> fetchThreads(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  int rn = 30,
  ThreadSortType sort = ThreadSortType.reply,
  bool isGood = false,
}) async {
  checkRn('rn', rn, 1, 100);
  final request = pb.FrsPageReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.legacyVersion);
  data.kw = fname;
  data.pn = pn == 1 ? 0 : pn;
  data.rn = rn;
  data.rnNeed = rn + 5;
  data.isGood = isGood ? 1 : 0;
  data.sortType = sort.value;

  final bytes = await http.postProto(
    '/c/f/frs/page',
    301001,
    request.writeToBuffer(),
  );
  final response = pb.FrsPageResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return TiebaThreads.fromProto(response.data);
}
