// Live smoke test of the real data layer (network required).
// Usage: dart run tool/smoke.dart [forumName]
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feiba/core/tieba_client.dart';
import 'package:feiba/data/tieba_repository.dart';

Future<void> main(List<String> args) async {
  final kw = args.isNotEmpty ? args.first : '原神';
  final repo = TiebaRepository();

  stdout.writeln('>> searchForums(word=$kw)');
  final found = await repo.searchForums(kw);
  stdout.writeln('   results=${found.length}');
  for (final f in found.take(3)) {
    stdout.writeln('   - id=${f.id} name=${f.displayName} 关注=${f.memberNumText}');
  }

  stdout.writeln();
  stdout.writeln('>> forumPage(kw=$kw)');
  final forum = await repo.forumPage(kw);
  stdout.writeln('   forum=${forum.forum?.name} threads=${forum.threads.length} '
      'hasMore=${forum.hasMore} users=${forum.users.length}');

  final first = forum.threads.firstWhere((t) => !t.isTop, orElse: () => forum.threads.first);
  stdout.writeln();
  stdout.writeln('>> threadPage(tid=${first.tid})');
  final thread = await repo.threadPage(first.tid);
  stdout.writeln('   title=${thread.title} posts=${thread.posts.length}');

  // sub posts (楼中楼)
  final withSub = <dynamic>[];
  for (final t in forum.threads.take(6)) {
    final data = t.tid == first.tid ? thread : await repo.threadPage(t.tid);
    for (final p in data.posts) {
      if (p.subPostNumber > 0) {
        withSub.add([t.tid, p]);
        break;
      }
    }
    if (withSub.isNotEmpty) break;
  }
  if (withSub.isNotEmpty) {
    final tid = withSub.first[0] as int;
    final post = withSub.first[1];
    final collected = <int, dynamic>{};
    var pn = 1;
    var page = await repo.subPosts(tid: tid, pid: post.id as int, pn: pn, rn: 20);
    stdout.writeln('>> subPosts(tid=$tid, pid=${post.id}) page1=${page.posts.length} '
        'total=${page.total} hasMore=${page.hasMore}');
    while (page.hasMore && pn < 10) {
      for (final s in page.posts) {
        collected[s.id] = s;
      }
      pn += 1;
      page = await repo.subPosts(tid: tid, pid: post.id as int, pn: pn, rn: 20);
    }
    for (final s in page.posts) {
      collected[s.id] = s;
    }
    stdout.writeln('   collected=${collected.length} pages=$pn (expect total=${page.total})');
    for (final s in collected.values.take(2)) {
      final text = (s.plainText as String).replaceAll('\n', ' ');
      stdout.writeln('   - ${s.authorName ?? s.authorId}: '
          '${text.length > 40 ? text.substring(0, 40) : text}');
    }
  }

  // image CDN reachability (same transport used by the save button)
  final imageNode = thread.posts
      .expand((p) => p.content)
      .where((n) => n.isImage && n.imageUrl != null)
      .toList();
  if (imageNode.isNotEmpty) {
    final url = imageNode.first.imageUrl!;
    final resp = await Dio().get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    stdout.writeln('>> image download: status=${resp.statusCode} '
        'bytes=${resp.data?.length ?? 0} host=${Uri.parse(url).host}');
  } else {
    stdout.writeln('>> image download: skipped (no image in this thread)');
  }

  stdout.writeln('>> protocol: sign=${tiebaSign(<String, String>{'a': '1'})}');
}
