import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';

/// Result of the app login endpoint.
class TiebaLoginInfo {
  const TiebaLoginInfo({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.tbs,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String tbs;
}

/// Logs in with the current BDUSS and refreshes the anti-CSRF token.
Future<TiebaLoginInfo> fetchLogin(TiebaHttpCore http) async {
  final json = await http.postForm('/c/s/login', <MapEntry<String, String>>[
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('bdusstoken', http.account.bduss),
  ]);
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final user = json['user'];
  final anti = json['anti'];
  if (user is! Map || anti is! Map) {
    throw const TiebaFormatException('login payload is missing user or anti');
  }
  final userMap = user.cast<String, dynamic>();
  final antiMap = anti.cast<String, dynamic>();
  final info = TiebaLoginInfo(
    userId: parseInt(userMap['id']),
    portrait: normalizePortrait(parseString(userMap['portrait'])),
    userName: parseString(userMap['name']),
    tbs: parseString(antiMap['tbs']),
  );
  http.account
    ..userId = info.userId
    ..userName = info.userName
    ..portrait = info.portrait
    ..tbs = info.tbs.isEmpty ? null : info.tbs;
  return info;
}
