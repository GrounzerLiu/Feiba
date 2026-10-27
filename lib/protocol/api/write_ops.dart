import 'dart:convert';

import 'package:fixnum/fixnum.dart';

import '../generated/generated.dart' as pb;

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';

/// Write operations ported from aiotieba.
///
/// Every function throws [TiebaServerException] on a non-zero server code and
/// [TiebaValueException] when required account state (BDUSS/tbs) is missing.

String _bduss(TiebaHttpCore http) {
  final value = http.account.bduss;
  if (value.isEmpty) {
    throw const TiebaValueException('BDUSS is empty; log in first');
  }
  return value;
}

String _tbs(TiebaHttpCore http) {
  final value = http.account.tbs;
  if (value == null || value.isEmpty) {
    throw const TiebaValueException('tbs is empty; call login() first');
  }
  return value;
}

void _ensureOk(Map<String, dynamic> json) {
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final error = json['error'];
  if (error is Map) {
    final subCode = parseInt(error['errno']);
    if (subCode != 0) {
      throw TiebaServerException(subCode, parseString(error['errmsg']));
    }
  }
  final errno = parseInt(json['errorno']);
  if (errno != 0) {
    throw TiebaServerException(errno, parseString(json['errmsg']));
  }
}

void _ensureWebOk(Map<String, dynamic> json) {
  final code = parseInt(json['no']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error']));
  }
  final error = json['error'];
  if (error is Map) {
    final subCode = parseInt(error['errno']);
    if (subCode != 0) {
      throw TiebaServerException(subCode, parseString(error['errmsg']));
    }
  }
}

Future<Map<String, dynamic>> _post(
  TiebaHttpCore http,
  String path,
  List<MapEntry<String, String>> data,
) async {
  final json = await http.postForm(path, data);
  _ensureOk(json);
  return json;
}

// ---------------------------------------------------------------------------
// Likes
// ---------------------------------------------------------------------------

/// Likes, unlikes, dislikes or undislikes a thread/post/comment.
Future<void> setAgree(
  TiebaHttpCore http, {
  required int tid,
  int pid = 0,
  bool isComment = false,
  bool isDisagree = false,
  bool isUndo = false,
}) async {
  final contentType = pid == 0 ? 3 : (isComment ? 2 : 1);
  await _post(http, '/c/c/agree/opAgree', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('agree_type', isDisagree ? '5' : '2'),
    MapEntry<String, String>('cuid', http.account.cuidGalaxy2),
    MapEntry<String, String>('content_type', '$contentType'),
    MapEntry<String, String>('op_type', isUndo ? '1' : '0'),
    MapEntry<String, String>('post_id', '$pid'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('thread_id', '$tid'),
  ]);
}

// ---------------------------------------------------------------------------
// Sign-in
// ---------------------------------------------------------------------------

/// Signs a single forum in.
Future<void> signForum(TiebaHttpCore http, String fname) async {
  final json = await _post(http, '/c/c/forum/sign', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('kw', fname),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
  final userInfo = json['user_info'];
  if (userInfo is Map && parseInt(userInfo['sign_bonus_point']) == 0) {
    throw const TiebaValueException('sign_bonus_point is 0');
  }
}

/// Signs all followed forums in (one-tap sign-in).
Future<void> signForums(TiebaHttpCore http) async {
  final json = await http.webPostForm(
    '/c/c/forum/msign',
    <MapEntry<String, String>>[
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      const MapEntry<String, String>('subapp_type', 'hybrid'),
    ],
    extraHeaders: <String, String>{'Subapp-Type': 'hybrid'},
  );
  _ensureOk(json);
}

/// Completes the user-growth daily sign-in task.
Future<void> signGrowth(TiebaHttpCore http) async {
  final json = await http.webPostForm(
    '/mo/q/usergrowth/commitUGTaskInfo',
    <MapEntry<String, String>>[
      MapEntry<String, String>('tbs', _tbs(http)),
      const MapEntry<String, String>('act_type', 'page_sign'),
      const MapEntry<String, String>('cuid', '-'),
    ],
  );
  _ensureWebOk(json);
}

// ---------------------------------------------------------------------------
// Follow / fans
// ---------------------------------------------------------------------------

Future<void> followForum(TiebaHttpCore http, int fid) async {
  await _post(http, '/c/c/forum/like', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
}

Future<void> unfollowForum(TiebaHttpCore http, int fid) async {
  await _post(http, '/c/c/forum/unfavolike', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
}

Future<void> followUser(TiebaHttpCore http, String portrait) async {
  await _post(http, '/c/c/user/follow', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('portrait', portrait),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
}

Future<void> unfollowUser(TiebaHttpCore http, String portrait) async {
  await _post(http, '/c/c/user/unfollow', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('portrait', portrait),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
}

Future<void> removeFan(TiebaHttpCore http, int userId) async {
  await _post(http, '/c/c/user/removeFans', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fans_uid', '$userId'),
    MapEntry<String, String>('tbs', _tbs(http)),
  ]);
}

// ---------------------------------------------------------------------------
// Deletion (moderation / own content)
// ---------------------------------------------------------------------------

Future<void> deletePost(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  required int pid,
}) async {
  await _post(http, '/c/c/bawu/delpost', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('pid', '$pid'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('z', '$tid'),
  ]);
}

Future<void> deleteThread(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  bool isHide = false,
}) async {
  await _post(http, '/c/c/bawu/delthread', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('is_frs_mask', isHide ? '1' : '0'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('z', '$tid'),
  ]);
}

Future<void> deletePosts(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  required Iterable<int> pids,
  bool isHide = false,
}) async {
  await _post(http, '/c/c/bawu/multiDelPost', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('forum_id', '$fid'),
    MapEntry<String, String>('post_ids', pids.join(',')),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('thread_id', '$tid'),
    MapEntry<String, String>('type', isHide ? '2' : '1'),
  ]);
}

Future<void> deleteThreads(
  TiebaHttpCore http, {
  required int fid,
  required Iterable<int> tids,
  bool isHide = false,
}) async {
  await _post(http, '/c/c/bawu/multiDelThread', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('forum_id', '$fid'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('thread_ids', tids.join(',')),
    MapEntry<String, String>('type', isHide ? '2' : '1'),
  ]);
}

// ---------------------------------------------------------------------------
// Blocking
// ---------------------------------------------------------------------------

Future<void> blockUser(
  TiebaHttpCore http, {
  required int fid,
  required String portrait,
  required int day,
  String reason = '',
}) async {
  final isLoopBan = (day == 1 || day == 3 || day == 10) ? '0' : '1';
  await _post(http, '/c/c/bawu/commitprison', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('day', '$day'),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('is_loop_ban', isLoopBan),
    const MapEntry<String, String>('ntn', 'banid'),
    MapEntry<String, String>('portrait', portrait),
    MapEntry<String, String>('reason', reason),
    MapEntry<String, String>('tbs', _tbs(http)),
    const MapEntry<String, String>('word', '-'),
    const MapEntry<String, String>('z', '6'),
  ]);
}

Future<void> unblockUser(
  TiebaHttpCore http, {
  required int fid,
  required int userId,
}) async {
  final json = await http.webPostForm(
    '/mo/q/bawublockclear',
    <MapEntry<String, String>>[
      const MapEntry<String, String>('fn', '-'),
      MapEntry<String, String>('fid', '$fid'),
      const MapEntry<String, String>('block_un', '-'),
      MapEntry<String, String>('block_uid', '$userId'),
      MapEntry<String, String>('tbs', _tbs(http)),
    ],
  );
  _ensureWebOk(json);
}

// ---------------------------------------------------------------------------
// Profile / privacy
// ---------------------------------------------------------------------------

Future<void> setProfile(
  TiebaHttpCore http, {
  required String nickName,
  String sign = '',
  Gender gender = Gender.unknown,
}) async {
  await _post(http, '/c/c/profile/modify', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('intro', sign),
    MapEntry<String, String>('nick_name', nickName),
    MapEntry<String, String>('sex', '${gender.value}'),
  ]);
}

Future<void> setThreadPrivacy(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  required int pid,
  required bool isHide,
}) async {
  await _post(http, '/c/c/thread/setPrivacy', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('forum_id', '$fid'),
    MapEntry<String, String>('is_hide', isHide ? '1' : '0'),
    MapEntry<String, String>('post_id', '$pid'),
    MapEntry<String, String>('thread_id', '$tid'),
  ]);
}

Future<void> setNicknameOld(TiebaHttpCore http, String nickName) async {
  final json = await http.webPostForm(
    '/mo/q/submit/modifyNickname',
    const <MapEntry<String, String>>[],
    query: <String, String>{'nickname': nickName, 'tbs': '1'},
  );
  _ensureWebOk(json);
}

/// Adds or removes a user from the new-format blacklist.
///
/// Each flag means "block this interaction"; false restores it.
Future<void> setBlacklist(
  TiebaHttpCore http, {
  required int userId,
  required bool follow,
  required bool interact,
  required bool chat,
}) async {
  final request = pb.SetUserBlackReqIdl();
  final data = request.ensureData();
  data.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = TiebaConstants.latestVersion
    ..bDUSS = _bduss(http);
  data.blackUid = Int64(userId);
  final perm = data.ensurePermList()
    ..follow = follow ? 1 : 2
    ..interact = interact ? 1 : 2
    ..chat = chat ? 1 : 2;
  data.permList = perm;
  final bytes = await http.postProto(
    '/c/c/user/setUserBlack',
    309697,
    request.writeToBuffer(),
  );
  final response = pb.SetUserBlackResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
}

/// Votes in a poll thread.
Future<void> addPoll(
  TiebaHttpCore http, {
  required int tid,
  required Iterable<int> options,
}) async {
  final request = pb.AddPollReqIdl();
  final data = request.ensureData();
  data.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = TiebaConstants.latestVersion
    ..bDUSS = _bduss(http);
  data.threadId = Int64(tid);
  data.options = options.join(',');
  data.forumId = Int64(6);
  final bytes = await http.postProto(
    '/c/c/post/addPollPost',
    309006,
    request.writeToBuffer(),
  );
  final response = pb.AddPollResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
}

Future<void> addBlacklistOld(TiebaHttpCore http, int userId) async {
  await _post(http, '/c/c/user/userMuteAdd', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('mute_user', '$userId'),
  ]);
}

Future<void> deleteBlacklistOld(TiebaHttpCore http, int userId) async {
  await _post(http, '/c/c/user/userMuteDel', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('mute_user', '$userId'),
  ]);
}

// ---------------------------------------------------------------------------
// Forum recommendations / moderation
// ---------------------------------------------------------------------------

Future<void> dislikeForum(TiebaHttpCore http, int fid) async {
  final payload = jsonEncode(<Map<String, Object>>[
    <String, Object>{
      'tid': 1,
      'dislike_ids': 7,
      'fid': fid,
      'click_time': DateTime.now().millisecondsSinceEpoch,
    },
  ]);
  await _post(http, '/c/c/excellent/submitDislike', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('dislike', payload),
    const MapEntry<String, String>('dislike_from', 'homepage'),
  ]);
}

Future<void> undislikeForum(TiebaHttpCore http, int fid) async {
  await _post(
    http,
    '/c/c/excellent/submitCancelDislike',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', _bduss(http)),
      MapEntry<String, String>('cuid', http.account.cuid),
      MapEntry<String, String>('forum_id', '$fid'),
    ],
  );
}

Future<void> recommendThread(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
}) async {
  final json = await _post(
    http,
    '/c/c/bawu/pushRecomToPersonalized',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', _bduss(http)),
      MapEntry<String, String>('forum_id', '$fid'),
      MapEntry<String, String>('thread_id', '$tid'),
    ],
  );
  final data = json['data'];
  if (data is Map && parseInt(data['is_push_success']) != 1) {
    throw TiebaServerException(0, parseString(data['msg']));
  }
}

Future<void> topThread(
  TiebaHttpCore http, {
  required String fname,
  required int fid,
  required int tid,
  bool isVip = false,
  bool isSet = true,
}) async {
  await _post(http, '/c/c/bawu/committop', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('is_member_top', isVip ? '1' : '0'),
    MapEntry<String, String>('ntn', isSet ? 'set' : ''),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('word', fname),
    MapEntry<String, String>('z', '$tid'),
  ]);
}

Future<void> goodThread(
  TiebaHttpCore http, {
  required String fname,
  required int fid,
  required int tid,
  int cid = 0,
}) async {
  await _post(http, '/c/c/bawu/commitgood', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('cid', '$cid'),
    MapEntry<String, String>('fid', '$fid'),
    const MapEntry<String, String>('ntn', 'set'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('word', fname),
    MapEntry<String, String>('z', '$tid'),
  ]);
}

Future<void> ungoodThread(
  TiebaHttpCore http, {
  required String fname,
  required int fid,
  required int tid,
}) async {
  await _post(http, '/c/c/bawu/commitgood', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('fid', '$fid'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('word', fname),
    MapEntry<String, String>('z', '$tid'),
  ]);
}

Future<void> moveThread(
  TiebaHttpCore http, {
  required int fid,
  required int tid,
  required int toTabId,
  int fromTabId = 0,
}) async {
  final payload = jsonEncode(<Map<String, Object>>[
    <String, Object>{
      'thread_id': tid,
      'from_tab_id': fromTabId,
      'to_tab_id': toTabId,
    },
  ]);
  await _post(http, '/c/c/bawu/moveTabThread', <MapEntry<String, String>>[
    MapEntry<String, String>('BDUSS', _bduss(http)),
    MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
    MapEntry<String, String>('forum_id', '$fid'),
    MapEntry<String, String>('tbs', _tbs(http)),
    MapEntry<String, String>('threads', payload),
  ]);
}
