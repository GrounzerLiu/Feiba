import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../core/utils.dart';

/// One user of the level ranking table.
///
/// Mirrors aiotieba's `RankUser`.
class RankUser {
  const RankUser({
    required this.userName,
    required this.level,
    required this.exp,
    required this.isVip,
  });

  final String userName;
  final int level;

  /// Experience points.
  final int exp;
  final bool isVip;

  factory RankUser.fromJson(Map<String, dynamic> json) {
    return RankUser(
      userName: parseString(json['user_name']),
      level: parseInt(json['level']),
      exp: parseInt(json['exp']),
      isVip: parseInt(json['is_vip']) != 0,
    );
  }

  /// Parses one `tr.drl_list_item` / `tr.drl_list_item_self` element.
  ///
  /// Cells are: rank index, user name (with an optional `drl_item_vip`
  /// marker), level badge (`bg_lvN`) and experience points.
  static RankUser? fromElement(Element row) {
    final cells = row.querySelectorAll('td');
    if (cells.length < 4) return null;
    final nameCell = cells[1];
    final nameDiv = nameCell.querySelector('div');
    final levelDiv = cells[2].querySelector('div');
    return RankUser(
      userName: nameCell.text.trim(),
      level: levelDiv == null ? 0 : _classNumber(levelDiv.classes),
      exp: parseInt(cells[3].text.trim()),
      isVip: nameDiv?.classes.contains('drl_item_vip') ?? false,
    );
  }

  @override
  String toString() => userName;
}

/// Pagination block of the level ranking table.
///
/// Mirrors aiotieba's `Page_rank`.
class RankPage {
  const RankPage({
    required this.currentPage,
    required this.totalPage,
    required this.hasMore,
    required this.hasPrev,
  });

  const RankPage.empty()
    : currentPage = 0,
      totalPage = 0,
      hasMore = false,
      hasPrev = false;

  final int currentPage;
  final int totalPage;
  final bool hasMore;
  final bool hasPrev;

  factory RankPage.fromJson(Map<String, dynamic> json) {
    final currentPage = parseInt(json['cur_page']);
    final totalPage = parseInt(json['total_page']);
    return RankPage(
      currentPage: currentPage,
      totalPage: totalPage,
      hasMore: currentPage < totalPage,
      hasPrev: currentPage > 1,
    );
  }

  /// Parses the JSON payload stored in `ul.p_rank_pager[data-field]`.
  factory RankPage.fromDocument(Document document) {
    final pager = document.querySelector('ul.p_rank_pager');
    final raw = pager?.attributes['data-field'];
    if (raw == null || raw.isEmpty) return const RankPage.empty();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return RankPage.fromJson(decoded.cast<String, dynamic>());
      }
    } on FormatException {
      return const RankPage.empty();
    }
    return const RankPage.empty();
  }
}

/// The level ranking table of one page.
///
/// Mirrors aiotieba's `RankUsers`.
class RankUsers {
  const RankUsers({required this.objs, required this.page});

  final List<RankUser> objs;
  final RankPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  /// Parses the HTML page returned by `/f/like/furank`.
  factory RankUsers.fromHtml(String html) {
    final document = html_parser.parse(html);
    final objs = <RankUser>[];
    for (final row in document.querySelectorAll('tr')) {
      if (!row.classes.contains('drl_list_item') &&
          !row.classes.contains('drl_list_item_self')) {
        continue;
      }
      final user = RankUser.fromElement(row);
      if (user != null) objs.add(user);
    }
    return RankUsers(objs: objs, page: RankPage.fromDocument(document));
  }
}

/// Extracts the first integer embedded in a class name such as `bg_lv16`.
int _classNumber(Iterable<String> classes) {
  for (final name in classes) {
    final match = RegExp(r'(\d+)').firstMatch(name);
    if (match != null) return int.tryParse(match.group(1) ?? '') ?? 0;
  }
  return 0;
}
