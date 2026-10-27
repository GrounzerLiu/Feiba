import '../core/constants.dart';
import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/contents.dart';
import '../models/notification.dart';
import '../models/user.dart';
import '_common.dart';

Future<TiebaReplies> fetchReplies(TiebaHttpCore http, {int pn = 1}) async {
  final request = pb.ReplyMeReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(
    version: TiebaConstants.latestVersion,
    bduss: http.account.bduss,
  );
  data.pn = pn;

  final bytes = await http.postProto(
    '/c/u/feed/replyme',
    303007,
    request.writeToBuffer(),
  );
  final response = pb.ReplyMeResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }

  final replies = <TiebaReply>[];
  for (final item in response.data.replyList) {
    final contents = item.newFloorInfo.isEmpty
        ? Contents.empty()
        : Contents.fromContentList(item.newFloorInfo.last.content);
    replies.add(
      TiebaReply(
        tid: item.threadId.toInt(),
        pid: item.postId.toInt(),
        fname: item.fname,
        contents: contents,
        plainContent: item.content,
        user: TiebaUser.fromProtoOrNull(item.replyer),
        quoteUser: TiebaUser.fromProtoOrNull(item.quoteUser),
        quotePid: item.quotePid.toInt(),
        quoteContent: item.quoteContent,
        contentType: item.isFloor != 0 ? ContentType.comment : ContentType.post,
        createTime: item.time,
      ),
    );
  }

  return TiebaReplies(
    objs: replies,
    page: NotificationPage.fromProto(response.data.page),
  );
}
