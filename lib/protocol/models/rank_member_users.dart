import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../core/utils.dart';

/// One latest member of a forum.
///
/// Mirrors aiotieba's `MemberUser`.
class MemberUser {
  const MemberUser({
    required this.userName,
    required this.portrait,
    required this.level,
  });

  final String userName;
  final String portrait;
  final int level;

  factory MemberUser.fromJson(Map<String, dynamic> json) {
    return MemberUser(
      userName: parseString(json['user_name']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      level: parseInt(json['level']),
    );
  }

  /// Parses one `div.name_wrap` element.
  ///
  /// The anchor carries the user name in `title` and the portrait as the
  /// tail of `href` (after the fixed `/home/main?un=` prefix); the level is
  /// encoded in the span class, e.g. `bg_lv12`.
  static MemberUser? fromElement(Element element) {
    final anchor = element.querySelector('a');
    if (anchor == null) return null;
    final href = anchor.attributes['href'] ?? '';
    final portrait = href.length > 14 ? href.substring(14) : href;
    final span = element.querySelector('span');
    final title = anchor.attributes['title']?.trim() ?? '';
    return MemberUser(
      userName: title.isNotEmpty ? title : anchor.text.trim(),
      portrait: normalizePortrait(portrait),
      level: span == null ? 0 : _classNumber(span.classes),
    );
  }

  @override
  String toString() => userName;
}

/// Pagination block of the latest-member table.
///
/// Mirrors aiotieba's `Page_member`.
class MemberPage {
  const MemberPage({
    required this.currentPage,
    required this.totalPage,
    required this.hasMore,
    required this.hasPrev,
  });

  const MemberPage.empty()
    : currentPage = 0,
      totalPage = 0,
      hasMore = false,
      hasPrev = false;

  final int currentPage;
  final int totalPage;
  final bool hasMore;
  final bool hasPrev;

  factory MemberPage.fromJson(Map<String, dynamic> json) {
    final currentPage = parseInt(json['current_page'] ?? json['cur_page']);
    final totalPage = parseInt(json['total_page']);
    return MemberPage(
      currentPage: currentPage,
      totalPage: totalPage,
      hasMore: currentPage < totalPage,
      hasPrev: currentPage > 1,
    );
  }

  /// Parses `div.tbui_pagination`.
  ///
  /// The active `li` holds the current page; the total is read from the
  /// "共 N 页" label, falling back to the largest page number in the list.
  factory MemberPage.fromDocument(Document document) {
    final pagination = document.querySelector('div.tbui_pagination');
    if (pagination == null) return const MemberPage.empty();
    final currentPage = parseInt(
      pagination.querySelector('li.active')?.text.trim(),
    );
    var totalPage = 0;
    final totalMatch = RegExp(r'共\s*(\d+)\s*页').firstMatch(pagination.text);
    if (totalMatch != null) {
      totalPage = int.tryParse(totalMatch.group(1) ?? '') ?? 0;
    }
    if (totalPage == 0) {
      for (final item in pagination.querySelectorAll('li')) {
        final value = parseInt(item.text.trim());
        if (value > totalPage) totalPage = value;
      }
    }
    return MemberPage(
      currentPage: currentPage,
      totalPage: totalPage,
      hasMore: currentPage < totalPage,
      hasPrev: currentPage > 1,
    );
  }
}

/// The latest-member table of one page.
///
/// Mirrors aiotieba's `MemberUsers`.
class MemberUsers {
  const MemberUsers({required this.objs, required this.page});

  final List<MemberUser> objs;
  final MemberPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  /// Parses the HTML page returned by `/bawu2/platform/listMemberInfo`.
  factory MemberUsers.fromHtml(String html) {
    final document = html_parser.parse(html);
    final objs = <MemberUser>[];
    for (final element in document.querySelectorAll('div.name_wrap')) {
      final user = MemberUser.fromElement(element);
      if (user != null) objs.add(user);
    }
    return MemberUsers(objs: objs, page: MemberPage.fromDocument(document));
  }
}

/// Extracts the first integer embedded in a class name such as `bg_lv12`.
int _classNumber(Iterable<String> classes) {
  for (final name in classes) {
    final match = RegExp(r'(\d+)').firstMatch(name);
    if (match != null) return int.tryParse(match.group(1) ?? '') ?? 0;
  }
  return 0;
}
