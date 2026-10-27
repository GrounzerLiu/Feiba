import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/sign.dart';
import '../core/utils.dart';
import '../models/uinfo_card.dart';

/// Fetches the PC user card.
///
/// The query is signed with the PC salt, like every `/c/u/pc` endpoint.
Future<UserInfoCard> fetchUserCard(
  TiebaHttpCore http, {
  required String portrait,
}) async {
  final params = <MapEntry<String, String>>[
    MapEntry<String, String>('portrait', portrait),
    const MapEntry<String, String>('subapp_type', 'pc'),
    const MapEntry<String, String>('_client_type', '20'),
  ];
  final signed = signForm(params, salt: TiebaConstants.pcSalt);

  final json = await http.webGetJson(
    '/c/u/pc/userCard',
    query: <String, String>{for (final entry in signed) entry.key: entry.value},
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('user card data is missing');
  }
  final userInfo = data['user_info'];
  if (userInfo is! Map) {
    throw const TiebaFormatException('user_info is missing');
  }
  return UserInfoCard.fromJson(userInfo.cast<String, dynamic>());
}
