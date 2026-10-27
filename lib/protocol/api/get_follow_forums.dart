import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/follow.dart';

Future<TiebaFollowForums> fetchFollowForums(
  TiebaHttpCore http, {
  required int userId,
  int pn = 1,
  int rn = 20,
}) async {
  final json = await http.postForm(
    '/c/f/forum/like',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('friend_uid', '$userId'),
      MapEntry<String, String>('page_no', '$pn'),
      MapEntry<String, String>('page_size', '$rn'),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaFollowForums.fromJson(json);
}
