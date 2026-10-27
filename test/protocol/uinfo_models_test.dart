import 'package:feiba/protocol/core/enums.dart';
import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/models/rank_forums.dart';
import 'package:feiba/protocol/models/rank_member_users.dart';
import 'package:feiba/protocol/models/rank_users.dart';
import 'package:feiba/protocol/models/uinfo_app.dart';
import 'package:feiba/protocol/models/uinfo_card.dart';
import 'package:feiba/protocol/models/uinfo_common.dart';
import 'package:feiba/protocol/models/uinfo_json.dart';
import 'package:feiba/protocol/models/uinfo_panel.dart';
import 'package:feiba/protocol/models/uinfo_self.dart';
import 'package:feiba/protocol/models/uinfo_web.dart';
import 'package:feiba/protocol/models/user_contents_pc.dart';
import 'package:feiba/protocol/models/user_contents_pc_follow_forums.dart';
import 'package:feiba/protocol/models/user_contents_posts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('user info JSON models', () {
    test('web user info blanks the numeric user name', () {
      final user = UserInfoWeb.fromJson(<String, dynamic>{
        'uid': 5,
        'uname': '5',
        'portrait': 'tb.1.abc',
        'show_nickname': '昵称',
      });

      expect(user.userId, 5);
      expect(user.userName, isEmpty);
      expect(user.nickName, '昵称');
      expect(user.showName, '昵称');
      expect(user.isValid, isTrue);
      expect(user.logName, '昵称/tb.1.abc');
    });

    test('app user info parses the protobuf user block', () {
      final proto = pb.User()
        ..id = Int64(42)
        ..portrait = 'tb.zz?t=1'
        ..name = 'user'
        ..nameShow = '旧昵称'
        ..sex = 2
        ..isMem = 1;

      final user = UserInfoApp.fromProto(proto);

      expect(user.userId, 42);
      expect(user.portrait, 'tb.zz');
      expect(user.userName, 'user');
      expect(user.nickName, '旧昵称');
      expect(user.gender, Gender.female);
      expect(user.isVip, isTrue);
    });

    test('panel user info humanizes counters and vip state', () {
      final endTime = DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600;
      final user = UserInfoPanel.fromJson(<String, dynamic>{
        'portrait': 'tb.1.abc?t=1',
        'name': 'user',
        'show_nickname': '昵称',
        'name_show': '旧昵称',
        'sex': 'female',
        'tb_age': '2.5',
        'post_num': '1.2万',
        'followed_count': '3',
        'vipInfo': <String, dynamic>{'v_status': 1, 'e_time': endTime},
      });

      expect(user.portrait, 'tb.1.abc');
      expect(user.gender, Gender.female);
      expect(user.age, 2.5);
      expect(user.postNum, 12000);
      expect(user.fanNum, 3);
      expect(user.isVip, isTrue);
      expect(user.showName, '昵称');
    });

    test('panel user info keeps a missing account age at zero', () {
      final user = UserInfoPanel.fromJson(<String, dynamic>{
        'portrait': 'tb.1.abc',
        'sex': 'unknown',
        'tb_age': '-',
        'post_num': 4,
        'followed_count': 5,
      });

      expect(user.age, 0);
      expect(user.gender, Gender.unknown);
      expect(user.isVip, isFalse);
      expect(user.postNum, 4);
    });

    test('user card parses profile counters', () {
      final user = UserInfoCard.fromJson(<String, dynamic>{
        'portrait': 'tb.9.abc?t=2',
        'name_show': '昵称',
        'tieba_uid': '123',
        'sex': 1,
        'tb_age': '1.5',
        'total_agree_num': 10,
        'fans_num': 11,
        'concern_num': 12,
        'intro': 'sign',
        'ip_address': 'IP',
      });

      expect(user.portrait, 'tb.9.abc');
      expect(user.nickNameNew, '昵称');
      expect(user.tiebaUid, 123);
      expect(user.gender, Gender.male);
      expect(user.age, 1.5);
      expect(user.agreeNum, 10);
      expect(user.fanNum, 11);
      expect(user.followNum, 12);
      expect(user.sign, 'sign');
      expect(user.ip, 'IP');
    });

    test('legacy user json resolves id and portrait', () {
      final user = UserInfoJson.fromJson(<String, dynamic>{
        'id': 8,
        'portrait': 'tb.8.abc',
      });

      expect(user.userId, 8);
      expect(user.portrait, 'tb.8.abc');
      expect(user.userName, isEmpty);
      expect(user.toString(), 'tb.8.abc');
    });

    test('self nickname info parses the id and names', () {
      final user = UserInfoSelfInit.fromJson(<String, dynamic>{
        'user_name': 'user',
        'name_show': '旧昵称',
        'tieba_uid': '99',
      });

      expect(user.userName, 'user');
      expect(user.nickName, '旧昵称');
      expect(user.tiebaUid, 99);
      expect(user.isValid, isTrue);
    });

    test('mobile index info parses counters and an expired vip', () {
      final endTime = DateTime.now().millisecondsSinceEpoch ~/ 1000 - 60;
      final user = UserInfoMoindex.fromJson(<String, dynamic>{
        'id': 7,
        'portrait': 'tb.7.abc',
        'name': 'user',
        'user_sex': 2,
        'post_num': 1,
        'fans_num': 2,
        'concern_num': 3,
        'like_forum_num': 4,
        'intro': 'sign',
        'vipInfo': <String, dynamic>{'v_status': 1, 'e_time': endTime},
      });

      expect(user.userId, 7);
      expect(user.gender, Gender.female);
      expect(user.postNum, 1);
      expect(user.fanNum, 2);
      expect(user.followNum, 3);
      expect(user.forumNum, 4);
      expect(user.sign, 'sign');
      expect(user.isVip, isFalse);
    });

    test('vip helper requires an active membership', () {
      final future = DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600;
      final past = DateTime.now().millisecondsSinceEpoch ~/ 1000 - 1;

      expect(vipInfoToBool(null), isFalse);
      expect(vipInfoToBool(<String, dynamic>{}), isFalse);
      expect(
        vipInfoToBool(<String, dynamic>{'v_status': 0, 'e_time': future}),
        isFalse,
      );
      expect(
        vipInfoToBool(<String, dynamic>{'v_status': 1, 'e_time': past}),
        isFalse,
      );
      expect(
        vipInfoToBool(<String, dynamic>{'v_status': 1, 'e_time': future}),
        isTrue,
      );
    });
  });

  group('user contents', () {
    test('reply page parses thread, author and fragments', () {
      final threadInfo = <String, dynamic>{
        'first_post_content': <Map<String, dynamic>>[
          <String, dynamic>{'type': 0, 'text': 'thread text'},
        ],
        'title': 'topic',
        'fid': 1,
        'fname': 'bar',
        'tid': 2,
        'first_post_id': 3,
        'author': <String, dynamic>{
          'id': 9,
          'portrait': 'tb.u?t=1',
          'name': 'author',
          'name_show': 'Author',
          'gender': 1,
        },
        'forum_info': <String, dynamic>{
          'id': 1,
          'name': 'bar',
          'member_num': 10,
          'post_num': 20,
          'is_liked': 1,
        },
        'thread_type': 0,
        'view_num': 5,
        'reply_num': 6,
        'share_num': 1,
        'agree': <String, dynamic>{'agree_num': 7, 'disagree_num': 1},
        'create_time': 100,
        'last_time_int': 200,
        'is_good': 1,
        'is_top': 0,
        'is_deleted': 0,
      };
      final postInfo = <String, dynamic>{
        'content': <Map<String, dynamic>>[
          <String, dynamic>{'type': 0, 'text': 'reply text'},
          <String, dynamic>{'type': 2, 'text': 'image_emoticon1', 'c': '微笑'},
          <String, dynamic>{
            'type': 3,
            'cdn_src': 'https://x/y/0123456789abcdef0123456789abcdef.jpg',
            'big_cdn_src': 'https://x/big.jpg',
            'origin_src': 'https://x/origin.jpg',
            'bsize': '100,200',
          },
          <String, dynamic>{
            'type': 4,
            'text': '@某人',
            'uid': 42,
            'portrait': 'tb.v?t=3',
          },
          <String, dynamic>{
            'type': 1,
            'link': 'https://ex.com',
            'text': 'Example',
          },
        ],
        'quote_id': '55',
        'id': 66,
        'author': <String, dynamic>{
          'id': 9,
          'portrait': 'tb.u?t=1',
          'name': 'author',
          'name_show': 'Author',
          'gender': 1,
        },
        'time': 300,
      };
      final data = <String, dynamic>{
        'list': <Map<String, dynamic>>[
          <String, dynamic>{
            'thread_info': threadInfo,
            'post_info': postInfo,
            'type': 2,
          },
          <String, dynamic>{
            'thread_info': threadInfo,
            'post_info': <String, dynamic>{},
            'type': 1,
          },
        ],
      };

      final posts = PcUserPosts.fromJson(data);
      expect(posts.objs, hasLength(2));

      final post = posts.objs.first;
      expect(post.fid, 1);
      expect(post.pid, 66);
      expect(post.ppid, 55);
      expect(post.createTime, 300);
      expect(post.contentType, ContentType.post);
      expect(post.thread.tid, 2);
      expect(post.thread.fname, 'bar');
      expect(post.thread.type, ThreadType.article);
      expect(post.thread.agree, 7);
      expect(post.thread.disagree, 1);
      expect(post.thread.isGood, isTrue);
      expect(post.user.portrait, 'tb.u');
      expect(post.user.privLike, PrivLike.visible);
      expect(post.user.privReply, PrivReply.all);
      expect(post.text, 'reply text@某人https://ex.com');
      expect(post.contents.emojis, hasLength(1));
      expect(post.contents.imgs, hasLength(1));
      expect(
        post.contents.imgs.single.hash,
        '0123456789abcdef0123456789abcdef',
      );
      expect(post.contents.imgs.single.showWidth, 100);
      expect(post.contents.imgs.single.showHeight, 200);
      expect(post.contents.ats.single.userId, 42);

      // A thread first post has no post_info and falls back to the thread.
      final firstPost = posts.objs.last;
      expect(firstPost.pid, 3);
      expect(firstPost.ppid, 0);
      expect(firstPost.createTime, 100);
      expect(firstPost.contentType, ContentType.thread);
      expect(firstPost.text, 'thread text');
      expect(firstPost.user.userId, 9);
    });

    test('reply page throws when thread info is missing', () {
      expect(
        () => PcUserPosts.fromJson(<String, dynamic>{
          'list': <Map<String, dynamic>>[
            <String, dynamic>{'type': 2},
          ],
        }),
        throwsA(isA<Exception>()),
      );
    });

    test('proto reply page flattens groups and shares the author', () {
      final list = pb.PostInfoList()
        ..forumId = Int64(11)
        ..threadId = Int64(22)
        ..postId = Int64(33)
        ..createTime = 1000
        ..title = '回复：topic'
        ..freqNum = 5
        ..replyNum = 6
        ..threadType = Int64(0)
        ..userId = Int64(77)
        ..userName = 'author'
        ..nameShow = '昵称'
        ..userPortrait = 'tb.p?t=1';
      list.content.add(
        pb.PostInfoList_PostInfoContent()
          ..postId = Int64(44)
          ..postType = Int64(0)
          ..createTime = Int64(2000)
          ..postContent.add(
            pb.PostInfoList_PostInfoContent_Abstract()
              ..type = 0
              ..text = 'hello',
          )
          ..postContent.add(
            pb.PostInfoList_PostInfoContent_Abstract()
              ..type = 0
              ..text = ' world',
          )
          ..postContent.add(
            pb.PostInfoList_PostInfoContent_Abstract()
              ..src = 'https://x/0123456789abcdef0123456789abcdef.jpg',
          ),
      );

      final result = UserPostss.fromProto(
        pb.UserPostResIdl_DataRes()..postList.add(list),
      );

      expect(result.objs, hasLength(1));
      expect(result.flat, hasLength(1));
      final posts = result.objs.single;
      expect(posts.fid, 11);
      expect(posts.tid, 22);
      expect(posts.thread.title, 'topic');
      final post = posts.objs.single;
      expect(post.pid, 44);
      expect(post.fid, 11);
      expect(post.tid, 22);
      expect(post.thread.tid, 22);
      expect(post.createTime, 2000);
      expect(post.contentType, ContentType.post);
      expect(post.text, 'hello world');
      expect(post.contents.imgs, hasLength(1));
      expect(
        post.contents.imgs.single.hash,
        '0123456789abcdef0123456789abcdef',
      );
      expect(post.user.userId, 77);
      expect(post.user.portrait, 'tb.p');
      expect(post.user.showName, '昵称');
      expect(post.authorId, 77);
    });

    test('followed forums parse the pc payload', () {
      final forums = PcFollowForums.fromJson(<String, dynamic>{
        'like': <Map<String, dynamic>>[
          <String, dynamic>{'forum_id': 1, 'forum_name': 'bar', 'level_id': 7},
        ],
        'has_more': 1,
      });

      expect(forums.objs, hasLength(1));
      expect(forums.objs.single.fid, 1);
      expect(forums.objs.single.fname, 'bar');
      expect(forums.objs.single.level, 7);
      expect(forums.hasMore, isTrue);
    });
  });

  group('html pages', () {
    test('forum sign-in ranking parses rows and pagination', () {
      const html = '''
<html><body>
<table>
<tr class="j_rank_row"><td>1</td><td>原神</td><td>1234</td><td>5678</td>
<td class="clearfix"><div class="bawu_icon"></div></td></tr>
<tr class="j_rank_row"><td>2</td><td>崩坏</td><td>12</td><td>34</td>
<td class="clearfix"><div class="no_bawu"></div></td></tr>
</table>
<div class="pagination"><span>1</span>
<a href="/sign/index?kw=x&pn=1">1</a>
<a href="/sign/index?kw=x&pn=5">5</a></div>
</body></html>
''';

      final result = RankForums.fromHtml(html);

      expect(result.objs, hasLength(2));
      expect(result.objs.first.fname, '原神');
      expect(result.objs.first.signNum, 1234);
      expect(result.objs.first.memberNum, 5678);
      expect(result.objs.first.hasBawu, isTrue);
      expect(result.objs.last.fname, '崩坏');
      expect(result.objs.last.hasBawu, isFalse);
      expect(result.page.currentPage, 1);
      expect(result.page.totalPage, 5);
      expect(result.hasMore, isTrue);
      expect(result.page.hasPrev, isFalse);
    });

    test('level ranking parses rows, vip marker and pager json', () {
      const html = '''
<html><body>
<table>
<tr class="drl_list_item"><td>1</td>
<td><div class="drl_item_vip"></div>Alice</td>
<td><div class="bg_lv16"></div></td><td>12345</td></tr>
<tr class="drl_list_item_self"><td>2</td>
<td><div></div>Bob</td>
<td><div class="bg_lv3"></div></td><td>99</td></tr>
</table>
<ul class="p_rank_pager" data-field='{"cur_page":1,"total_page":3}'></ul>
</body></html>
''';

      final result = RankUsers.fromHtml(html);

      expect(result.objs, hasLength(2));
      expect(result.objs.first.userName, 'Alice');
      expect(result.objs.first.level, 16);
      expect(result.objs.first.exp, 12345);
      expect(result.objs.first.isVip, isTrue);
      expect(result.objs.last.userName, 'Bob');
      expect(result.objs.last.level, 3);
      expect(result.objs.last.isVip, isFalse);
      expect(result.page.currentPage, 1);
      expect(result.page.totalPage, 3);
      expect(result.hasMore, isTrue);
    });

    test('latest members parse links and pagination', () {
      const html = '''
<html><body>
<div class="tbui_pagination">
<ul><li class="active">2</li><li>3</li></ul>
<span>共 5 页</span>
</div>
<div class="name_wrap">
<a href="/home/main?un=tb.abc" title="用户A">用户A</a>
<span class="user_level bg_lv12"></span>
</div>
<div class="name_wrap">
<a href="/home/main?un=tb.def" title="用户B">用户B</a>
<span class="user_level bg_lv7"></span>
</div>
</body></html>
''';

      final result = MemberUsers.fromHtml(html);

      expect(result.objs, hasLength(2));
      expect(result.objs.first.userName, '用户A');
      expect(result.objs.first.portrait, 'tb.abc');
      expect(result.objs.first.level, 12);
      expect(result.objs.last.portrait, 'tb.def');
      expect(result.objs.last.level, 7);
      expect(result.page.currentPage, 2);
      expect(result.page.totalPage, 5);
      expect(result.page.hasMore, isTrue);
      expect(result.page.hasPrev, isTrue);
    });

    test('empty html degrades to empty result', () {
      final forums = RankForums.fromHtml('<html><body></body></html>');
      final users = RankUsers.fromHtml('<html><body></body></html>');
      final members = MemberUsers.fromHtml('<html><body></body></html>');

      expect(forums.objs, isEmpty);
      expect(forums.page.hasMore, isFalse);
      expect(users.objs, isEmpty);
      expect(members.objs, isEmpty);
      expect(members.page.totalPage, 0);
    });
  });
}
