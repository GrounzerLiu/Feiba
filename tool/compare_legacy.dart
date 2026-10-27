// Compares the legacy JSON client with the aiotieba-derived protocol client.
// Usage: dart run tool/compare_legacy.dart [forum]
import 'dart:io';

import 'package:feiba/data/tieba_repository.dart' as legacy;
import 'package:feiba/protocol/tieba_protocol.dart' as v2;

Future<void> main(List<String> args) async {
  final fname = args.isNotEmpty ? args.first : '原神';
  final oldRepo = legacy.TiebaRepository();
  final client = v2.TiebaClient();
  try {
    final oldPage = await oldRepo.forumPage(fname);
    final newPage = await client.getThreads(fname, rn: 20);
    final oldTids = oldPage.threads.map((t) => t.tid).toSet();
    final newTids = newPage.objs.map((t) => t.tid).toSet();
    stdout.writeln('forum=$fname');
    stdout.writeln(
      '  legacy threads=${oldTids.length} hasMore=${oldPage.hasMore}',
    );
    stdout.writeln(
      '  port   threads=${newTids.length} hasMore=${newPage.hasMore}',
    );
    stdout.writeln('  tid overlap=${oldTids.intersection(newTids).length}');
    if (oldPage.threads.isNotEmpty && newPage.objs.isNotEmpty) {
      stdout.writeln(
        '  legacy first=${oldPage.threads.first.tid} "${oldPage.threads.first.title}"',
      );
      stdout.writeln(
        '  port   first=${newPage.objs.first.tid} "${newPage.objs.first.title}"',
      );
    }

    final tid = newPage.objs.isNotEmpty
        ? newPage.objs.first.tid
        : oldPage.threads.first.tid;
    final oldThread = await oldRepo.threadPage(tid);
    final newThread = await client.getPosts(tid, rn: 20);
    stdout.writeln('thread=$tid');
    stdout.writeln(
      '  legacy posts=${oldThread.posts.length} title="${oldThread.title}" hasMore=${oldThread.hasMore}',
    );
    stdout.writeln(
      '  port   posts=${newThread.objs.length} title="${newThread.thread.title}" hasMore=${newThread.hasMore}',
    );
    if (oldThread.posts.isNotEmpty && newThread.objs.isNotEmpty) {
      stdout.writeln(
        '  legacy first floor=${oldThread.posts.first.floor} chars=${oldThread.posts.first.plainText.length}',
      );
      stdout.writeln(
        '  port   first floor=${newThread.objs.first.floor} chars=${newThread.objs.first.contents.displayText.length}',
      );
    }
  } finally {
    await client.close();
  }
}
