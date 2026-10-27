import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/notification.dart';

Future<TiebaAts> fetchAts(TiebaHttpCore http, {int pn = 1}) async {
  final json = await http.postForm('/c/u/feed/atme', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', http.account.bduss),
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('pn', '$pn'),
  ]);
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaAts.fromJson(json);
}
