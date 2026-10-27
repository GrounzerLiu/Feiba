import 'dart:convert';

import '../core/http_core.dart';
import '../models/bawu_blacklist.dart';
import 'bawu_common.dart';

/// Adds a user to the forum moderator blacklist.
///
/// [fname] is the forum name and [userId] the numeric user id.
Future<void> addBawuBlacklist(
  TiebaHttpCore http, {
  required String fname,
  required int userId,
}) async {
  final json = await http.webPostForm(
    '/bawu2/platform/addBlack',
    <MapEntry<String, String>>[
      MapEntry<String, String>('tbs', requireTbs(http)),
      MapEntry<String, String>('user_id', '$userId'),
      MapEntry<String, String>('word', fname),
      const MapEntry<String, String>('ie', 'utf-8'),
    ],
  );
  ensureBawuWebOk(json);
}

/// Removes a user from the forum moderator blacklist.
Future<void> delBawuBlacklist(
  TiebaHttpCore http, {
  required String fname,
  required int userId,
}) async {
  final json = await http.webPostForm(
    '/bawu2/platform/cancelBlack',
    <MapEntry<String, String>>[
      MapEntry<String, String>('word', fname),
      MapEntry<String, String>('tbs', requireTbs(http)),
      MapEntry<String, String>('list[]', '$userId'),
      const MapEntry<String, String>('ie', 'utf-8'),
    ],
  );
  ensureBawuWebOk(json);
}

/// Fetches one page of the forum moderator blacklist.
///
/// The endpoint returns an HTML page and requires STOKEN.
Future<BawuBlacklistUsers> fetchBawuBlacklist(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
}) async {
  final bytes = await http.webGetBytes(
    '/bawu2/platform/listBlackUser',
    query: <String, String>{'word': fname, 'pn': '$pn'},
  );
  return BawuBlacklistUsers.fromHtml(utf8.decode(bytes, allowMalformed: true));
}
