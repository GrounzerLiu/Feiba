import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/tieba_protocol.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

pb.User user(int id, {String name = 'user', String nick = 'nick'}) {
  return pb.User()
    ..id = Int64(id)
    ..name = name
    ..nameShow = nick
    ..portrait = 'tb.1.abc?t=123';
}

pb.PbContent textContent(String text) => pb.PbContent()
  ..type = 0
  ..text = text;

pb.PbContent imageContent(String cdn) => pb.PbContent()
  ..type = 3
  ..cdnSrc = cdn
  ..bsize = '100,200';

pb.ThreadInfo threadInfo() {
  final thread = pb.ThreadInfo()
    ..id = Int64(123)
    ..title = 'thread title'
    ..fid = Int64(1)
    ..fname = 'bar'
    ..replyNum = 5
    ..viewNum = 7
    ..createTime = 1700000000
    ..lastTimeInt = 1700000100
    ..authorId = Int64(7)
    ..author = user(7, name: 'author', nick: 'AuthorNick')
    ..agree = (pb.Agree()
      ..agreeNum = Int64(3)
      ..disagreeNum = Int64(1));
  thread.firstPostContent.addAll(<pb.PbContent>[
    textContent('hello '),
    pb.PbContent()
      ..type = 2
      ..text = 'image_emoticon25'
      ..c = 'smile',
    imageContent(
      'https://tiebapic.baidu.com/forum/a/0123456789abcdef0123456789abcdef.jpg',
    ),
  ]);
  return thread;
}

pb.Page page({
  int current = 1,
  int total = 1,
  int size = 30,
  int hasMore = 0,
  int count = 0,
}) {
  return pb.Page()
    ..pageSize = size
    ..currentPage = current
    ..totalPage = total
    ..totalCount = count
    ..hasMore = hasMore;
}

void main() {
  group('Contents', () {
    test('parses text, emoji and image fragments from a thread', () {
      final contents = Contents.fromThread(threadInfo());
      expect(contents.text, 'hello ');
      expect(contents.emojis.single.id, 'image_emoticon25');
      expect(contents.emojis.single.desc, 'smile');
      expect(contents.imgs.single.showWidth, 100);
      expect(contents.imgs.single.showHeight, 200);
      expect(contents.imgs.single.hash, '0123456789abcdef0123456789abcdef');
      expect(contents.displayText, contains('[图片]'));
      expect(contents.displayText, contains('[表情]'));
    });

    test('keeps mentions in thread contents', () {
      final info = threadInfo();
      info.firstPostContent.insert(
        0,
        pb.PbContent()
          ..type = 4
          ..text = '@someone'
          ..uid = Int64(42)
          ..portrait = 'tb.1.abc?t=1',
      );
      final contents = Contents.fromThread(info);
      expect(contents.ats.single.userId, 42);
      expect(contents.ats.single.portrait, 'tb.1.abc');
    });

    test('parses link, mention, video and voice fragments from a post', () {
      final post = pb.Post()
        ..id = Int64(1)
        ..authorId = Int64(7)
        ..author = user(7);
      post.content.addAll(<pb.PbContent>[
        textContent('lead '),
        pb.PbContent()
          ..type = 4
          ..text = '@someone'
          ..uid = Int64(42)
          ..portrait = 'tb.1.abc?t=1',
        pb.PbContent()
          ..type = 1
          ..link = 'https://example.com/a'
          ..text = 'Example',
        pb.PbContent()
          ..type = 5
          ..link = 'https://example.com/video.mp4'
          ..src = 'https://example.com/cover.jpg'
          ..duringTime = 12
          ..width = 640
          ..height = 360
          ..count = 9,
        pb.PbContent()
          ..type = 10
          ..voiceMd5 = 'voice-md5'
          ..duringTime = 3000,
      ]);
      final contents = Contents.fromPost(post);
      // aiotieba removes the leading mention and the first fragment of posts.
      expect(contents.ats, isEmpty);
      expect(contents.links.single.title, 'Example');
      expect(contents.links.single.uri.toString(), 'https://example.com/a');
      expect(contents.video?.width, 640);
      expect(contents.video?.duration, 12);
      expect(contents.voice?.duration, 3);
      expect(contents.displayText, contains('[视频]'));
      expect(contents.displayText, contains('[语音]'));
    });
  });

  group('TiebaThreads', () {
    test('normalizes page 0 to page 1 and fills users', () {
      final data = pb.FrsPageResIdl_DataRes()
        ..page = page(current: 0, total: 3, hasMore: 1)
        ..forum = (pb.FrsPageResIdl_DataRes_ForumInfo()
          ..id = Int64(1)
          ..name = 'bar')
        ..threadList.add(threadInfo())
        ..userList.add(user(7, name: 'author', nick: 'AuthorNick'));
      final threads = TiebaThreads.fromProto(data);
      expect(threads.objs, hasLength(1));
      expect(threads.page.currentPage, 1);
      expect(threads.hasMore, isTrue);
      expect(threads.objs.single.fname, 'bar');
      expect(threads.objs.single.user?.displayName, 'AuthorNick');
      expect(threads.objs.single.agree, 3);
    });
  });

  group('TiebaComments', () {
    test('computes hasMore from total pages and strips reply prefix', () {
      final comment = pb.SubPostList()
        ..id = Int64(9)
        ..authorId = Int64(8)
        ..author = user(8, name: 'commenter', nick: 'Commenter')
        ..floor = 2
        ..time = 1700000200
        ..agree = (pb.Agree()..agreeNum = Int64(2));
      comment.content.addAll(<pb.PbContent>[
        textContent('回复 '),
        pb.PbContent()
          ..type = 4
          ..text = '@target'
          ..uid = Int64(7),
        textContent(' :hello'),
      ]);
      final data = pb.PbFloorResIdl_DataRes()
        ..page = page(current: 1, total: 2, hasMore: 0, count: 45)
        ..thread = threadInfo()
        ..post = (pb.Post()
          ..id = Int64(55)
          ..floor = 2
          ..authorId = Int64(7)
          ..author = user(7))
        ..forum = (pb.SimpleForum()
          ..id = Int64(1)
          ..name = 'bar')
        ..subpostList.add(comment);
      final comments = TiebaComments.fromProto(data);
      expect(comments.objs, hasLength(1));
      expect(comments.hasMore, isTrue);
      expect(comments.objs.single.replyToId, 7);
      expect(comments.objs.single.text, 'hello');
      expect(comments.objs.single.tid, 123);
      expect(comments.objs.single.ppid, 55);
      expect(comments.objs.single.user?.displayName, 'Commenter');
    });
  });

  group('TiebaPosts', () {
    test('fills thread, forum, users and nested comments', () {
      final comment = pb.SubPostList()
        ..id = Int64(9)
        ..authorId = Int64(8)
        ..author = user(8, name: 'commenter', nick: 'Commenter');
      comment.content.add(textContent('comment'));

      final post = pb.Post()
        ..id = Int64(55)
        ..floor = 2
        ..authorId = Int64(7)
        ..author = user(7, name: 'author', nick: 'AuthorNick')
        ..time = 1700000200
        ..agree = (pb.Agree()..agreeNum = Int64(4));
      post.content.add(textContent('post body'));
      post.ensureSubPostList().subPostList.add(comment);

      final data = pb.PbPageResIdl_DataRes()
        ..page = page(current: 1, total: 2, hasMore: 1)
        ..thread = threadInfo()
        ..forum = (pb.SimpleForum()
          ..id = Int64(1)
          ..name = 'bar')
        ..postList.add(post)
        ..userList.addAll(<pb.User>[
          user(7, name: 'author', nick: 'AuthorNick'),
          user(8, name: 'commenter', nick: 'Commenter'),
        ]);

      final posts = TiebaPosts.fromProto(data);
      expect(posts.objs, hasLength(1));
      expect(posts.hasMore, isTrue);
      expect(posts.thread.title, 'thread title');
      expect(posts.objs.single.text, 'post body');
      expect(posts.objs.single.user?.displayName, 'AuthorNick');
      expect(posts.objs.single.comments.single.text, 'comment');
      expect(posts.objs.single.comments.single.ppid, 55);
      expect(posts.objs.single.comments.single.floor, 2);
    });
  });
}
