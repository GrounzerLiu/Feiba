import '../protocol/api/get_ats.dart';
import '../protocol/api/get_fid.dart';
import '../protocol/api/get_replies.dart';
import '../protocol/api/get_user_info.dart';
import '../protocol/api/login.dart';
import '../protocol/api/write_ops.dart' as ops;
import '../protocol/core/account.dart';
import '../protocol/core/exceptions.dart';
import '../protocol/core/http_core.dart';
import '../protocol/models/notification.dart';
import '../protocol/models/user.dart' as protocol;
import 'session.dart';

String tiebaErrorMessage(Object error) {
  if (error is TiebaException) return error.message;
  return '$error';
}

/// Lazy bridge between the account session and the ported protocol layer.
///
/// Browsing uses `ProtocolBrowseRepository`; this service covers
/// account-bound actions and login validation through the ported protocol.
class TiebaApi {
  TiebaApi._();

  static final TiebaApi instance = TiebaApi._();

  TiebaHttpCore? _http;
  Future<TiebaHttpCore>? _pending;
  protocol.TiebaUser? _self;

  protocol.TiebaUser? get self => _self;
  bool get isReady => _http != null;

  void reset() {
    _http = null;
    _pending = null;
    _self = null;
  }

  Future<TiebaHttpCore> _ensure() {
    final existing = _http;
    if (existing != null) return Future<TiebaHttpCore>.value(existing);
    return _pending ??= _create().whenComplete(() => _pending = null);
  }

  Future<TiebaHttpCore> _create() async {
    final bduss = Session.instance.bduss?.trim() ?? '';
    if (bduss.isEmpty) {
      throw const TiebaValueException('请先登录贴吧账号');
    }
    if (bduss.length != 192) {
      throw const TiebaValueException('BDUSS 长度异常，请重新登录');
    }
    final rawStoken = Session.instance.stoken?.trim() ?? '';
    final stoken = rawStoken.length == 64 ? rawStoken : '';
    final account = TiebaAccount(bduss: bduss, stoken: stoken);
    final http = TiebaHttpCore(account: account);
    await fetchLogin(http);
    _http = http;
    return http;
  }

  /// Validates a BDUSS/STOKEN pair with the app login endpoint.
  ///
  /// On success the validated HTTP core is kept so the next profile or
  /// notification request does not log in again.
  Future<TiebaLoginInfo> validateCredentials(
    String bduss, {
    String? stoken,
  }) async {
    final value = bduss.trim();
    if (value.isEmpty) {
      throw const TiebaValueException('请先填写 BDUSS');
    }
    if (value.length != 192) {
      throw const TiebaValueException('BDUSS 长度异常，请从浏览器重新复制');
    }
    final rawStoken = stoken?.trim() ?? '';
    final account = TiebaAccount(
      bduss: value,
      stoken: rawStoken.length == 64 ? rawStoken : '',
    );
    final http = TiebaHttpCore(account: account);
    final info = await fetchLogin(http);
    _http = http;
    _pending = null;
    _self = null;
    return info;
  }

  Future<protocol.TiebaUser> selfProfile({bool refresh = false}) async {
    final cached = _self;
    if (cached != null && !refresh) return cached;
    final http = await _ensure();
    final user = await fetchUserInfo(http, userId: http.account.userId);
    if (user == null) {
      throw const TiebaValueException('没有获取到账号资料');
    }
    _self = user;
    return user;
  }

  Future<List<TiebaReply>> replies({int pn = 1}) async {
    final http = await _ensure();
    final page = await fetchReplies(http, pn: pn);
    return page.objs;
  }

  Future<List<TiebaAt>> ats({int pn = 1}) async {
    final http = await _ensure();
    final page = await fetchAts(http, pn: pn);
    return page.objs;
  }

  Future<void> followForum(
    String fname, {
    required bool follow,
    int? fid,
  }) async {
    final http = await _ensure();
    var forumId = fid ?? 0;
    if (forumId <= 0) forumId = await fetchFid(http, fname);
    if (follow) {
      await ops.followForum(http, forumId);
    } else {
      await ops.unfollowForum(http, forumId);
    }
  }

  Future<void> signForum(String fname) async {
    final http = await _ensure();
    await ops.signForum(http, fname);
  }

  Future<void> setThreadAgree(int tid, {required bool undo}) async {
    final http = await _ensure();
    await ops.setAgree(http, tid: tid, isUndo: undo);
  }
}
