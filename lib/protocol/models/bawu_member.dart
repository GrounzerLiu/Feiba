import 'package:html/dom.dart';

import '../core/utils.dart';
import 'bawu_parse.dart';

/// A member of a forum as returned by the moderator backend member list.
class BawuMemberUser {
  const BawuMemberUser({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.exp,
    required this.level,
    required this.threadNum,
    required this.goodNum,
    required this.joinTime,
  });

  final int userId;
  final String portrait;
  final String userName;

  /// Forum experience.
  final int exp;

  /// Forum level.
  final int level;

  /// Number of threads started by the user.
  final int threadNum;

  /// Number of highlighted threads by the user.
  final int goodNum;

  /// Time the user followed the forum.
  final DateTime joinTime;

  factory BawuMemberUser.fromElement(Element row) {
    final leftCell = row.querySelector('td');
    final anchor = leftCell?.querySelector('a');
    final userName = (anchor?.text ?? '').trimLeft();

    final expCell = leftCell?.nextElementSibling;
    final levelCell = expCell?.nextElementSibling;
    final threadCell = levelCell?.nextElementSibling;
    final goodCell = threadCell?.nextElementSibling;
    final joinCell = goodCell?.nextElementSibling;
    final buttonCell = joinCell?.nextElementSibling;

    return BawuMemberUser(
      userId: parseInt(buttonCell?.attributes['id']),
      portrait: buttonCell?.attributes['portrait'] ?? '',
      userName: userName,
      exp: parseInt(expCell?.text.trim()),
      level: parseInt(levelCell?.text.trim()),
      threadNum: parseInt(threadCell?.text.trim()),
      goodNum: parseInt(goodCell?.text.trim()),
      joinTime: bawuDateTime(joinCell?.text ?? ''),
    );
  }
}

/// The member list page of the moderator backend.
class BawuMemberList {
  const BawuMemberList({required this.objs});

  final List<BawuMemberUser> objs;

  bool get isEmpty => objs.isEmpty;

  BawuMemberUser? get first => objs.isEmpty ? null : objs.first;

  factory BawuMemberList.fromHtml(String html) {
    final document = bawuParseHtml(html);
    final rows =
        document.querySelector('tbody')?.querySelectorAll('tr') ??
        const <Element>[];
    return BawuMemberList(
      objs: <BawuMemberUser>[
        for (final row in rows) BawuMemberUser.fromElement(row),
      ],
    );
  }
}
