import '../core/encoding.dart';
import '../core/http_core.dart';
import '../models/rank_member_users.dart';

/// Fetches one page of the latest members of a forum.
///
/// The endpoint answers with an HTML page, so failures surface as an empty
/// table rather than a [TiebaServerException]. It requires STOKEN, which the
/// shared transport forwards when the account has one.
Future<MemberUsers> fetchMemberUsers(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
}) async {
  final bytes = await http.webGetBytes(
    '/bawu2/platform/listMemberInfo',
    query: <String, String>{'word': fname, 'pn': '$pn', 'ie': 'utf-8'},
  );
  return MemberUsers.fromHtml(decodeHtmlBytes(bytes));
}
