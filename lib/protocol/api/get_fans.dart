import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/follow.dart';

Future<TiebaFans> fetchFans(
  TiebaHttpCore http, {
  required int userId,
  int pn = 1,
}) async {
  final json = await http.postForm('/c/u/fans/page', <MapEntry<String, String>>[
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('pn', '$pn'),
    MapEntry<String, String>('uid', '$userId'),
  ]);
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaFans.fromJson(json);
}
