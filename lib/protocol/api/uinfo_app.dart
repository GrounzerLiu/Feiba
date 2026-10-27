import 'package:fixnum/fixnum.dart';

import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/uinfo_app.dart';

/// Cmd of the app user-info endpoint.
const int _getUserInfoCmd = 303024;

/// Fetches user info through the app protobuf endpoint.
///
/// The upstream request only fills the user id, so no CommonReq block is sent.
Future<UserInfoApp> fetchUserInfoApp(
  TiebaHttpCore http, {
  required int userId,
}) async {
  final request = pb.GetUserInfoReqIdl();
  request.ensureData().userId = Int64(userId);

  final bytes = await http.postProto(
    '/c/u/user/getuserinfo',
    _getUserInfoCmd,
    request.writeToBuffer(),
  );
  final response = pb.GetUserInfoResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return UserInfoApp.fromProto(response.data.user);
}
