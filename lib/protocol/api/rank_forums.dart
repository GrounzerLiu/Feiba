import 'dart:convert';

import '../core/http_core.dart';
import '../models/rank_forums.dart';

/// Fetches one page of the forum sign-in ranking table.
///
/// The endpoint answers with an HTML page, so failures surface as an empty
/// table rather than a [TiebaServerException].
Future<RankForums> fetchRankForums(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  RankForumType rankType = RankForumType.weekly,
}) async {
  final bytes = await http.webGetBytes(
    '/sign/index',
    query: <String, String>{
      'kw': fname,
      'type': '${rankType.value}',
      'pn': '$pn',
      'ie': 'utf-8',
    },
  );
  return RankForums.fromHtml(utf8.decode(bytes, allowMalformed: true));
}
