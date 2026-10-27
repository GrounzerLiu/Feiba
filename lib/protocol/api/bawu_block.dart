import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/bawu_block.dart';
import '_common.dart';
import 'bawu_common.dart';

/// Fetches one page of banned users waiting to be unblocked.
///
/// [name] filters the list by user name or nickname when it is not empty.
Future<BawuBlocks> fetchBlocks(
  TiebaHttpCore http, {
  required int fid,
  String name = '',
  int pn = 1,
}) async {
  final json = await http.webGetJson(
    '/mo/q/bawublock',
    query: <String, String>{
      'fn': '-',
      'fid': '$fid',
      'word': name,
      'is_ajax': '1',
      'pn': '$pn',
    },
  );
  ensureWebOk(json);
  return BawuBlocks.fromJson(json);
}

/// Fetches one page of ban appeals.
///
/// [rn] is the page size and must be within 1..50.
Future<BawuAppeals> fetchUnblockAppeals(
  TiebaHttpCore http, {
  required int fid,
  int pn = 1,
  int rn = 5,
}) async {
  checkRn('rn', rn, 1, 50);
  final json = await http.webPostForm(
    '/mo/q/getBawuAppealList',
    <MapEntry<String, String>>[
      const MapEntry<String, String>('fn', '-'),
      MapEntry<String, String>('fid', '$fid'),
      MapEntry<String, String>('pn', '$pn'),
      MapEntry<String, String>('rn', '$rn'),
      MapEntry<String, String>('tbs', requireTbs(http)),
    ],
  );
  ensureWebOk(json);
  return BawuAppeals.fromJson(json);
}

/// Accepts or refuses ban appeals.
///
/// [appealIds] holds at most 30 ids; [refuse] true rejects the appeals and
/// false accepts them.
Future<void> handleUnblockAppeals(
  TiebaHttpCore http, {
  required int fid,
  required Iterable<int> appealIds,
  bool refuse = true,
}) async {
  final data = <MapEntry<String, String>>[
    const MapEntry<String, String>('fn', '-'),
    MapEntry<String, String>('fid', '$fid'),
  ];
  var index = 0;
  for (final appealId in appealIds) {
    data.add(MapEntry<String, String>('appeal_list[${index++}]', '$appealId'));
  }
  data.addAll(<MapEntry<String, String>>[
    const MapEntry<String, String>('refuse_reason', '_'),
    MapEntry<String, String>('status', refuse ? '2' : '1'),
    MapEntry<String, String>('tbs', requireTbs(http)),
  ]);
  final json = await http.webPostForm('/mo/q/multiAppealhandle', data);
  ensureWebOk(json);
}
