import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/contents.dart';
import '../models/homepage.dart';
import '../models/thread.dart';
import 'get_user_info.dart';
import '_common.dart';

/// Fetches a user's profile and recent threads.
Future<TiebaHomepage> fetchHomepage(
  TiebaHttpCore http, {
  required int userId,
  int pn = 1,
}) async {
  final request = pb.ProfileReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.uid = Int64(userId);
  data.needPostCount = 1;
  data.pn = pn;

  final bytes = await http.postProto(
    '/c/u/user/profile',
    303012,
    request.writeToBuffer(),
  );
  final response = pb.ProfileResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }

  final user = parseProfileUser(response.data);
  final threads = <HomepageThread>[];
  for (final post in response.data.postList) {
    final contents = post.firstPostContent.isEmpty
        ? Contents.empty()
        : Contents.fromSummary(
            post.firstPostContent,
            media: post.media,
            videoInfo: post.videoInfo,
            voiceInfo: post.voiceInfo,
          );
    threads.add(
      HomepageThread(
        contents: contents,
        title: post.title,
        fid: post.forumId.toInt(),
        fname: post.forumName,
        tid: post.threadId.toInt(),
        pid: post.postId.toInt(),
        user: user,
        replyNum: post.replyNum,
        agreeNum: post.agree.agreeNum.toInt(),
        createTime: post.createTime,
        type: ThreadType.fromValue(post.threadType.toInt()),
        viewNum: post.freqNum,
        shareNum: post.shareNum,
        voteInfo: VoteInfo.fromProto(post.pollInfo),
      ),
    );
  }
  return TiebaHomepage(user: user, threads: threads);
}
