import '../core/encoding.dart';
import '../core/http_core.dart';
import '../models/rank_users.dart';

/// Fetches one page of the forum level ranking table.
///
/// The endpoint answers with an HTML page, so failures surface as an empty
/// table rather than a [TiebaServerException]. It requires STOKEN, which the
/// shared transport forwards when the account has one.
Future<RankUsers> fetchRankUsers(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
}) async {
  final bytes = await http.webGetBytes(
    '/f/like/furank',
    query: <String, String>{'kw': fname, 'pn': '$pn', 'ie': 'utf-8'},
  );
  return RankUsers.fromHtml(decodeHtmlBytes(bytes));
}
