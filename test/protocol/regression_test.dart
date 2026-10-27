import 'package:feiba/protocol/core/account.dart';
import 'package:feiba/protocol/core/constants.dart';
import 'package:feiba/protocol/core/enums.dart';
import 'package:feiba/protocol/generated/generated.dart' as pb;
import 'package:feiba/protocol/models/contents.dart';
import 'package:feiba/protocol/models/forum.dart';
import 'package:feiba/protocol/models/thread.dart';
import 'package:feiba/protocol/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('user posts default version is the reference version 8', () {
    expect(TiebaConstants.userPostsVersion, '8');
  });

  test('account client id is empty until sync', () {
    expect(TiebaAccount().clientId, isEmpty);
  });

  test('zero privacy bits map to public/all', () {
    final user = TiebaUser.fromProto(pb.User());
    expect(user.privLike, PrivLike.visible);
    expect(user.privReply, PrivReply.all);
  });

  test('empty managers list still means the forum has moderators field', () {
    final forum = TiebaForum.fromJson(<String, dynamic>{
      'managers': <dynamic>[],
    });
    expect(forum.hasBawu, isTrue);
  });

  test('share thread without origin is not marked as shared', () {
    final proto = pb.ThreadInfo()..isShareThread = 1;
    final thread = TiebaThread.fromProto(proto);
    expect(thread.isShare, isFalse);
    expect(thread.shareOrigin, isNull);
  });

  test('summary contents take images from media and skip image fragments', () {
    final media = pb.Media()
      ..type = 1
      ..waterPic = 'https://example.com/a.jpg'
      ..smallPic = 'https://example.com/a.jpg'
      ..bigPic = 'https://example.com/a.jpg';
    final contents = Contents.fromSummary(
      <pb.PbContent>[
        pb.PbContent()
          ..type = 3
          ..cdnSrc = '',
        pb.PbContent()
          ..type = 0
          ..text = 'hello',
      ],
      media: <pb.Media>[media],
    );
    expect(contents.imgs, hasLength(1));
    expect(contents.text, 'hello');
    expect(contents.objs.whereType<FragImage>(), hasLength(1));
  });

  test('type 40 is text for posts but not for thread first posts', () {
    final fragment = pb.PbContent()
      ..type = 40
      ..text = '梗';
    expect(Contents.fromPost(pb.Post()..content.add(fragment)).text, '梗');
    expect(
      Contents.fromThread(pb.ThreadInfo()..firstPostContent.add(fragment)).text,
      isEmpty,
    );
  });
}
