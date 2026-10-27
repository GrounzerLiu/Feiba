// Live smoke test of the real data layer (network required).
// Usage: dart run tool/smoke.dart [forumName]
import 'dart:io';

import 'package:feiba/data/tieba_repository.dart';

Future<void> main(List<String> args) async {
  final kw = args.isNotEmpty ? args.first : '原神';
  final repo = TiebaRepository();

  stdout.writeln('>> searchForums(word=$kw)');
  final found = await repo.searchForums(kw);
  stdout.writeln('   results=${found.length}');
  for (final f in found.take(3)) {
    stdout.writeln('   - id=${f.id} name=${f.displayName} 关注=${f.memberNumText} 贴=${f.postNumText}');
  }

  stdout.writeln();
  stdout.writeln('>> forumPage(kw=$kw)');
  final forum = await repo.forumPage(kw);
  stdout.writeln('   forum=${forum.forum?.name} members=${forum.forum?.memberNum} '
      'threads=${forum.threads.length} hasMore=${forum.hasMore} users=${forum.users.length}');
  for (final t in forum.threads.take(2)) {
    stdout.writeln('   - tid=${t.tid} reply=${t.replyNum} author=${forum.userOf(t.authorId)?.displayName ?? t.authorId}');
    stdout.writeln('     ${t.title}');
  }

  final first = forum.threads.firstWhere((t) => !t.isTop, orElse: () => forum.threads.first);
  stdout.writeln();
  stdout.writeln('>> threadPage(tid=${first.tid})');
  final thread = await repo.threadPage(first.tid);
  stdout.writeln('   title=${thread.title} posts=${thread.posts.length} users=${thread.users.length}');
  for (final p in thread.posts.take(3)) {
    final author = thread.userOf(p.authorId)?.displayName ?? '#${p.authorId}';
    final text = p.plainText.replaceAll('\n', ' ');
    stdout.writeln('   ${p.floor}楼 $author: ${text.length > 50 ? text.substring(0, 50) : text}');
  }
  final images = thread.posts.expand((p) => p.content).where((n) => n.isImage).length;
  stdout.writeln('   image_nodes=$images');
}
