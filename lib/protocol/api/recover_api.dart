import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/recover_info.dart';
import '../models/recover_list.dart';
import '_common.dart';
import 'bawu_common.dart';

/// Fetches one page of posts waiting to be restored.
///
/// [rn] is the page size and must be within 1..50. When [userId] is given the
/// list is limited to posts deleted from that user.
Future<TiebaRecovers> fetchRecovers(
  TiebaHttpCore http, {
  required int fid,
  int pn = 1,
  int rn = 10,
  int? userId,
}) async {
  checkRn('rn', rn, 1, 50);
  final query = <String, String>{
    'rn': '$rn',
    'forum_id': '$fid',
    'pn': '$pn',
    'type': '1',
    'sub_type': '1',
  };
  if (userId != null && userId != 0) query['uid'] = '$userId';
  final json = await http.webGetJson(
    '/mo/q/manage/getRecoverList',
    query: query,
  );
  ensureWebOk(json);
  return TiebaRecovers.fromJson(json);
}

/// Fetches the detailed content of a post waiting to be restored.
///
/// [pid] is 0 for a thread and the reply id for a post or comment.
Future<TiebaRecoverInfo> fetchRecoverInfo(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  int pid = 0,
}) async {
  final json = await http.webGetJson(
    '/mo/q/bawu/getRecoverInfo',
    query: <String, String>{
      'forum_id': '$fid',
      'thread_id': '$tid',
      'post_id': '$pid',
      'type': '1',
      'sub_type': pid != 0 ? '2' : '1',
    },
  );
  ensureWebOk(json);
  return TiebaRecoverInfo.fromJson(requireWebData(json));
}

/// Restores a deleted thread or post, or lifts the hide flag of a thread.
///
/// Pass [tid] for a thread and [pid] for a post; [isHide] true cancels the
/// hide flag instead of restoring deleted content.
Future<void> recover(
  TiebaHttpCore http, {
  required int fid,
  int tid = 0,
  int pid = 0,
  bool isHide = false,
}) async {
  final json = await http.webPostForm(
    '/mo/q/bawurecoverthread',
    <MapEntry<String, String>>[
      MapEntry<String, String>('tbs', requireTbs(http)),
      const MapEntry<String, String>('fn', '-'),
      MapEntry<String, String>('fid', '$fid'),
      MapEntry<String, String>('tid_list[]', '$tid'),
      MapEntry<String, String>('pid_list[]', '$pid'),
      MapEntry<String, String>('type_list[]', pid != 0 ? '1' : '0'),
      MapEntry<String, String>('is_frs_mask_list[]', isHide ? '1' : '0'),
    ],
  );
  ensureWebOk(json);
}
