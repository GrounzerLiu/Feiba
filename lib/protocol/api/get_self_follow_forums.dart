import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/self_forums.dart';

Future<TiebaSelfFollowForums> fetchSelfFollowForums(TiebaHttpCore http) async {
  final json = await http.webPostForm(
    '/c/f/forum/forumGuide',
    <MapEntry<String, String>>[
      const MapEntry<String, String>('sort_type', '3'),
      const MapEntry<String, String>('call_from', '3'),
    ],
    extraHeaders: <String, String>{'Subapp-Type': 'hybrid'},
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaSelfFollowForums.fromJson(json);
}
