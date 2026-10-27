import '../core/enums.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;
import 'contents.dart';
import 'user.dart';

class NotificationPage {
  const NotificationPage({
    required this.currentPage,
    required this.hasMore,
    required this.hasPrev,
  });

  final int currentPage;
  final bool hasMore;
  final bool hasPrev;

  factory NotificationPage.fromJson(Map<String, dynamic> json) {
    return NotificationPage(
      currentPage: parseInt(json['current_page']),
      hasMore: parseInt(json['has_more']) != 0,
      hasPrev: parseInt(json['has_prev']) != 0,
    );
  }

  factory NotificationPage.fromProto(pb.Page proto) {
    return NotificationPage(
      currentPage: proto.currentPage,
      hasMore: proto.hasMore != 0,
      hasPrev: proto.hasPrev != 0,
    );
  }
}

/// One "@ me" notification.
class TiebaAt {
  const TiebaAt({
    required this.text,
    required this.fname,
    required this.fid,
    required this.tid,
    required this.pid,
    required this.user,
    required this.contentType,
    required this.createTime,
  });

  final String text;
  final String fname;
  final int fid;
  final int tid;
  final int pid;
  final TiebaUser? user;
  final ContentType contentType;
  final int createTime;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory TiebaAt.fromJson(Map<String, dynamic> json) {
    final replyer = json['replyer'];
    final replyerMap = replyer is Map ? replyer.cast<String, dynamic>() : null;
    return TiebaAt(
      text: parseString(json['content']),
      fname: parseString(json['fname']),
      fid: parseInt(json['fid']),
      tid: parseInt(json['thread_id']),
      pid: parseInt(json['post_id']),
      user: replyerMap == null ? null : TiebaUser.fromJsonMap(replyerMap),
      contentType: ContentType.fromValue(parseInt(json['type'])),
      createTime: parseInt(json['time']),
    );
  }
}

class TiebaAts {
  const TiebaAts({required this.objs, required this.page});

  final List<TiebaAt> objs;
  final NotificationPage page;

  bool get hasMore => page.hasMore;

  factory TiebaAts.fromJson(Map<String, dynamic> json) {
    final list = json['at_list'];
    final page = json['page'];
    return TiebaAts(
      objs: list is List
          ? <TiebaAt>[
              for (final item in list.whereType<Map>())
                TiebaAt.fromJson(item.cast<String, dynamic>()),
            ]
          : const <TiebaAt>[],
      page: page is Map
          ? NotificationPage.fromJson(page.cast<String, dynamic>())
          : const NotificationPage(
              currentPage: 1,
              hasMore: false,
              hasPrev: false,
            ),
    );
  }
}

/// One "reply me" notification.
class TiebaReply {
  const TiebaReply({
    required this.tid,
    required this.pid,
    required this.fname,
    required this.contents,
    required this.plainContent,
    required this.user,
    required this.quoteUser,
    required this.quotePid,
    required this.quoteContent,
    required this.contentType,
    required this.createTime,
  });

  final int tid;
  final int pid;
  final String fname;
  final Contents contents;
  final String plainContent;
  final TiebaUser? user;
  final TiebaUser? quoteUser;
  final int quotePid;
  final String quoteContent;
  final ContentType contentType;
  final int createTime;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  String get text => contents.isNotEmpty ? contents.displayText : plainContent;
}

class TiebaReplies {
  const TiebaReplies({required this.objs, required this.page});

  final List<TiebaReply> objs;
  final NotificationPage page;

  bool get hasMore => page.hasMore;
}
