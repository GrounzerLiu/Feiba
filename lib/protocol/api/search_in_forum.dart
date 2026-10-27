import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/search.dart';

Future<TiebaSearchInForums> fetchSearchInForum(
  TiebaHttpCore http, {
  required String fname,
  required String query,
  int pn = 1,
  int rn = 20,
  SearchInForumType type = SearchInForumType.all,
  bool onlyThread = false,
}) async {
  final json = await http.postForm(
    '/c/s/searchpost',
    <MapEntry<String, String>>[
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('kw', fname),
      MapEntry<String, String>('only_thread', onlyThread ? '1' : '0'),
      MapEntry<String, String>('pn', '$pn'),
      MapEntry<String, String>('rn', '$rn'),
      MapEntry<String, String>('sm', '${type.value}'),
      MapEntry<String, String>('word', query),
    ],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  return TiebaSearchInForums.fromJson(json);
}
