import 'dart:io';

import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/tieba_protocol.dart';
import 'package:flutter_test/flutter_test.dart';

Future<List<int>> _fixture(String name) =>
    File('test/fixtures/$name').readAsBytes();

void main() {
  test('threads fixture parses real FrsPageResIdl bytes', () async {
    final bytes = await _fixture('threads.bin');
    final response = pb.FrsPageResIdl.fromBuffer(bytes);
    expect(response.error.errorno, 0);
    final threads = TiebaThreads.fromProto(response.data);
    expect(threads.objs, hasLength(3));
    expect(threads.forum.fname, '原神');
    expect(threads.page.currentPage, 1);
    expect(threads.objs.first.tid, greaterThan(0));
    expect(threads.objs.first.title, isNotEmpty);
    expect(threads.objs.first.user, isNotNull);
  });

  test('posts fixture parses real PbPageResIdl bytes', () async {
    final bytes = await _fixture('posts.bin');
    final response = pb.PbPageResIdl.fromBuffer(bytes);
    expect(response.error.errorno, 0);
    final posts = TiebaPosts.fromProto(response.data);
    expect(posts.objs, isNotEmpty);
    expect(posts.page.currentPage, 1);
    expect(posts.thread.tid, greaterThan(0));
    expect(posts.objs.first.pid, greaterThan(0));
    expect(posts.objs.first.user, isNotNull);
  });

  test('comments fixture parses real PbFloorResIdl bytes', () async {
    final bytes = await _fixture('comments.bin');
    final response = pb.PbFloorResIdl.fromBuffer(bytes);
    expect(response.error.errorno, 0);
    final comments = TiebaComments.fromProto(response.data);
    expect(comments.post.pid, greaterThan(0));
    expect(comments.page.totalPage, greaterThanOrEqualTo(1));
    expect(comments.objs, isNotEmpty);
    expect(comments.objs.first.pid, greaterThan(0));
  });
}
