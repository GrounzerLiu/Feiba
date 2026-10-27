import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/contents.dart';
import '../models/homepage.dart';
import '../models/user.dart';
import '_common.dart';

/// Fetches a page of threads published by a user.
Future<List<HomepageThread>> fetchUserThreads(
  TiebaHttpCore http, {
  required int userId,
  int pn = 1,
  bool isSelf = false,
  bool publicOnly = false,
}) async {
  final request = pb.UserPostReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: isSelf ? http.account.bduss : null,
  );
  data.uid = Int64(userId);
  data.isThread = 1;
  data.needContent = 1;
  data.pn = pn;
  data.isViewCard = (isSelf && publicOnly) ? 2 : 1;

  final bytes = await http.postProto(
    '/c/u/feed/userpost',
    303002,
    request.writeToBuffer(),
  );
  final response = pb.UserPostResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }

  return <HomepageThread>[
    for (final post in response.data.postList)
      HomepageThread(
        contents: post.firstPostContent.isEmpty
            ? Contents.empty()
            : Contents.fromContentList(post.firstPostContent),
        title: post.title,
        fid: post.forumId.toInt(),
        fname: post.forumName,
        tid: post.threadId.toInt(),
        pid: post.postId.toInt(),
        user: TiebaUser.brief(
          userId: post.userId.toInt(),
          userName: post.userName,
          nickName: post.nameShow,
          portrait: post.userPortrait,
        ),
        replyNum: post.replyNum,
        agreeNum: post.agree.agreeNum.toInt(),
        createTime: post.createTime,
      ),
  ];
}
