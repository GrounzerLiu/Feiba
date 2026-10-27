import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/follow.dart';

Future<TiebaBlacklist> fetchBlacklist(TiebaHttpCore http) async {
  final json = await http.postForm(
    '/c/u/user/userBlackPage',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaBlacklist.fromJson(json);
}
