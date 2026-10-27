import '../core/cache.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';

/// Resolves a forum name to its fid via the web endpoint.
Future<int> fetchFid(TiebaHttpCore http, String fname) async {
  final cached = ForumInfoCache.getFid(fname);
  if (cached != null) return cached;
  final json = await http.webGetJson(
    '/f/commit/share/fnameShareApi',
    query: <String, String>{'fname': fname, 'ie': 'utf-8'},
  );
  final code = parseInt(json['no']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error']));
  }
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('fid payload is missing');
  }
  final fid = parseInt(data['fid']);
  if (fid == 0) {
    throw const TiebaValueException('fid is 0');
  }
  ForumInfoCache.put(fid: fid, fname: fname);
  return fid;
}
