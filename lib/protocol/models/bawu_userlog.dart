import 'package:html/dom.dart';

import '../core/utils.dart';
import 'bawu_parse.dart';
import 'page.dart';

/// One row of the moderator user-management log.
class BawuUserLog {
  const BawuUserLog({
    required this.opType,
    required this.opDuration,
    required this.userPortrait,
    required this.opUserName,
    required this.opTime,
  });

  /// Operation name, such as `封禁用户`.
  final String opType;

  /// Duration of the operation in days; 0 for permanent or non-duration
  /// operations.
  final int opDuration;

  /// Portrait of the moderated user.
  final String userPortrait;

  final String opUserName;
  final DateTime opTime;

  factory BawuUserLog.fromElement(Element row) {
    final leftCell = row.querySelector('td');
    final userPortrait = bawuPortrait(
      leftCell?.querySelector('a')?.attributes['href'] ?? '',
    );

    final opTypeCell = leftCell?.nextElementSibling;
    final opDurationCell = opTypeCell?.nextElementSibling;
    final rawDuration = (opDurationCell?.text ?? '').replaceAll(' ', '');
    final opUserNameCell = opDurationCell?.nextElementSibling;
    final opTimeCell = opUserNameCell?.nextElementSibling;

    return BawuUserLog(
      opType: opTypeCell?.text ?? '',
      opDuration: rawDuration.contains('天')
          ? parseInt(rawDuration.substring(0, rawDuration.length - 1))
          : 0,
      userPortrait: userPortrait,
      opUserName: opUserNameCell?.text ?? '',
      opTime: bawuDateTime(opTimeCell?.text ?? ''),
    );
  }
}

/// One page of the moderator user-management log.
class BawuUserLogs {
  const BawuUserLogs({required this.objs, required this.page});

  final List<BawuUserLog> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory BawuUserLogs.fromHtml(String html) {
    final document = bawuParseHtml(html);
    final rows =
        document.querySelector('tbody')?.querySelectorAll('tr') ??
        const <Element>[];
    return BawuUserLogs(
      objs: <BawuUserLog>[for (final row in rows) BawuUserLog.fromElement(row)],
      page: bawuPagination(document),
    );
  }
}
