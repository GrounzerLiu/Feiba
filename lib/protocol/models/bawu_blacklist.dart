import 'package:html/dom.dart';

import '../core/utils.dart';
import 'bawu_parse.dart';
import 'page.dart';

/// A user on the forum moderator blacklist.
class BawuBlacklistUser {
  const BawuBlacklistUser({
    required this.userId,
    required this.portrait,
    required this.userName,
  });

  final int userId;
  final String portrait;
  final String userName;

  /// Preferred name: user name, then portrait, then the numeric id.
  String get displayName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return portrait;
    return '$userId';
  }

  factory BawuBlacklistUser.fromElement(Element cell) {
    final checkbox = cell.previousElementSibling?.querySelector('input');
    return BawuBlacklistUser(
      userId: parseInt(checkbox?.attributes['data-user-id']),
      portrait: bawuPortrait(cell.querySelector('a')?.attributes['href'] ?? ''),
      userName: checkbox?.attributes['data-user-name'] ?? '',
    );
  }
}

/// One page of the forum moderator blacklist.
class BawuBlacklistUsers {
  const BawuBlacklistUsers({required this.objs, required this.page});

  final List<BawuBlacklistUser> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory BawuBlacklistUsers.fromHtml(String html) {
    final document = bawuParseHtml(html);
    final cells = document.querySelectorAll('td.left_cell');
    return BawuBlacklistUsers(
      objs: <BawuBlacklistUser>[
        for (final cell in cells) BawuBlacklistUser.fromElement(cell),
      ],
      page: bawuPagination(document),
    );
  }
}
