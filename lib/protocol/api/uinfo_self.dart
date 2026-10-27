import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../models/uinfo_self.dart';
import '_common.dart';

/// Fetches the signed-in user's nickname info.
Future<UserInfoSelfInit> fetchSelfInitNickname(TiebaHttpCore http) async {
  final json = await http.postForm(
    '/c/s/initNickname',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    ],
  );
  ensureJsonOk(json);
  final userInfo = json['user_info'];
  if (userInfo is! Map) {
    throw const TiebaFormatException('user_info is missing');
  }
  return UserInfoSelfInit.fromJson(userInfo.cast<String, dynamic>());
}

/// Fetches the signed-in user's mobile index info.
Future<UserInfoMoindex> fetchSelfMoindex(TiebaHttpCore http) async {
  final json = await http.webGetJson(
    '/mo/q/newmoindex',
    query: const <String, String>{'need_user': '1'},
  );
  ensureWebOk(json);
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('moindex data is missing');
  }
  return UserInfoMoindex.fromJson(data.cast<String, dynamic>());
}
