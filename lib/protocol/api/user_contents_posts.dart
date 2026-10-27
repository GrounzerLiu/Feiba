import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import '../models/user_contents_posts.dart';
import '_common.dart';

/// Cmd of the user history endpoint.
const int _userPostCmd = 303002;

/// Fetches one page of replies published by a user.
///
/// [version] is the app client version sent in CommonReq; aiotieba lets
/// callers override it because the endpoint is picky about the version.
Future<UserPostss> fetchUserPosts(
  TiebaHttpCore http, {
  required int userId,
  int pn = 1,
  int rn = 20,
  String version = TiebaConstants.userPostsVersion,
}) async {
  // The server caps the page at 72 items once rn reaches 74.
  checkRn('rn', rn, 1, 74);

  final request = pb.UserPostReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: version, bduss: http.account.bduss);
  data.uid = Int64(userId);
  data.needContent = 1;
  data.pn = pn;
  data.rn = rn;

  final bytes = await http.postProto(
    '/c/u/feed/userpost',
    _userPostCmd,
    request.writeToBuffer(),
  );
  final response = pb.UserPostResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return UserPostss.fromProto(response.data);
}
