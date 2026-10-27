import 'dart:convert';

import '../core/http_core.dart';
import '../models/bawu_enums.dart';
import '../models/bawu_postlog.dart';
import '../models/bawu_userlog.dart';

/// Builds the shared search query of the two moderator log pages.
///
/// aiotieba only sends `begin`/`end` when a start time is given; an end time
/// without a start time is ignored. When a start time is given but no end time,
/// the server treats the current time as the end.
Map<String, String> _logQuery({
  required String fname,
  required int pn,
  required String searchValue,
  required BawuSearchType searchType,
  required DateTime? startTime,
  required DateTime? endTime,
  required int opType,
}) {
  final query = <String, String>{'word': fname, 'pn': '$pn', 'ie': 'utf-8'};
  if (opType != 0) query['op_type'] = '$opType';
  if (searchValue.isNotEmpty) {
    query['svalue'] = searchValue;
    query['stype'] = searchType == BawuSearchType.user
        ? 'post_uname'
        : 'op_uname';
  }
  if (startTime != null) {
    final end = endTime ?? DateTime.now();
    query['begin'] = '${startTime.millisecondsSinceEpoch ~/ 1000}';
    query['end'] = '${end.millisecondsSinceEpoch ~/ 1000}';
  }
  return query;
}

/// Fetches one page of the moderator post-management log.
///
/// The endpoint returns an HTML page and requires STOKEN.
Future<BawuPostLogs> fetchBawuPostlogs(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  String searchValue = '',
  BawuSearchType searchType = BawuSearchType.user,
  DateTime? startTime,
  DateTime? endTime,
  int opType = 0,
}) async {
  final bytes = await http.webGetBytes(
    '/bawu2/platform/listPostLog',
    query: _logQuery(
      fname: fname,
      pn: pn,
      searchValue: searchValue,
      searchType: searchType,
      startTime: startTime,
      endTime: endTime,
      opType: opType,
    ),
  );
  return BawuPostLogs.fromHtml(utf8.decode(bytes, allowMalformed: true));
}

/// Fetches one page of the moderator user-management log.
///
/// The endpoint returns an HTML page and requires STOKEN.
Future<BawuUserLogs> fetchBawuUserlogs(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  String searchValue = '',
  BawuSearchType searchType = BawuSearchType.user,
  DateTime? startTime,
  DateTime? endTime,
  int opType = 0,
}) async {
  final bytes = await http.webGetBytes(
    '/bawu2/platform/listUserLog',
    query: _logQuery(
      fname: fname,
      pn: pn,
      searchValue: searchValue,
      searchType: searchType,
      startTime: startTime,
      endTime: endTime,
      opType: opType,
    ),
  );
  return BawuUserLogs.fromHtml(utf8.decode(bytes, allowMalformed: true));
}
