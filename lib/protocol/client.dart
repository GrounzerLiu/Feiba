import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api/account_init.dart';
import 'api/bawu_blacklist.dart' as bawu_blacklist_api;
import 'api/chat_client.dart';
import 'core/blcp/constants.dart';
import 'core/blcp/core.dart';
import 'core/ws/core.dart';
import 'api/bawu_block.dart' as bawu_block_api;
import 'api/bawu_logs.dart' as bawu_logs_api;
import 'api/bawu_perm.dart' as bawu_perm_api;
import 'api/bawu_team.dart' as bawu_team;
import 'api/recover_api.dart' as recover_api;
import 'api/forum_extra.dart';
import 'api/get_ats.dart';
import 'api/get_blacklist.dart';
import 'api/get_comments.dart';
import 'api/get_fans.dart';
import 'api/get_follow_forums.dart';
import 'api/get_follows.dart';
import 'api/get_user_info.dart';
import 'api/login.dart';
import 'api/get_forum.dart';
import 'api/get_homepage.dart';
import 'api/get_user_contents.dart';
import 'api/get_user_forum_info.dart';
import 'api/get_fid.dart';
import 'api/get_images.dart';
import 'api/get_last_replyers.dart';
import 'api/get_replies.dart';
import 'api/get_self_follow_forums.dart';
import 'api/get_posts.dart';
import 'api/get_threads.dart';
import 'api/user_extra.dart';
import 'api/search_global.dart';
import 'api/rank_forums.dart';
import 'api/rank_member_users.dart';
import 'api/rank_users.dart';
import 'api/search_in_forum.dart';
import 'api/uinfo_app.dart';
import 'api/uinfo_card.dart';
import 'api/uinfo_json.dart';
import 'api/uinfo_panel.dart';
import 'api/uinfo_self.dart';
import 'api/uinfo_web.dart';
import 'api/user_contents_pc.dart';
import 'api/user_contents_pc_follow_forums.dart';
import 'api/user_contents_posts.dart';
import 'api/write_ops.dart' as ops;
import 'core/account.dart';
import 'core/config.dart';
import 'core/enums.dart';
import 'core/cache.dart';
import 'core/constants.dart';
import 'core/exceptions.dart';
import 'core/http_core.dart';
import 'core/utils.dart';
import 'models/comment.dart';
import 'models/bawu_blacklist.dart';
import 'models/bawu_block.dart';
import 'models/bawu_enums.dart';
import 'models/bawu_info.dart';
import 'models/bawu_member.dart';
import 'models/bawu_perm.dart';
import 'models/bawu_postlog.dart';
import 'models/bawu_userlog.dart';
import 'models/follow.dart';
import 'models/homepage.dart';
import 'models/last_replyers.dart';
import 'models/forum.dart';
import 'models/forum_detail.dart';
import 'models/notification.dart';
import 'models/post.dart';
import 'models/search.dart';
import 'models/self_forums.dart';
import 'models/thread.dart';
import 'models/user.dart';
import 'models/user_extra.dart';
import 'models/rank_forums.dart';
import 'models/recover_info.dart';
import 'models/recover_list.dart';
import 'models/rank_member_users.dart';
import 'models/rank_users.dart';
import 'models/uinfo_app.dart';
import 'models/uinfo_card.dart';
import 'models/uinfo_json.dart';
import 'models/uinfo_panel.dart';
import 'models/uinfo_self.dart';
import 'models/uinfo_web.dart';
import 'models/user_contents_pc.dart';
import 'models/user_contents_pc_follow_forums.dart';
import 'models/user_contents_posts.dart';
import 'models/user_forum_info.dart';

/// A Dart port of aiotieba's Client, limited to the APIs this app needs.
class TiebaClient {
  TiebaClient({TiebaAccount? account, TiebaConfig? config, Dio? dio})
    : account = account ?? TiebaAccount() {
    _http = TiebaHttpCore(account: this.account, config: config, dio: dio);
  }

  final TiebaAccount account;
  late final TiebaHttpCore _http;

  TiebaHttpCore get http => _http;

  TiebaChatClient? _chat;

  /// Lazily-created chat/IM client that shares this account and HTTP core.
  TiebaChatClient get chat => _chat ??= TiebaChatClient(http: _http);

  /// Creates a chat client with custom BLCP/websocket settings.
  TiebaChatClient createChatClient({
    BlcpConfig blcpConfig = const BlcpConfig(),
    WsConfig wsConfig = const WsConfig(),
    String? clientVersion,
  }) {
    return TiebaChatClient(
      http: _http,
      blcpConfig: blcpConfig,
      wsConfig: wsConfig,
      clientVersion: clientVersion ?? chatVersion,
    );
  }

  Future<TiebaForum> getForum(String fname) => fetchForum(_http, fname);

  Future<TiebaThreads> getThreads(
    String fname, {
    int pn = 1,
    int rn = 30,
    ThreadSortType sort = ThreadSortType.reply,
    bool isGood = false,
  }) {
    return fetchThreads(
      _http,
      fname: fname,
      pn: pn,
      rn: rn,
      sort: sort,
      isGood: isGood,
    );
  }

  Future<TiebaPosts> getPosts(
    int tid, {
    int pn = 1,
    int rn = 30,
    PostSortType sort = PostSortType.asc,
    bool onlyThreadAuthor = false,
    bool withComments = false,
    bool commentSortByAgree = true,
    int commentRn = 4,
  }) {
    return fetchPosts(
      _http,
      tid: tid,
      pn: pn,
      rn: rn,
      sort: sort,
      onlyThreadAuthor: onlyThreadAuthor,
      withComments: withComments,
      commentSortByAgree: commentSortByAgree,
      commentRn: commentRn,
    );
  }

  Future<TiebaComments> getComments(
    int tid,
    int pid, {
    int pn = 1,
    bool isComment = false,
    CommentSortType sort = CommentSortType.asc,
  }) {
    return fetchComments(
      _http,
      tid: tid,
      pid: pid,
      pn: pn,
      isComment: isComment,
      sort: sort,
    );
  }

  Future<TiebaFollows> getFollows(int userId, {int pn = 1}) =>
      fetchFollows(_http, userId: userId, pn: pn);

  Future<TiebaFans> getFans(int userId, {int pn = 1}) =>
      fetchFans(_http, userId: userId, pn: pn);

  Future<TiebaBlacklist> getBlacklist() => fetchBlacklist(_http);

  Future<TiebaFollowForums> getFollowForums(
    int userId, {
    int pn = 1,
    int rn = 20,
  }) => fetchFollowForums(_http, userId: userId, pn: pn, rn: rn);

  Future<TiebaSelfFollowForums> getSelfFollowForums() =>
      fetchSelfFollowForums(_http);

  Future<TiebaSearchInForums> searchInForum(
    String fname,
    String query, {
    int pn = 1,
    int rn = 20,
    SearchInForumType type = SearchInForumType.all,
    bool onlyThread = false,
  }) => fetchSearchInForum(
    _http,
    fname: fname,
    query: query,
    pn: pn,
    rn: rn,
    type: type,
    onlyThread: onlyThread,
  );

  Future<TiebaSearchGlobals> searchGlobal(
    String query, {
    int pn = 1,
    int rn = 20,
    SearchGlobalType sort = SearchGlobalType.desc,
  }) => fetchSearchGlobal(_http, query: query, pn: pn, rn: rn, sort: sort);

  Future<TiebaUser?> getUserInfo({int? userId, String? portrait}) =>
      fetchUserInfo(_http, userId: userId, portrait: portrait);

  Future<TiebaLoginInfo> login() => fetchLogin(_http);

  TiebaUser? _selfUser;

  /// Logs in if necessary and returns the current account's profile.
  Future<TiebaUser> getSelfInfo({bool refresh = false}) async {
    if (!refresh && _selfUser != null) return _selfUser!;
    final info = await login();
    final user = await fetchUserInfo(_http, userId: info.userId);
    if (user == null) {
      throw const TiebaFormatException('self profile is empty');
    }
    _selfUser = user;
    return user;
  }

  Future<void> _ensureTbs() async {
    if (account.tbs == null || account.tbs!.isEmpty) {
      await login();
    }
  }

  Future<void> agree(int tid, {int pid = 0, bool isComment = false}) async {
    await _ensureTbs();
    await ops.setAgree(_http, tid: tid, pid: pid, isComment: isComment);
  }

  Future<void> unagree(int tid, {int pid = 0, bool isComment = false}) async {
    await _ensureTbs();
    await ops.setAgree(
      _http,
      tid: tid,
      pid: pid,
      isComment: isComment,
      isUndo: true,
    );
  }

  Future<void> disagree(int tid, {int pid = 0, bool isComment = false}) async {
    await _ensureTbs();
    await ops.setAgree(
      _http,
      tid: tid,
      pid: pid,
      isComment: isComment,
      isDisagree: true,
    );
  }

  Future<void> undisagree(
    int tid, {
    int pid = 0,
    bool isComment = false,
  }) async {
    await _ensureTbs();
    await ops.setAgree(
      _http,
      tid: tid,
      pid: pid,
      isComment: isComment,
      isDisagree: true,
      isUndo: true,
    );
  }

  Future<void> signForum(String fname) async {
    await _ensureTbs();
    await ops.signForum(_http, fname);
  }

  Future<void> signForums() async {
    await _ensureTbs();
    await ops.signForums(_http);
  }

  Future<void> signGrowth() async {
    await _ensureTbs();
    await ops.signGrowth(_http);
  }

  Future<void> followForum(int fid) async {
    await _ensureTbs();
    await ops.followForum(_http, fid);
  }

  Future<void> unfollowForum(int fid) async {
    await _ensureTbs();
    await ops.unfollowForum(_http, fid);
  }

  Future<void> followUser(String portrait) async {
    await _ensureTbs();
    await ops.followUser(_http, portrait);
  }

  Future<void> unfollowUser(String portrait) async {
    await _ensureTbs();
    await ops.unfollowUser(_http, portrait);
  }

  Future<void> removeFan(int userId) async {
    await _ensureTbs();
    await ops.removeFan(_http, userId);
  }

  Future<void> delPost({
    required int fid,
    required int tid,
    required int pid,
  }) async {
    await _ensureTbs();
    await ops.deletePost(_http, fid: fid, tid: tid, pid: pid);
  }

  Future<void> delThread({
    required int fid,
    required int tid,
    bool isHide = false,
  }) async {
    await _ensureTbs();
    await ops.deleteThread(_http, fid: fid, tid: tid, isHide: isHide);
  }

  Future<void> delPosts({
    required int fid,
    required int tid,
    required Iterable<int> pids,
    bool isHide = false,
  }) async {
    await _ensureTbs();
    await ops.deletePosts(
      _http,
      fid: fid,
      tid: tid,
      pids: pids,
      isHide: isHide,
    );
  }

  Future<void> delThreads({
    required int fid,
    required Iterable<int> tids,
    bool isHide = false,
  }) async {
    await _ensureTbs();
    await ops.deleteThreads(_http, fid: fid, tids: tids, isHide: isHide);
  }

  Future<void> block({
    required int fid,
    required String portrait,
    required int day,
    String reason = '',
  }) async {
    await _ensureTbs();
    await ops.blockUser(
      _http,
      fid: fid,
      portrait: portrait,
      day: day,
      reason: reason,
    );
  }

  Future<void> unblock({required int fid, required int userId}) async {
    await _ensureTbs();
    await ops.unblockUser(_http, fid: fid, userId: userId);
  }

  Future<void> setProfile({
    required String nickName,
    String sign = '',
    Gender gender = Gender.unknown,
  }) async {
    await ops.setProfile(_http, nickName: nickName, sign: sign, gender: gender);
  }

  Future<void> setThreadPrivate({
    required int fid,
    required int tid,
    required int pid,
  }) async {
    await ops.setThreadPrivacy(
      _http,
      fid: fid,
      tid: tid,
      pid: pid,
      isHide: true,
    );
  }

  Future<void> setThreadPublic({
    required int fid,
    required int tid,
    required int pid,
  }) async {
    await ops.setThreadPrivacy(
      _http,
      fid: fid,
      tid: tid,
      pid: pid,
      isHide: false,
    );
  }

  Future<void> setNicknameOld(String nickName) async {
    await ops.setNicknameOld(_http, nickName);
  }

  Future<void> addUserBlacklist(int userId) async {
    await ops.setBlacklist(
      _http,
      userId: userId,
      follow: true,
      interact: true,
      chat: true,
    );
  }

  Future<void> removeUserBlacklist(int userId) async {
    await ops.setBlacklist(
      _http,
      userId: userId,
      follow: false,
      interact: false,
      chat: false,
    );
  }

  Future<void> vote(int tid, {required Iterable<int> options}) async {
    await ops.addPoll(_http, tid: tid, options: options);
  }

  Future<void> addBlacklist(int userId) async {
    await ops.addBlacklistOld(_http, userId);
  }

  Future<void> delBlacklist(int userId) async {
    await ops.deleteBlacklistOld(_http, userId);
  }

  Future<void> dislikeForum(int fid) async {
    await ops.dislikeForum(_http, fid);
  }

  Future<void> undislikeForum(int fid) async {
    await ops.undislikeForum(_http, fid);
  }

  Future<void> recommendThread({required int fid, required int tid}) async {
    await ops.recommendThread(_http, fid: fid, tid: tid);
  }

  Future<void> topThread({
    required String fname,
    required int fid,
    required int tid,
    bool isVip = false,
    bool isSet = true,
  }) async {
    await _ensureTbs();
    await ops.topThread(
      _http,
      fname: fname,
      fid: fid,
      tid: tid,
      isVip: isVip,
      isSet: isSet,
    );
  }

  Future<void> goodThread({
    required String fname,
    required int fid,
    required int tid,
    int cid = 0,
  }) async {
    await _ensureTbs();
    await ops.goodThread(_http, fname: fname, fid: fid, tid: tid, cid: cid);
  }

  Future<void> untopThread({
    required String fname,
    required int fid,
    required int tid,
  }) async {
    await _ensureTbs();
    await ops.topThread(_http, fname: fname, fid: fid, tid: tid, isSet: false);
  }

  Future<void> hideThread({
    required int fid,
    required int tid,
    required int pid,
  }) => setThreadPrivate(fid: fid, tid: tid, pid: pid);

  Future<void> unhideThread({
    required int fid,
    required int tid,
    required int pid,
  }) => setThreadPublic(fid: fid, tid: tid, pid: pid);

  Future<void> recoverThread({required int fid, required int tid}) =>
      recover(fid: fid, tid: tid);

  Future<void> recoverPost({
    required int fid,
    required int tid,
    required int pid,
  }) => recover(fid: fid, tid: tid, pid: pid);

  Future<void> ungoodThread({
    required String fname,
    required int fid,
    required int tid,
  }) async {
    await _ensureTbs();
    await ops.ungoodThread(_http, fname: fname, fid: fid, tid: tid);
  }

  Future<void> moveThread({
    required int fid,
    required int tid,
    required int toTabId,
    int fromTabId = 0,
  }) async {
    await _ensureTbs();
    await ops.moveThread(
      _http,
      fid: fid,
      tid: tid,
      toTabId: toTabId,
      fromTabId: fromTabId,
    );
  }

  Future<void> addBawu({
    required int fid,
    required String userName,
    BawuType bawuType = BawuType.manager,
  }) => bawu_team.addBawu(
    _http,
    fid: fid,
    userName: userName,
    bawuType: bawuType,
  );

  Future<void> delBawu({
    required int fid,
    required String portrait,
    BawuType bawuType = BawuType.manager,
  }) => bawu_team.delBawu(
    _http,
    fid: fid,
    portrait: portrait,
    bawuType: bawuType,
  );

  Future<BawuTeamInfo> getBawuInfo(int fid) =>
      bawu_team.fetchBawuInfo(_http, fid: fid);

  Future<BawuMemberList> getBawuMemberlist(
    String fname, {
    int pn = 1,
    String searchValue = '',
  }) => bawu_team.fetchBawuMemberlist(
    _http,
    fname: fname,
    pn: pn,
    searchValue: searchValue,
  );

  Future<void> addBawuBlacklist(String fname, int userId) =>
      bawu_blacklist_api.addBawuBlacklist(_http, fname: fname, userId: userId);

  Future<void> delBawuBlacklist(String fname, int userId) =>
      bawu_blacklist_api.delBawuBlacklist(_http, fname: fname, userId: userId);

  Future<BawuBlacklistUsers> getBawuBlacklist(String fname, {int pn = 1}) =>
      bawu_blacklist_api.fetchBawuBlacklist(_http, fname: fname, pn: pn);

  Future<BawuPerm> getBawuPerm({required int fid, required String portrait}) =>
      bawu_perm_api.fetchBawuPerm(_http, fid: fid, portrait: portrait);

  Future<void> setBawuPerm({
    required int fid,
    required String portrait,
    BawuPermType perms = BawuPermType.none,
  }) => bawu_perm_api.setBawuPerm(
    _http,
    fid: fid,
    portrait: portrait,
    perms: perms,
  );

  Future<BawuPostLogs> getBawuPostlogs(
    String fname, {
    int pn = 1,
    String searchValue = '',
    BawuSearchType searchType = BawuSearchType.user,
    DateTime? startTime,
    DateTime? endTime,
    int opType = 0,
  }) => bawu_logs_api.fetchBawuPostlogs(
    _http,
    fname: fname,
    pn: pn,
    searchValue: searchValue,
    searchType: searchType,
    startTime: startTime,
    endTime: endTime,
    opType: opType,
  );

  Future<BawuUserLogs> getBawuUserlogs(
    String fname, {
    int pn = 1,
    String searchValue = '',
    BawuSearchType searchType = BawuSearchType.user,
    DateTime? startTime,
    DateTime? endTime,
    int opType = 0,
  }) => bawu_logs_api.fetchBawuUserlogs(
    _http,
    fname: fname,
    pn: pn,
    searchValue: searchValue,
    searchType: searchType,
    startTime: startTime,
    endTime: endTime,
    opType: opType,
  );

  Future<BawuBlocks> getBlocks({
    required int fid,
    String name = '',
    int pn = 1,
  }) => bawu_block_api.fetchBlocks(_http, fid: fid, name: name, pn: pn);

  Future<BawuAppeals> getUnblockAppeals({
    required int fid,
    int pn = 1,
    int rn = 5,
  }) => bawu_block_api.fetchUnblockAppeals(_http, fid: fid, pn: pn, rn: rn);

  Future<void> handleUnblockAppeals({
    required int fid,
    required Iterable<int> appealIds,
    bool refuse = true,
  }) => bawu_block_api.handleUnblockAppeals(
    _http,
    fid: fid,
    appealIds: appealIds,
    refuse: refuse,
  );

  Future<TiebaRecovers> getRecovers({
    required int fid,
    int pn = 1,
    int rn = 10,
    int? userId,
  }) => recover_api.fetchRecovers(
    _http,
    fid: fid,
    pn: pn,
    rn: rn,
    userId: userId,
  );

  Future<TiebaRecoverInfo> getRecoverInfo({
    required int fid,
    required int tid,
    int pid = 0,
  }) => recover_api.fetchRecoverInfo(_http, fid: fid, tid: tid, pid: pid);

  Future<void> recover({
    required int fid,
    int tid = 0,
    int pid = 0,
    bool isHide = false,
  }) =>
      recover_api.recover(_http, fid: fid, tid: tid, pid: pid, isHide: isHide);

  Future<TiebaUser?> getUserInfoByName(String userName) async {
    final resolved = await fetchUserJson(_http, userName: userName);
    if (!resolved.isValid) return null;
    return fetchUserInfo(_http, userId: resolved.userId);
  }

  Future<TiebaForum> getForumByFid(int fid) async {
    final fname = await getFname(fid);
    return fetchForum(_http, fname);
  }

  Future<UserPostss> getSelfPosts({int pn = 1, int rn = 20}) async {
    if (account.userId == 0) await getSelfInfo();
    return fetchUserPosts(_http, userId: account.userId, pn: pn, rn: rn);
  }

  Future<List<HomepageThread>> getSelfThreads({
    int pn = 1,
    bool publicOnly = false,
  }) async {
    if (account.userId == 0) await getSelfInfo();
    return fetchUserThreads(
      _http,
      userId: account.userId,
      pn: pn,
      isSelf: true,
      publicOnly: publicOnly,
    );
  }

  Future<UserInfoWeb> getUserInfoWeb(int userId) =>
      fetchUserInfoWeb(_http, userId: userId);

  Future<UserInfoApp> getUserInfoApp(int userId) =>
      fetchUserInfoApp(_http, userId: userId);

  Future<UserInfoPanel> getUserPanel(String nameOrPortrait) =>
      fetchUserPanel(_http, nameOrPortrait: nameOrPortrait);

  Future<UserInfoCard> getUserCard(String portrait) =>
      fetchUserCard(_http, portrait: portrait);

  Future<UserInfoJson> getUserJson(String userName) =>
      fetchUserJson(_http, userName: userName);

  Future<UserInfoSelfInit> getSelfInitNickname() =>
      fetchSelfInitNickname(_http);

  Future<UserInfoMoindex> getSelfMoindex() => fetchSelfMoindex(_http);

  Future<UserPostss> getUserPosts(
    int userId, {
    int pn = 1,
    int rn = 20,
    String version = TiebaConstants.userPostsVersion,
  }) => fetchUserPosts(_http, userId: userId, pn: pn, rn: rn, version: version);

  Future<PcUserPosts> getPcUserPosts(
    String portrait, {
    int pn = 1,
    int rn = 20,
  }) => fetchPcUserPosts(_http, portrait: portrait, pn: pn, rn: rn);

  Future<PcFollowForums> getPcFollowForums(
    String portrait, {
    int pn = 1,
    int rn = 50,
  }) => fetchPcFollowForums(_http, portrait: portrait, pn: pn, rn: rn);

  Future<RankForums> getRankForums(
    String fname, {
    int pn = 1,
    RankForumType rankType = RankForumType.weekly,
  }) => fetchRankForums(_http, fname: fname, pn: pn, rankType: rankType);

  Future<RankUsers> getRankUsers(String fname, {int pn = 1}) =>
      fetchRankUsers(_http, fname: fname, pn: pn);

  Future<MemberUsers> getMemberUsers(String fname, {int pn = 1}) =>
      fetchMemberUsers(_http, fname: fname, pn: pn);

  Future<TiebaSyncResult> sync() => fetchSync(_http);

  Future<String?> initBaiduId() => fetchInitBaiduId(_http);

  Future<String> initZid() => fetchInitZid(_http);

  Future<int> getFid(String fname) => fetchFid(_http, fname);

  Future<String> getFname(int fid) async {
    final cached = ForumInfoCache.getFname(fid);
    if (cached != null) return cached;
    final detail = await fetchForumDetail(_http, fid);
    return detail.fname;
  }

  Future<TiebaLastReplyers> getLastReplyers(
    String fname, {
    int pn = 1,
    int rn = 30,
    int sort = 6,
    bool isGood = false,
  }) => fetchLastReplyers(
    _http,
    fname: fname,
    pn: pn,
    rn: rn,
    sort: sort,
    isGood: isGood,
  );

  Future<TiebaUserForumInfo> getUserForumInfo({
    required int fid,
    required String portrait,
  }) => fetchUserForumInfo(_http, fid: fid, portrait: portrait);

  Future<TiebaBlacklistOld> getBlacklistOld({int pn = 1, int rn = 10}) =>
      fetchBlacklistOld(_http, pn: pn, rn: rn);

  Future<TiebaDislikeForums> getDislikeForums({int pn = 1, int rn = 20}) =>
      fetchDislikeForums(_http, pn: pn, rn: rn);

  Future<TiebaUser?> getUserByTiebaUid(int tiebaUid) =>
      fetchUserByTiebaUid(_http, tiebaUid);

  Future<TiebaStatistics> getStatistics(int fid) => fetchStatistics(_http, fid);

  Future<TiebaForumDetail> getForumDetail(int fid) =>
      fetchForumDetail(_http, fid);

  Future<TiebaForumLevel> getForumLevel(int fid) => fetchForumLevel(_http, fid);

  Future<Map<String, int>> getTabMap(String fname) => fetchTabMap(_http, fname);

  Future<TiebaSquareForums> getSquareForums(
    String cname, {
    int pn = 1,
    int rn = 20,
  }) => fetchSquareForums(_http, cname: cname, pn: pn, rn: rn);

  Future<TiebaRecomStatus> getRecomStatus(int fid) =>
      fetchRecomStatus(_http, fid);

  Future<List<HomepageThread>> getUserThreads(
    int userId, {
    int pn = 1,
    bool isSelf = false,
    bool publicOnly = false,
  }) => fetchUserThreads(
    _http,
    userId: userId,
    pn: pn,
    isSelf: isSelf,
    publicOnly: publicOnly,
  );

  Future<TiebaHomepage> getHomepage(int userId, {int pn = 1}) =>
      fetchHomepage(_http, userId: userId, pn: pn);

  Future<TiebaAts> getAts({int pn = 1}) => fetchAts(_http, pn: pn);

  Future<TiebaReplies> getReplies({int pn = 1}) => fetchReplies(_http, pn: pn);

  /// Downloads an image from a Tieba/Baidu URL.
  Future<Uint8List> getImageBytes(Uri url) => fetchImageBytes(_http, url);

  /// Downloads an image URL (alias of getImageBytes).
  Future<Uint8List> getImage(Uri url) => getImageBytes(url);

  /// Downloads a user avatar by portrait.
  Future<Uint8List> getPortrait(String portrait, {String size = 's'}) =>
      getImageBytes(portraitUrl(portrait, size: size));

  /// Downloads a Baidu image-library asset by hash.
  Future<Uint8List> getHashImage(String hash, {String size = 's'}) =>
      getImageBytes(hash2ImageUrl(hash, size: size));

  /// Validates the current BDUSS and caches the anti-CSRF token.
  Future<TiebaSessionInfo?> getSession() async {
    final json = await _http.webGetJson(
      '/dc/common/tbs',
      referer: 'https://tieba.baidu.com/',
    );
    if (parseInt(json['is_login']) != 1) return null;
    final tbs = parseString(json['tbs']);
    account.tbs = tbs.isEmpty ? null : tbs;
    return TiebaSessionInfo(userName: parseString(json['user_name']), tbs: tbs);
  }

  Future<void> close() async {
    final chat = _chat;
    if (chat != null) {
      await chat.close();
    }
    _http.close();
  }
}

class TiebaSessionInfo {
  const TiebaSessionInfo({required this.userName, required this.tbs});

  final String userName;
  final String tbs;
}
