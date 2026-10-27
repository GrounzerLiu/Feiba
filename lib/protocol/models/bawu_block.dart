import 'package:html/dom.dart';

import '../core/utils.dart';
import 'bawu_parse.dart';
import 'page.dart';

/// A banned user waiting to be unblocked.
class BawuBlock {
  const BawuBlock({
    required this.userId,
    required this.userName,
    required this.nickNameNew,
    required this.day,
    required this.blockTime,
  });

  final int userId;
  final String userName;
  final String nickNameNew;

  /// Number of days the user was banned for.
  final int day;

  /// Time the ban started.
  final DateTime blockTime;

  factory BawuBlock.fromElement(Element item) {
    final anchor = item.querySelector('a');
    return BawuBlock(
      userId: parseInt(anchor?.attributes['attr-uid']),
      userName: anchor?.attributes['attr-un'] ?? '',
      nickNameNew: anchor?.attributes['attr-nn'] ?? '',
      day: parseInt(anchor?.attributes['attr-blockday']),
      blockTime: bawuDateTime(
        item.querySelector('span.block_list_item_time')?.text ?? '',
      ),
    );
  }
}

/// One page of banned users waiting to be unblocked.
class BawuBlocks {
  const BawuBlocks({required this.objs, required this.page});

  final List<BawuBlock> objs;
  final TiebaPage page;

  bool get hasMore => page.hasMore;
  bool get isEmpty => objs.isEmpty;

  factory BawuBlocks.fromJson(Map<String, dynamic> json) {
    final data = bawuMap(json['data']);
    final fragment = bawuParseFragment(parseString(data['content']));
    final page = bawuMap(data['page']);
    final currentPage = parseInt(page['pn']);
    return BawuBlocks(
      objs: <BawuBlock>[
        for (final item in fragment.querySelectorAll('li'))
          BawuBlock.fromElement(item),
      ],
      page: TiebaPage(
        pageSize: parseInt(page['size']),
        currentPage: currentPage,
        totalPage: parseInt(page['total_page']),
        totalCount: parseInt(page['total_count']),
        hasMore: bawuFlag(page['have_next']),
        hasPrev: currentPage > 1,
      ),
    );
  }
}

/// A ban appeal filed by a banned user.
class BawuAppeal {
  const BawuAppeal({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickName,
    required this.appealId,
    required this.appealReason,
    required this.appealTime,
    required this.punishReason,
    required this.punishTime,
    required this.punishDay,
    required this.opName,
  });

  final int userId;
  final String portrait;
  final String userName;
  final String nickName;

  final int appealId;
  final String appealReason;

  /// Ten-digit UNIX timestamp in seconds.
  final int appealTime;

  final String punishReason;
  final int punishTime;
  final int punishDay;
  final String opName;

  factory BawuAppeal.fromJson(Map<String, dynamic> json) {
    final user = bawuMap(json['user']);
    return BawuAppeal(
      userId: parseInt(user['id']),
      portrait: normalizePortrait(parseString(user['portrait'])),
      userName: parseString(user['name']),
      nickName: parseString(user['name_show']),
      appealId: parseInt(json['appeal_id']),
      appealReason: parseString(json['appeal_reason']),
      appealTime: parseInt(json['appeal_time']),
      punishReason: parseString(json['punish_reason']),
      punishTime: parseInt(json['punish_start_time']),
      punishDay: parseInt(json['punish_day_num']),
      opName: parseString(json['operate_man']),
    );
  }
}

/// One page of ban appeals.
class BawuAppeals {
  const BawuAppeals({required this.objs, required this.hasMore});

  final List<BawuAppeal> objs;
  final bool hasMore;

  bool get isEmpty => objs.isEmpty;

  factory BawuAppeals.fromJson(Map<String, dynamic> json) {
    final data = bawuMap(json['data']);
    return BawuAppeals(
      objs: <BawuAppeal>[
        for (final item in bawuList(data['appeal_list']))
          BawuAppeal.fromJson(bawuMap(item)),
      ],
      hasMore: bawuFlag(data['has_more']),
    );
  }
}
