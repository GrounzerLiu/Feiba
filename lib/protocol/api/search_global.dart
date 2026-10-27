import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/sign.dart';
import '../core/utils.dart';
import '../models/search.dart';

Future<TiebaSearchGlobals> fetchSearchGlobal(
  TiebaHttpCore http, {
  required String query,
  int pn = 1,
  int rn = 20,
  SearchGlobalType sort = SearchGlobalType.desc,
}) async {
  final signed = signForm(<MapEntry<String, String>>[
    MapEntry<String, String>('word', query),
    MapEntry<String, String>('pn', '$pn'),
    MapEntry<String, String>('rn', '$rn'),
    MapEntry<String, String>('st', '${sort.value}'),
    const MapEntry<String, String>('tt', '1'),
    const MapEntry<String, String>('subapp_type', 'pc'),
    const MapEntry<String, String>('_client_type', '20'),
  ], salt: TiebaConstants.pcSalt);
  final queryMap = <String, String>{
    for (final entry in signed) entry.key: entry.value,
  };
  final json = await http.webGetJson(
    '/mo/q/search/thread',
    query: queryMap,
    referer: 'https://tieba.baidu.com/f/search/res',
  );
  final code = parseInt(json['no']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error']));
  }
  final data = json['data'];
  if (data is! Map) {
    return const TiebaSearchGlobals(
      objs: <SearchGlobal>[],
      hasMore: false,
      currentPage: 0,
    );
  }
  return TiebaSearchGlobals.fromJson(data.cast<String, dynamic>());
}
