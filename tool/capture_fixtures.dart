// Captures small real protobuf fixtures for offline tests.
// Usage: dart run tool/capture_fixtures.dart
import 'dart:io';

import 'package:feiba/protocol/core/account.dart';
import 'package:feiba/protocol/core/constants.dart';
import 'package:feiba/protocol/core/http_core.dart';
import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:fixnum/fixnum.dart';

Future<void> main() async {
  final http = TiebaHttpCore(account: TiebaAccount());
  final dir = Directory('test/fixtures');
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final threadRequest = pb.FrsPageReqIdl();
  final threadData = threadRequest.ensureData();
  threadData.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = TiebaConstants.legacyVersion;
  threadData.kw = '原神';
  threadData.pn = 0;
  threadData.rn = 3;
  threadData.rnNeed = 8;
  threadData.sortType = 6;
  final threadBytes = await http.postProto(
    '/c/f/frs/page',
    301001,
    threadRequest.writeToBuffer(),
  );
  await File('test/fixtures/threads.bin').writeAsBytes(threadBytes);
  final threadResponse = pb.FrsPageResIdl.fromBuffer(threadBytes);
  final tid = threadResponse.data.threadList.first.id.toInt();

  final postRequest = pb.PbPageReqIdl();
  final postData = postRequest.ensureData();
  postData.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = TiebaConstants.legacyVersion;
  postData.kz = Int64(tid);
  postData.pn = 1;
  postData.rn = 5;
  postData.r = 0;
  final postBytes = await http.postProto(
    '/c/f/pb/page',
    302001,
    postRequest.writeToBuffer(),
  );
  await File('test/fixtures/posts.bin').writeAsBytes(postBytes);

  int? pid;
  for (final post in pb.PbPageResIdl.fromBuffer(postBytes).data.postList) {
    if (post.subPostNumber > 0) {
      pid = post.id.toInt();
      break;
    }
  }
  pid ??= pb.PbPageResIdl.fromBuffer(postBytes).data.postList.first.id.toInt();

  final commentRequest = pb.PbFloorReqIdl();
  final commentData = commentRequest.ensureData();
  commentData.common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = TiebaConstants.latestVersion;
  commentData.kz = Int64(tid);
  commentData.pid = Int64(pid);
  commentData.pn = 1;
  final commentBytes = await http.postProto(
    '/c/f/pb/floor',
    302002,
    commentRequest.writeToBuffer(),
  );
  await File('test/fixtures/comments.bin').writeAsBytes(commentBytes);

  stdout.writeln(
    'threads=${File('test/fixtures/threads.bin').lengthSync()} bytes',
  );
  stdout.writeln('posts=${File('test/fixtures/posts.bin').lengthSync()} bytes');
  stdout.writeln(
    'comments=${File('test/fixtures/comments.bin').lengthSync()} bytes',
  );
  stdout.writeln('tid=$tid pid=$pid');
  http.close();
}
