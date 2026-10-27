import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../models/uinfo_json.dart';

/// Resolves a user name to its id and portrait through the legacy endpoint.
///
/// The upstream implementation uses the plain HTTP scheme for this host; the
/// shared transport always speaks HTTPS, which serves the same JSON.
Future<UserInfoJson> fetchUserJson(
  TiebaHttpCore http, {
  required String userName,
}) async {
  final json = await http.webGetJson(
    '/i/sys/user_json',
    query: <String, String>{'un': userName, 'ie': 'utf-8'},
  );
  final creator = json['creator'];
  if (creator is! Map) {
    // The legacy endpoint answers with an empty `{}` for unknown users.
    throw const TiebaFormatException('creator is missing');
  }
  return UserInfoJson.fromJson(creator.cast<String, dynamic>());
}
