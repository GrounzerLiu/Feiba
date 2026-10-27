import 'package:html/dom.dart';

import '../core/utils.dart';
import 'bawu_parse.dart';
import 'page.dart';

/// A media attachment of a moderated post.
class BawuPostLogMedia {
  const BawuPostLogMedia({
    required this.src,
    required this.originSrc,
    required this.hash,
  });

  /// Thumbnail URL.
  final String src;

  /// Original image URL.
  final String originSrc;

  /// Baidu image hash.
  final String hash;

  factory BawuPostLogMedia.fromElement(Element anchor) {
    final image = anchor.querySelector('img');
    final src = image?.attributes['original'] ?? '';
    return BawuPostLogMedia(
      src: src,
      originSrc: anchor.attributes['href'] ?? '',
      hash: src.isEmpty ? '' : bawuImageHash(src),
    );
  }
}

/// One row of the moderator post-management log.
class BawuPostLog {
  const BawuPostLog({
    required this.text,
    required this.title,
    required this.medias,
    required this.tid,
    required this.pid,
    required this.opType,
    required this.postPortrait,
    required this.postTime,
    required this.opUserName,
    required this.opTime,
  });

  final String text;
  final String title;
  final List<BawuPostLogMedia> medias;

  /// Thread the moderated post belongs to.
  final int tid;

  /// Post id; 0 when the moderated object is the thread itself.
  final int pid;

  /// Operation name, such as `删除主题`.
  final String opType;

  final String postPortrait;

  /// Time the moderated post was created; the page omits the year, so the
  /// value uses 1904 like aiotieba.
  final DateTime postTime;

  final String opUserName;
  final DateTime opTime;

  factory BawuPostLog.fromElement(Element row) {
    final leftCell = row.querySelector('td');
    final postMeta = leftCell?.querySelector('div.post_meta');
    final postUser = postMeta?.querySelector('div');
    final postPortrait = bawuPortrait(
      postUser?.querySelector('a')?.attributes['href'] ?? '',
    );
    final postTime = _parsePostLogTime(
      postMeta?.querySelector('time')?.text ?? '',
    );

    final postContent = postMeta?.nextElementSibling;
    final titleAnchor = postContent?.querySelector('h1 a');
    final url = titleAnchor?.attributes['href'] ?? '';
    var tid = 0;
    var pid = 0;
    final queryIndex = url.indexOf('?');
    if (url.startsWith('/p/') && queryIndex != -1) {
      tid = parseInt(url.substring(3, queryIndex));
      final hashIndex = url.lastIndexOf('#');
      if (hashIndex != -1) pid = parseInt(url.substring(hashIndex + 1));
    }
    var title = titleAnchor?.attributes['title'] ?? '';

    final textElement = postContent?.querySelector('div');
    final rawText = textElement?.text ?? '';
    // aiotieba drops a fixed 12-character label prefix from the content cell.
    var text = rawText.length > 12 ? rawText.substring(12) : '';
    if (pid == tid || !title.startsWith('回复：')) {
      pid = 0;
      text = '$title\n$text';
    } else {
      title = title.replaceFirst('回复：', '');
    }

    var medias = const <BawuPostLogMedia>[];
    final mediaList = textElement?.nextElementSibling;
    if (mediaList != null) {
      medias = <BawuPostLogMedia>[
        for (final anchor in mediaList.querySelectorAll('a'))
          BawuPostLogMedia.fromElement(anchor),
      ];
    }

    final opTypeCell = leftCell?.nextElementSibling;
    final opUserNameCell = opTypeCell?.nextElementSibling;
    final opTimeCell = opUserNameCell?.nextElementSibling;

    return BawuPostLog(
      text: text,
      title: title,
      medias: medias,
      tid: tid,
      pid: pid,
      opType: opTypeCell?.text ?? '',
      postPortrait: postPortrait,
      postTime: postTime,
      opUserName: opUserNameCell?.text ?? '',
      opTime: bawuDateTime(opTimeCell?.text ?? ''),
    );
  }
}

/// One page of the moderator post-management log.
class BawuPostLogs {
  const BawuPostLogs({required this.objs, required this.page});

  final List<BawuPostLog> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory BawuPostLogs.fromHtml(String html) {
    final document = bawuParseHtml(html);
    final rows =
        document.querySelector('tbody')?.querySelectorAll('tr') ??
        const <Element>[];
    return BawuPostLogs(
      objs: <BawuPostLog>[for (final row in rows) BawuPostLog.fromElement(row)],
      page: bawuPagination(document),
    );
  }
}

/// Parses the `MM-DD HH:MM` creation time shown in the log; the year is not
/// part of the page, so 1904 is used as in aiotieba.
DateTime _parsePostLogTime(String raw) {
  final numbers = RegExp(r'\d+')
      .allMatches(raw)
      .map((match) => int.parse(match.group(0)!))
      .toList();
  // aiotieba reads fixed offsets of a `MM-DD HH:MM` value; parsing the digit
  // groups instead also accepts a year prefix and single-space separators.
  final offset = numbers.length >= 5 ? 1 : 0;
  if (numbers.length >= offset + 4) {
    final month = numbers[offset];
    final day = numbers[offset + 1];
    final hour = numbers[offset + 2];
    final minute = numbers[offset + 3];
    if (month >= 1 &&
        month <= 12 &&
        day >= 1 &&
        day <= 31 &&
        hour < 24 &&
        minute < 60) {
      return DateTime(1904, month, day, hour, minute);
    }
  }
  return bawuEpoch();
}
