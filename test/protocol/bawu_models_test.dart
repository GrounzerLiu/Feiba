import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/models/bawu_blacklist.dart';
import 'package:feiba/protocol/models/bawu_block.dart';
import 'package:feiba/protocol/models/bawu_enums.dart';
import 'package:feiba/protocol/models/bawu_info.dart';
import 'package:feiba/protocol/models/bawu_member.dart';
import 'package:feiba/protocol/models/bawu_perm.dart';
import 'package:feiba/protocol/models/bawu_postlog.dart';
import 'package:feiba/protocol/models/bawu_userlog.dart';
import 'package:feiba/protocol/models/recover_info.dart';
import 'package:feiba/protocol/models/recover_list.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub _roleInfo({
  required int userId,
  required String roleName,
  required String userName,
  required String nickName,
  int level = 0,
}) {
  return pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub()
    ..userId = Int64(userId)
    ..roleName = roleName
    ..portrait = 'tb.1.$userId'
    ..userLevel = level
    ..userName = userName
    ..nameShow = nickName;
}

pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes _roleTeam(
  String roleName,
  List<pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub> users,
) {
  final team = pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes()
    ..roleName = roleName;
  team.roleInfo.addAll(users);
  return team;
}

void main() {
  group('BawuTeamInfo', () {
    test('groups protobuf roles and skips unknown roles', () {
      final data = pb.GetBawuInfoResIdl_DataRes();
      final team = pb.GetBawuInfoResIdl_DataRes_BawuTeam();
      team.bawuTeamList.addAll(
        <pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes>[
          _roleTeam(
            'manager',
            <pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>[
              _roleInfo(
                userId: 7,
                roleName: 'manager',
                userName: 'boss',
                nickName: 'Boss',
                level: 20,
              ),
            ],
          ),
          _roleTeam(
            'assist',
            <pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>[
              _roleInfo(
                userId: 8,
                roleName: 'assist',
                userName: 'mod',
                nickName: 'Mod',
                level: 5,
              ),
            ],
          ),
          _roleTeam(
            'unknown',
            <pb.GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>[
              _roleInfo(
                userId: 9,
                roleName: 'unknown',
                userName: 'ghost',
                nickName: '',
              ),
            ],
          ),
        ],
      );
      data.bawuTeamInfo = team;

      final info = BawuTeamInfo.fromProto(data);
      expect(info.all, hasLength(2));
      expect(info.admin.single.userId, 7);
      expect(info.admin.single.showName, 'Boss');
      expect(info.admin.single.level, 20);
      expect(info.manager.single.userName, 'mod');
      expect(info.manager.single.level, 5);
      expect(info.voiceEditor, isEmpty);
      expect(info.fourthAdmin, isEmpty);
    });
  });

  group('BawuPermType', () {
    test('combines and maps permission ids', () {
      final perms = BawuPermType.unblock | BawuPermType.recover;
      expect(perms.value, 5);
      expect(perms.contains(BawuPermType.unblock), isTrue);
      expect(perms.contains(BawuPermType.recover), isTrue);
      expect(perms.contains(BawuPermType.unblockAppeal), isFalse);
      expect(perms.contains(BawuPermType.none), isFalse);
      expect(BawuPermType.unblock.permId, 4);
      expect(BawuPermType.fromPermId(2), BawuPermType.recoverAppeal);
      expect(BawuPermType.fromPermId(9), isNull);
      expect(BawuPermType.all.value, 15);
    });
  });

  group('BawuPerm', () {
    test('parses the granted permissions and user info', () {
      final perm = BawuPerm.fromJson(<String, dynamic>{
        'user': <String, dynamic>{
          'user_name': 'mod',
          'user_nickname': 'Mod',
          'level_id': 5,
          'role_type': 'assist',
          'create_time': 1700000000,
        },
        'perm_setting': <String, dynamic>{
          'category_user': <Map<String, dynamic>>[
            <String, dynamic>{'switch': 1, 'perm': 4},
            <String, dynamic>{'switch': 0, 'perm': 5},
            <String, dynamic>{'switch': true, 'perm': 2},
          ],
          'category_thread': <Map<String, dynamic>>[
            <String, dynamic>{'switch': 1, 'perm': 3},
          ],
        },
      });
      expect(perm.user.bawuType, BawuType.manager);
      expect(perm.user.nickNameOld, 'Mod');
      expect(perm.user.level, 5);
      expect(perm.user.beginTime.millisecondsSinceEpoch, 1700000000000);
      expect(perm.perms.contains(BawuPermType.unblock), isTrue);
      expect(perm.perms.contains(BawuPermType.unblockAppeal), isFalse);
      expect(perm.perms.contains(BawuPermType.recoverAppeal), isTrue);
      expect(perm.perms.contains(BawuPermType.recover), isTrue);
      expect(perm.perms.value, 13);
    });
  });

  group('BawuBlacklistUsers', () {
    test('parses users and pagination from html', () {
      final users = BawuBlacklistUsers.fromHtml('''
<html><body>
  <div class="breadcrumbs"><em>12</em> users</div>
  <table><tbody><tr>
    <td><input data-user-name="badguy" data-user-id="42"></td>
    <td class="left_cell">
      <a href="/home/main?un=badguy&amp;ie=utf-8&amp;id=tb.1.abc%3Ft%3D1700000000&amp;fr=bawu">badguy</a>
    </td>
  </tr></tbody></table>
  <div class="tbui_pagination"><ul><li class="active">2</li></ul><a href="?pn=5">[5]</a></div>
</body></html>
''');
      expect(users.objs, hasLength(1));
      expect(users.objs.single.userId, 42);
      expect(users.objs.single.userName, 'badguy');
      expect(users.objs.single.portrait, 'tb.1.abc');
      expect(users.page.currentPage, 2);
      expect(users.page.totalPage, 5);
      expect(users.page.totalCount, 12);
      expect(users.hasMore, isTrue);
      expect(users.page.hasPrev, isTrue);
    });
  });

  group('BawuMemberList', () {
    test('parses member counters and join time', () {
      final members = BawuMemberList.fromHtml('''
<html><body><table><tbody><tr>
  <td><a href="/home/main?un=alice"> alice</a></td>
  <td>120</td>
  <td>7</td>
  <td>3</td>
  <td></td>
  <td>2024-01-02 03:04</td>
  <td id="99" portrait="tb.1.xyz">btn</td>
</tr></tbody></table></body></html>
''');
      final member = members.objs.single;
      expect(member.userName, 'alice');
      expect(member.userId, 99);
      expect(member.portrait, 'tb.1.xyz');
      expect(member.exp, 120);
      expect(member.level, 7);
      expect(member.threadNum, 3);
      expect(member.goodNum, 0);
      expect(member.joinTime, DateTime(2024, 1, 2, 3, 4));
    });
  });

  group('BawuPostLogs', () {
    test('parses reply rows, media and pagination', () {
      final logs = BawuPostLogs.fromHtml('''
<html><body>
<div class="breadcrumbs"><em>3</em> records</div>
<table><tbody><tr>
  <td>
    <div class="post_meta">
      <div><a href="/home/main?un=alice&amp;id=tb.1.p%3Ft%3D1&amp;fr=bawu">alice</a></div>
      <time>01-02 03:04</time>
    </div>
    <div class="post_content">
      <h1><a href="/p/123456?pid=789#789" title="回复：主题标题">回复：主题标题</a></h1>
      <div>0123456789ab回复正文</div>
      <div class="media">
        <a href="https://example.com/origin.jpg">
          <img original="https://tiebapic.baidu.com/forum/w%3D720/0123456789abcdef0123456789abcdef.jpg">
        </a>
      </div>
    </div>
  </td>
  <td>删除回复</td>
  <td>admin</td>
  <td>2024-01-02 03:04</td>
</tr></tbody></table>
<div class="tbui_pagination"><ul><li class="active">1</li></ul><a>[2]</a></div>
</body></html>
''');
      final log = logs.objs.single;
      expect(log.tid, 123456);
      expect(log.pid, 789);
      expect(log.title, '主题标题');
      expect(log.text, '回复正文');
      expect(log.postPortrait, 'tb.1.p');
      expect(log.postTime, DateTime(1904, 1, 2, 3, 4));
      expect(log.opType, '删除回复');
      expect(log.opUserName, 'admin');
      expect(log.opTime, DateTime(2024, 1, 2, 3, 4));
      expect(log.medias, hasLength(1));
      expect(log.medias.single.originSrc, 'https://example.com/origin.jpg');
      expect(log.medias.single.hash, '0123456789abcdef0123456789abcdef');
      expect(logs.page.currentPage, 1);
      expect(logs.page.totalPage, 2);
      expect(logs.hasMore, isTrue);
    });

    test('treats theme rows as thread content', () {
      final logs = BawuPostLogs.fromHtml('''
<html><body><table><tbody><tr>
  <td>
    <div class="post_meta">
      <div><a href="/home/main?un=bob&amp;id=tb.1.q&amp;fr=bawu">bob</a></div>
      <time>05-06 07:08</time>
    </div>
    <div class="post_content">
      <h1><a href="/p/555?pid=555#555" title="主题标题">主题标题</a></h1>
      <div>0123456789ab主题正文</div>
    </div>
  </td>
  <td>删除主题</td>
  <td>admin</td>
  <td>2024-05-06 07:08</td>
</tr></tbody></table></body></html>
''');
      final log = logs.objs.single;
      expect(log.pid, 0);
      expect(log.tid, 555);
      expect(log.text, '主题标题\n主题正文');
    });
  });

  group('BawuUserLogs', () {
    test('parses operation duration and time', () {
      final logs = BawuUserLogs.fromHtml('''
<html><body><table><tbody><tr>
  <td><a href="/home/main?un=bad&amp;id=tb.1.bad&amp;fr=bawu">bad</a></td>
  <td>封禁用户</td>
  <td>3 天</td>
  <td>admin</td>
  <td>2024-01-02 03:04</td>
</tr></tbody></table></body></html>
''');
      final log = logs.objs.single;
      expect(log.opType, '封禁用户');
      expect(log.opDuration, 3);
      expect(log.userPortrait, 'tb.1.bad');
      expect(log.opUserName, 'admin');
      expect(log.opTime, DateTime(2024, 1, 2, 3, 4));
    });
  });

  group('BawuBlocks', () {
    test('parses embedded html and page json', () {
      final blocks = BawuBlocks.fromJson(<String, dynamic>{
        'data': <String, dynamic>{
          'content':
              '<ul><li><a attr-uid="55" attr-un="spam" attr-nn="Spam" '
              'attr-blockday="3" href="#">spam</a>'
              '<span class="block_list_item_time">2024-05-06 07:08</span>'
              '</li></ul>',
          'page': <String, dynamic>{
            'size': 4,
            'pn': 2,
            'total_page': 4,
            'total_count': 70,
            'have_next': 1,
          },
        },
      });
      final block = blocks.objs.single;
      expect(block.userId, 55);
      expect(block.userName, 'spam');
      expect(block.nickNameNew, 'Spam');
      expect(block.day, 3);
      expect(block.blockTime, DateTime(2024, 5, 6, 7, 8));
      expect(blocks.page.pageSize, 4);
      expect(blocks.page.currentPage, 2);
      expect(blocks.page.totalPage, 4);
      expect(blocks.page.totalCount, 70);
      expect(blocks.hasMore, isTrue);
      expect(blocks.page.hasPrev, isTrue);
    });
  });

  group('BawuAppeals', () {
    test('parses appeals', () {
      final appeals = BawuAppeals.fromJson(<String, dynamic>{
        'data': <String, dynamic>{
          'appeal_list': <Map<String, dynamic>>[
            <String, dynamic>{
              'user': <String, dynamic>{
                'id': 12,
                'portrait': 'tb.1.q?t=1',
                'name': 'user',
                'name_show': 'User',
              },
              'appeal_id': '101',
              'appeal_reason': 'reason',
              'appeal_time': '1700000000',
              'punish_reason': 'spam',
              'punish_start_time': '1699999999',
              'punish_day_num': 10,
              'operate_man': 'op',
            },
          ],
          'has_more': true,
        },
      });
      final appeal = appeals.objs.single;
      expect(appeal.userId, 12);
      expect(appeal.portrait, 'tb.1.q');
      expect(appeal.nickName, 'User');
      expect(appeal.appealId, 101);
      expect(appeal.appealTime, 1700000000);
      expect(appeal.punishDay, 10);
      expect(appeal.opName, 'op');
      expect(appeals.hasMore, isTrue);
    });
  });

  group('TiebaRecovers', () {
    Map<String, dynamic> opInfo() => <String, dynamic>{
      'name': 'operator',
      'time': '1700000000',
    };

    test('parses thread rows', () {
      final recovers = TiebaRecovers.fromJson(<String, dynamic>{
        'data': <String, dynamic>{
          'thread_list': <Map<String, dynamic>>[
            <String, dynamic>{
              'thread_info': <String, dynamic>{
                'tid': 111,
                'title': 'Thread title',
                'abstract': 'thread body',
                'portrait': 'tb.1.a?t=1',
                'user_name': 'author',
                'user_nickname': 'Author',
              },
              'post_info': <String, dynamic>{},
              'sub_post_info': <String, dynamic>{},
              'op_info': opInfo(),
              'is_frs_mask': '1',
            },
          ],
          'page': <String, dynamic>{'rn': 10, 'pn': 2, 'has_more': 1},
        },
      });
      final recover = recovers.objs.single;
      expect(recover.contentType.name, 'thread');
      expect(recover.tid, 111);
      expect(recover.pid, 0);
      expect(recover.text, 'thread body');
      expect(recover.user.portrait, 'tb.1.a');
      expect(recover.thread.title, 'Thread title');
      expect(recover.post.isNotEmpty, isFalse);
      expect(recover.opShowName, 'operator');
      expect(recover.opTime, 1700000000);
      expect(recover.isHide, isTrue);
      expect(recovers.page.pageSize, 10);
      expect(recovers.page.currentPage, 2);
      expect(recovers.hasMore, isTrue);
      expect(recovers.page.hasPrev, isTrue);
    });

    test('parses post and comment rows', () {
      final recovers = TiebaRecovers.fromJson(<String, dynamic>{
        'data': <String, dynamic>{
          'thread_list': <Map<String, dynamic>>[
            <String, dynamic>{
              'thread_info': <String, dynamic>{
                'tid': 222,
                'title': 'T',
                'abstract': '',
                'portrait': 'tb.1.t',
                'user_name': 'thread_author',
                'user_nickname': 'TA',
              },
              'post_info': <String, dynamic>{
                'pid': 333,
                'abstract': 'post body',
                'portrait': 'tb.1.p',
                'user_name': 'post_author',
                'user_nickname': 'PA',
              },
              'sub_post_info': <String, dynamic>{},
              'op_info': opInfo(),
              'is_frs_mask': 0,
            },
            <String, dynamic>{
              'thread_info': <String, dynamic>{
                'tid': 222,
                'title': 'T',
                'abstract': '',
                'portrait': 'tb.1.t',
                'user_name': 'thread_author',
                'user_nickname': 'TA',
              },
              'post_info': <String, dynamic>{
                'pid': 444,
                'abstract': 'parent body',
                'portrait': 'tb.1.parent',
                'user_name': 'parent_author',
                'user_nickname': 'Parent',
              },
              'sub_post_info': <String, dynamic>{
                'pid': 555,
                'abstract': 'child body',
                'portrait': 'tb.1.child',
                'user_name': 'child_author',
                'user_nickname': 'Child',
              },
              'op_info': opInfo(),
              'is_frs_mask': 0,
            },
          ],
          'page': <String, dynamic>{'rn': 10, 'pn': 1, 'has_more': 0},
        },
      });

      final post = recovers.objs[0];
      expect(post.contentType.name, 'post');
      expect(post.pid, 333);
      expect(post.text, 'post body');
      expect(post.user.portrait, 'tb.1.p');
      expect(post.post.isNotEmpty, isFalse);
      expect(post.isHide, isFalse);

      final comment = recovers.objs[1];
      expect(comment.contentType.name, 'comment');
      expect(comment.pid, 555);
      expect(comment.text, 'child body');
      expect(comment.user.portrait, 'tb.1.child');
      expect(comment.post.pid, 444);
      expect(comment.post.text, 'parent body');
      expect(comment.post.user.portrait, 'tb.1.parent');
    });
  });

  group('TiebaRecoverInfo', () {
    test('parses content fragments, images and user info', () {
      final info = TiebaRecoverInfo.fromJson(<String, dynamic>{
        'thread_info': <String, dynamic>{
          'title': 'Title',
          'thread_id': 111,
          'post_id': 222,
          'content_detail': <Map<String, dynamic>>[
            <String, dynamic>{'type': 1, 'value': 'hello '},
            <String, dynamic>{'type': 3, 'value': 'ignored'},
            <String, dynamic>{'type': 1, 'value': 'world'},
          ],
          'all_pics': <Map<String, dynamic>>[
            <String, dynamic>{
              'url':
                  'https://tiebapic.baidu.com/forum/w%3D720/'
                  '0123456789abcdef0123456789abcdef.jpg',
              'width': '720',
              'height': 480,
            },
          ],
        },
        'user_info': <String, dynamic>{
          'portrait': 'tb.1.u?t=1',
          'user_name': 'author',
          'show_nickname': 'Author',
        },
      });
      expect(info.title, 'Title');
      expect(info.tid, 111);
      expect(info.pid, 222);
      expect(info.contents.text, 'hello world');
      expect(info.contents.imgs, hasLength(1));
      expect(info.contents.imgs.single.showWidth, 720);
      expect(info.contents.imgs.single.showHeight, 480);
      expect(
        info.contents.imgs.single.hash,
        '0123456789abcdef0123456789abcdef',
      );
      expect(info.user.portrait, 'tb.1.u');
      expect(info.user.showName, 'Author');
      expect(info.text, 'Title\nhello world');
    });
  });
}
