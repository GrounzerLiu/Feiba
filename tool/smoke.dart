// Live smoke test of the real data layer (network required).
// Usage: dart run tool/smoke.dart [forumName]
import 'dart:io';

import 'package:feiba/data/tieba_repository.dart';

Future<void> main(List<String> args) async {
  final kw = args.isNotEmpty ? args.first : '原神';
  final repo = TiebaRepository();

  stdout.writeln('>> forumPage(kw=$kw)');
  final forum = await repo.forumPage(kw);
  stdout.writeln('   forum=${forum.forum?.name} members=${forum.forum?.memberNum} '
      'threads=${forum.threads.length} hasMore=${forum.hasMore} users=${forum.users.length}');
  for (final t in forum.threads.take(3)) {
    stdout.writeln('   - [${t.isTop ? "顶" : "  "}${t.isGood ? "精" : "  "}] tid=${t.tid} '
        'reply=${t.replyNum} author=${forum.userOf(t.authorId)?.displayName ?? t.authorId}');
    stdout.writeln('     ${t.title}');
    stdout.writeln('     preview: ${t.preview.length > 50 ? t.preview.substring(0, 50) : t.preview}');
  }

  final first = forum.threads.firstWhere((t) => !t.isTop, orElse: () => forum.threads.first);
  stdout.writeln();
  stdout.writeln('>> threadPage(tid=${first.tid})');
  final thread = await repo.threadPage(first.tid);
  stdout.writeln('   title=${thread.title} posts=${thread.posts.length} '
      'hasMore=${thread.hasMore} users=${thread.users.length} totalPages=${thread.totalPage}');
  for (final p in thread.posts.take(4)) {
    final author = thread.userOf(p.authorId)?.displayName ?? '#${p.authorId}';
    final text = p.plainText.replaceAll('\n', ' ');
    stdout.writeln('   ${p.floor}楼 $author (赞${p.agreeNum}, 楼中楼${p.subPostNumber}): '
        '${text.length > 60 ? text.substring(0, 60) : text}');
  }
  final withImages = thread.posts.where((p) => p.content.any((n) => n.isImage)).length;
  final withSub = thread.posts.where((p) => p.subPosts.isNotEmpty).length;
  stdout.writeln('   posts_with_images=$withImages posts_with_subposts=$withSub');
}
