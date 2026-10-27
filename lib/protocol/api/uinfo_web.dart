import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/uinfo_web.dart';
import '_common.dart';

/// Fetches user info through the web IM endpoint.
///
/// The upstream implementation uses the plain HTTP scheme for this host; the
/// shared transport always speaks HTTPS, which serves the same JSON.
Future<UserInfoWeb> fetchUserInfoWeb(
  TiebaHttpCore http, {
  required int userId,
}) async {
  final json = await http.webGetJson(
    '/im/pcmsg/query/getUserInfo',
    query: <String, String>{'chatUid': '$userId'},
  );
  ensureWebOk(json);
  // This endpoint reports failures through errno/errmsg instead of no/error.
  final code = parseInt(json['errno']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['errmsg']));
  }
  final chatUser = json['chatUser'];
  if (chatUser is! Map) {
    throw const TiebaFormatException('chatUser is missing');
  }
  return UserInfoWeb.fromJson(chatUser.cast<String, dynamic>());
}
