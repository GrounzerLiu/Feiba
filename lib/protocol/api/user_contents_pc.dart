import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/sign.dart';
import '../core/utils.dart';
import '../models/user_contents_pc.dart';

/// Fetches one page of replies published by a user through the PC endpoint.
///
/// Requires the target user's portrait; the query is signed with the PC salt.
Future<PcUserPosts> fetchPcUserPosts(
  TiebaHttpCore http, {
  required String portrait,
  int pn = 1,
  int rn = 20,
}) async {
  // The server caps the page at 72 items once rn reaches 74.
  checkRn('rn', rn, 1, 74);

  final params = <MapEntry<String, String>>[
    MapEntry<String, String>('pn', '$pn'),
    MapEntry<String, String>('rn', '$rn'),
    MapEntry<String, String>('portrait', portrait),
    const MapEntry<String, String>('type', '2'),
    const MapEntry<String, String>('subapp_type', 'pc'),
    const MapEntry<String, String>('_client_type', '20'),
  ];
  final signed = signForm(params, salt: TiebaConstants.pcSalt);

  final json = await http.webGetJson(
    '/c/u/feed/myThread',
    query: <String, String>{for (final entry in signed) entry.key: entry.value},
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('user post data is missing');
  }
  return PcUserPosts.fromJson(data.cast<String, dynamic>());
}
