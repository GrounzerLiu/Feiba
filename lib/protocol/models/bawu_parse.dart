import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../core/utils.dart';
import 'page.dart';

/// Parsing helpers shared by the bawu models.
///
/// aiotieba reads these pages with BeautifulSoup, whose `.text` concatenates
/// the child text nodes without separators. `package:html` behaves the same
/// way, so the helpers below keep the same semantics. All helpers are
/// deliberately tolerant: a missing field yields a default instead of an
/// exception so that a single unexpected row does not break a whole page.

/// Parses a full HTML document.
Document bawuParseHtml(String html) => html_parser.parse(html);

/// Parses an HTML fragment (the block list response embeds one).
DocumentFragment bawuParseFragment(String html) =>
    html_parser.parseFragment(html);

/// Returns [value] as a JSON object, or an empty map when it is not one.
Map<String, dynamic> bawuMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return <String, dynamic>{
      for (final entry in value.entries) '${entry.key}': entry.value,
    };
  }
  return const <String, dynamic>{};
}

/// Returns [value] as a JSON list, or an empty list when it is not one.
List<dynamic> bawuList(dynamic value) =>
    value is List ? value : const <dynamic>[];

/// Coerces a JSON flag (bool, number or numeric string) to a bool.
bool bawuFlag(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final text = value.trim().toLowerCase();
    return text == '1' || text == 'true' || text == 'yes';
  }
  return false;
}

/// Extracts a user portrait from a profile anchor `href`.
///
/// aiotieba slices a fixed 14..-17 character window out of these hrefs, which
/// only works for one exact link layout. The extraction below accepts both the
/// `?un=` and `&id=` query forms and strips the appended `?t=<timestamp>`.
String bawuPortrait(String href) {
  if (href.isEmpty) return '';
  final idIndex = href.indexOf('id=');
  if (idIndex != -1) {
    var value = href.substring(idIndex + 3);
    final ampIndex = value.indexOf('&');
    if (ampIndex != -1) value = value.substring(0, ampIndex);
    try {
      value = Uri.decodeComponent(value);
    } on FormatException {
      // Keep the raw value when the server sends malformed escaping.
    }
    return normalizePortrait(value);
  }
  const prefix = '/home/main?un=';
  if (href.startsWith(prefix)) {
    return normalizePortrait(href.substring(prefix.length));
  }
  return href;
}

/// Extracts the Baidu image hash from an image URL.
///
/// Mirrors aiotieba's `_IMAGEHASH_EXP` (`/([a-z0-9]{32,})\.`).
String bawuImageHash(String url) {
  final match = RegExp(r'/([a-z0-9]{32,})\.').firstMatch(url);
  return match?.group(1) ?? '';
}

/// The timestamp used when a page carries no date, matching aiotieba's
/// `default_datetime()`.
DateTime bawuEpoch() => DateTime.fromMillisecondsSinceEpoch(0);

/// Parses a `YYYY-MM-DD HH:MM` timestamp.
///
/// Only the digit groups matter, so both `2024-01-02 03:04` and
/// `2024-01-02 03:04:05` parse. Returns [bawuEpoch] when the value does not
/// contain a full date and time.
DateTime bawuDateTime(String raw) {
  final numbers = RegExp(r'\d+')
      .allMatches(raw)
      .map((match) => int.parse(match.group(0)!))
      .toList();
  if (numbers.length >= 5) {
    final year = numbers[0];
    final month = numbers[1];
    final day = numbers[2];
    final hour = numbers[3];
    final minute = numbers[4];
    final second = numbers.length >= 6 ? numbers[5] : 0;
    if (month >= 1 &&
        month <= 12 &&
        day >= 1 &&
        day <= 31 &&
        hour < 24 &&
        minute < 60 &&
        second < 60) {
      return DateTime(year, month, day, hour, minute, second);
    }
  }
  return bawuEpoch();
}

/// Parses the pagination block shared by the blacklist and log pages.
///
/// The total count comes from the breadcrumbs; the current page from the
/// active pagination item; the total page from the `[N]` link that follows
/// the page list (as in aiotieba).
TiebaPage bawuPagination(Document? document) {
  final totalCount = parseInt(
    document?.querySelector('div.breadcrumbs em')?.text.trim(),
  );
  final pagination = document?.querySelector('div.tbui_pagination');
  final active = pagination?.querySelector('li.active');
  if (active == null) {
    final page = totalCount == 0 ? 0 : 1;
    return TiebaPage(
      pageSize: 0,
      currentPage: page,
      totalPage: page,
      totalCount: totalCount,
      hasMore: false,
      hasPrev: false,
    );
  }
  final currentPage = parseInt(active.text.trim());
  var totalPage = currentPage;
  final bracket = RegExp(r'\[(\d+)\]').firstMatch(pagination?.text ?? '');
  if (bracket != null) {
    totalPage = parseInt(bracket.group(1));
  } else {
    final next = active.parent?.nextElementSibling;
    final digits = RegExp(r'\d+').firstMatch(next?.text ?? '');
    if (digits != null) totalPage = parseInt(digits.group(0));
  }
  return TiebaPage(
    pageSize: 0,
    currentPage: currentPage,
    totalPage: totalPage,
    totalCount: totalCount,
    hasMore: currentPage < totalPage,
    hasPrev: currentPage > 1,
  );
}
