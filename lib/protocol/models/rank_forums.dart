import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../core/utils.dart';

/// Which sign-in ranking table is requested.
///
/// Mirrors aiotieba's `RankForumType`.
enum RankForumType {
  today(0),
  yesterday(1),
  weekly(2),
  monthly(3);

  const RankForumType(this.value);

  final int value;

  static RankForumType fromValue(int value) => RankForumType.values.firstWhere(
    (e) => e.value == value,
    orElse: () => RankForumType.weekly,
  );
}

/// One row of the forum sign-in ranking table.
///
/// Mirrors aiotieba's `RankForum`.
class RankForum {
  const RankForum({
    required this.fname,
    required this.signNum,
    required this.memberNum,
    required this.hasBawu,
  });

  final String fname;

  /// Number of users who signed in.
  final int signNum;

  /// Total number of members.
  final int memberNum;
  final bool hasBawu;

  factory RankForum.fromJson(Map<String, dynamic> json) {
    return RankForum(
      fname: parseString(json['fname']),
      signNum: parseInt(json['sign_num']),
      memberNum: parseInt(json['member_num']),
      hasBawu: parseInt(json['has_bawu']) != 0,
    );
  }

  /// Parses one `tr.j_rank_row` element.
  ///
  /// The row is a sequence of cells: rank index, forum name, sign-in count,
  /// member count and a manager cell whose child `div` is tagged
  /// `no_bawu` when the forum has no moderators.
  static RankForum? fromElement(Element row) {
    final cells = row.querySelectorAll('td');
    if (cells.length < 5) return null;
    Element? managerCell;
    for (final cell in cells) {
      if (cell.classes.contains('clearfix')) {
        managerCell = cell;
        break;
      }
    }
    final managerDiv = (managerCell ?? cells[4]).querySelector('div');
    final classes = managerDiv?.classes ?? const <String>{};
    return RankForum(
      fname: cells[1].text.trim(),
      signNum: parseInt(cells[2].text.trim()),
      memberNum: parseInt(cells[3].text.trim()),
      hasBawu: classes.isNotEmpty && !classes.contains('no_bawu'),
    );
  }

  @override
  String toString() => fname;
}

/// Pagination block of the ranking tables.
///
/// Mirrors aiotieba's `Page_rankforum`.
class RankForumPage {
  const RankForumPage({
    required this.currentPage,
    required this.totalPage,
    required this.hasMore,
    required this.hasPrev,
  });

  const RankForumPage.empty()
    : currentPage = 0,
      totalPage = 0,
      hasMore = false,
      hasPrev = false;

  final int currentPage;
  final int totalPage;
  final bool hasMore;
  final bool hasPrev;

  factory RankForumPage.fromJson(Map<String, dynamic> json) {
    final currentPage = parseInt(json['current_page'] ?? json['cur_page']);
    final totalPage = parseInt(json['total_page']);
    return RankForumPage(
      currentPage: currentPage,
      totalPage: totalPage,
      hasMore: currentPage < totalPage,
      hasPrev: currentPage > 1,
    );
  }

  /// Parses `div.pagination`: the `span` holds the current page and the last
  /// link points at the last page through its `pn=` query parameter.
  factory RankForumPage.fromDocument(Document document) {
    final pagination = document.querySelector('div.pagination');
    if (pagination == null) return const RankForumPage.empty();
    final currentPage = parseInt(pagination.querySelector('span')?.text.trim());
    final links = pagination.querySelectorAll('a');
    var totalPage = currentPage;
    if (links.isNotEmpty) {
      final href = links.last.attributes['href'] ?? '';
      final match = RegExp(r'[?&]pn=(\d+)').firstMatch(href);
      if (match != null) {
        totalPage = int.tryParse(match.group(1) ?? '') ?? currentPage;
      }
    }
    return RankForumPage(
      currentPage: currentPage,
      totalPage: totalPage,
      hasMore: currentPage < totalPage,
      hasPrev: currentPage > 1,
    );
  }
}

/// The forum sign-in ranking table of one page.
///
/// Mirrors aiotieba's `RankForums`.
class RankForums {
  const RankForums({required this.objs, required this.page});

  final List<RankForum> objs;
  final RankForumPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  /// Parses the HTML page returned by `/sign/index`.
  factory RankForums.fromHtml(String html) {
    final document = html_parser.parse(html);
    final table = document.querySelector('table');
    final objs = <RankForum>[];
    if (table != null) {
      for (final row in table.querySelectorAll('tr.j_rank_row')) {
        final forum = RankForum.fromElement(row);
        if (forum != null) objs.add(forum);
      }
    }
    return RankForums(objs: objs, page: RankForumPage.fromDocument(document));
  }
}
