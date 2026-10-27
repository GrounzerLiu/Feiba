import '../core/cache.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/forum.dart';

/// Fetches a forum by name using the app form endpoint.
Future<TiebaForum> fetchForum(TiebaHttpCore http, String fname) async {
  final json = await http.postForm(
    '/c/f/frs/frsBottom',
    <MapEntry<String, String>>[MapEntry<String, String>('kw', fname)],
  );
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final forum = json['forum'];
  if (forum is! Map) {
    throw const TiebaFormatException('forum payload is missing');
  }
  final result = TiebaForum.fromJson(forum.cast<String, dynamic>());
  ForumInfoCache.put(fid: result.fid, fname: result.fname);
  return result;
}
