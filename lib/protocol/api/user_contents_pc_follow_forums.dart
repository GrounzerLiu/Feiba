import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/sign.dart';
import '../core/utils.dart';
import '../models/user_contents_pc_follow_forums.dart';

/// Fetches one page of the forums followed by a user through the PC endpoint.
///
/// Requires the target user's portrait; the query is signed with the PC salt.
Future<PcFollowForums> fetchPcFollowForums(
  TiebaHttpCore http, {
  required String portrait,
  int pn = 1,
  int rn = 50,
}) async {
  checkRn('rn', rn, 1, 200);

  final params = <MapEntry<String, String>>[
    MapEntry<String, String>('portrait', portrait),
    MapEntry<String, String>('pn', '$pn'),
    MapEntry<String, String>('rn', '$rn'),
    const MapEntry<String, String>('subapp_type', 'pc'),
    const MapEntry<String, String>('_client_type', '20'),
  ];
  final signed = signForm(params, salt: TiebaConstants.pcSalt);

  final json = await http.webGetJson(
    '/c/f/pc/myForumList',
    query: <String, String>{for (final entry in signed) entry.key: entry.value},
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('followed forum data is missing');
  }
  return PcFollowForums.fromJson(data.cast<String, dynamic>());
}
