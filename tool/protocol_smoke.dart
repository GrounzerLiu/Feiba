// Live smoke test for the Dart port of aiotieba.
// Usage: dart run tool/protocol_smoke.dart [forum]
import 'dart:io';

import 'package:feiba/protocol/tieba_protocol.dart';

Future<void> main(List<String> args) async {
  final fname = args.isNotEmpty ? args.first : '原神';
  final client = TiebaClient();
  try {
    await _step('getForum', () async {
      final forum = await client.getForum(fname);
      stdout.writeln(
        '   fid=${forum.fid} name=${forum.fname} members=${forum.memberNum} posts=${forum.postNum} admins=${forum.admins.length}',
      );
    });

    await _step('getFid', () async {
      final fid = await client.getFid(fname);
      stdout.writeln('   fid=$fid');
    });

    await _step('getThreads', () async {
      final threads = await client.getThreads(fname);
      stdout.writeln(
        '   threads=${threads.objs.length} forum=${threads.forum.fname} page=${threads.page.currentPage}/${threads.page.totalPage} hasMore=${threads.hasMore} tabs=${threads.tabMap.length}',
      );
      for (final thread in threads.objs.take(3)) {
        stdout.writeln(
          '   - tid=${thread.tid} title=${thread.title} replies=${thread.replyNum} images=${thread.contents.imgs.length} author=${thread.user?.displayName}',
        );
      }
    });

    final threads = await client.getThreads(fname, rn: 10);
    final first = threads.objs.firstWhere(
      (t) => !t.isTop,
      orElse: () => threads.objs.first,
    );

    await _step('getPosts', () async {
      final posts = await client.getPosts(first.tid);
      stdout.writeln(
        '   posts=${posts.objs.length} page=${posts.page.currentPage}/${posts.page.totalPage} hasMore=${posts.hasMore} title=${posts.thread.title}',
      );
      for (final post in posts.objs.take(2)) {
        stdout.writeln(
          '   - floor=${post.floor} author=${post.user?.displayName} text=${post.contents.displayText.length} chars imgs=${post.contents.imgs.length} comments=${post.comments.length}',
        );
      }
    });

    final posts = await client.getPosts(first.tid);
    TiebaPost? withComments;
    for (final post in posts.objs) {
      if (post.replyNum > 0) {
        withComments = post;
        break;
      }
    }
    if (withComments != null) {
      await _step('getComments', () async {
        final comments = await client.getComments(first.tid, withComments!.pid);
        stdout.writeln(
          '   comments=${comments.objs.length} page=${comments.page.currentPage}/${comments.page.totalPage} hasMore=${comments.hasMore}',
        );
      });
    }

    await _step('deep comments', () async {
      final deep = await client.getComments(11019283800, 153929230604);
      stdout.writeln(
        '   count=${deep.objs.length} page=${deep.page.currentPage}/${deep.page.totalPage} hasMore=${deep.hasMore} total=${deep.page.totalCount}',
      );
    });

    await _step('searchGlobal', () async {
      final result = await client.searchGlobal('原神 攻略', rn: 5);
      stdout.writeln(
        '   count=${result.objs.length} hasMore=${result.hasMore} page=${result.currentPage}',
      );
      for (final item in result.objs.take(2)) {
        stdout.writeln(
          '   - forum=${item.forumName} tid=${item.tid} title=${item.title}',
        );
      }
    });

    await _step('searchInForum', () async {
      final result = await client.searchInForum(fname, '攻略', rn: 5);
      stdout.writeln(
        '   count=${result.objs.length} hasMore=${result.hasMore} page=${result.page.currentPage}/${result.page.totalPage}',
      );
    });

    await _step('getUserInfo', () async {
      final user = await client.getUserInfo(userId: 2213840917);
      stdout.writeln(
        '   name=${user?.displayName} level=${user?.level} age=${user?.age} posts=${user?.postNum} agree=${user?.agreeNum} fans=${user?.fanNum} follows=${user?.followNum} tiebaUid=${user?.tiebaUid}',
      );
    });

    await _step('getHomepage', () async {
      final home = await client.getHomepage(2213840917);
      stdout.writeln(
        '   user=${home.user?.displayName} threads=${home.threads.length}',
      );
    });

    await _step('getUserThreads', () async {
      final list = await client.getUserThreads(2213840917, pn: 1);
      stdout.writeln(
        '   threads=${list.length} first=${list.isEmpty ? null : list.first.title}',
      );
    });

    await _step('getForumDetail', () async {
      final detail = await client.getForumDetail(threads.forum.fid);
      stdout.writeln(
        '   fid=${detail.fid} name=${detail.fname} category=${detail.category} members=${detail.memberNum} slogan=${detail.slogan} hasBawu=${detail.hasBawu}',
      );
    });

    await _step('getTabMap', () async {
      final tabs = await client.getTabMap(fname);
      stdout.writeln(
        '   tabs=${tabs.length} first=${tabs.entries.take(3).toList()}',
      );
    });

    await _step('getFollows', () async {
      final uid = first.user?.userId ?? 0;
      final follows = await client.getFollows(uid, pn: 1);
      stdout.writeln(
        '   uid=$uid follows=${follows.objs.length} hasMore=${follows.hasMore} total=${follows.page.totalCount}',
      );
    });

    await _step('rank / member list', () async {
      final forums = await client.getRankForums(fname);
      final users = await client.getRankUsers(fname);
      final members = await client.getMemberUsers(fname);
      stdout.writeln(
        '   rankForums=${forums.objs.length} first=${forums.objs.isEmpty ? '-' : forums.objs.first.fname} '
        'rankUsers=${users.objs.length} first=${users.objs.isEmpty ? '-' : users.objs.first.userName} '
        'members=${members.objs.length} first=${members.objs.isEmpty ? '-' : members.objs.first.userName}',
      );
    });

    await _step('fans', () async {
      final fans = await client.getFans(2213840917);
      stdout.writeln(
        '   fans=${fans.objs.length} page=${fans.page.currentPage} total=${fans.page.totalCount} hasMore=${fans.hasMore}',
      );
    });

    await _step('image download', () async {
      final url = threads.objs
          .expand((t) => t.contents.imgs)
          .map((i) => i.imageUrl)
          .firstWhere((u) => u.isNotEmpty, orElse: () => '');
      if (url.isEmpty) {
        stdout.writeln('   skipped (no image)');
        return;
      }
      final bytes = await client.getImageBytes(Uri.parse(url));
      stdout.writeln('   bytes=${bytes.length} url=$url');
    });

    await _step('crypto', () async {
      stdout.writeln('   cuid=${cuidGalaxy2('0123456789abcdef')}');
      stdout.writeln(
        '   c3=${c3Aid('0123456789abcdef', '12345678-1234-4234-8234-123456789012')}',
      );
    });
  } finally {
    await client.close();
  }
}

Future<void> _step(String name, Future<void> Function() action) async {
  stdout.writeln('>> $name');
  try {
    await action();
  } catch (error, stack) {
    stdout.writeln('   FAILED: $error');
    if (stack.toString().length < 500) stdout.writeln(stack);
  }
}
