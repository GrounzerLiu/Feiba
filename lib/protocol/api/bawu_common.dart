import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '_common.dart';

/// Helpers shared by the forum-management endpoints.

/// Returns the account tbs token used by web form writes.
///
/// The token is issued during login; calling a write endpoint without it would
/// make the server return a generic error, so fail early instead.
String requireTbs(TiebaHttpCore http) {
  final tbs = http.account.tbs;
  if (tbs == null || tbs.isEmpty) {
    throw const TiebaValueException('tbs is empty; call login() first');
  }
  return tbs;
}

/// Validates a web JSON response.
///
/// Most endpoints report errors through `no`; the blacklist endpoints use
/// `errno` instead, so both are checked.
void ensureBawuWebOk(Map<String, dynamic> json) {
  final errno = parseInt(json['errno']);
  if (errno != 0) {
    throw TiebaServerException(errno, parseString(json['errmsg']));
  }
  ensureWebOk(json);
}

/// Returns the `data` object of a web JSON response.
Map<String, dynamic> requireWebData(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is Map<String, dynamic>) return data;
  if (data is Map) return Map<String, dynamic>.from(data);
  throw const TiebaFormatException('missing data object');
}
