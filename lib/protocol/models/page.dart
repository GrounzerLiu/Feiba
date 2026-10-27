import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// Pagination info shared by list responses.
class TiebaPage {
  const TiebaPage({
    required this.pageSize,
    required this.currentPage,
    required this.totalPage,
    required this.totalCount,
    required this.hasMore,
    required this.hasPrev,
  });

  final int pageSize;
  final int currentPage;
  final int totalPage;
  final int totalCount;
  final bool hasMore;
  final bool hasPrev;

  bool get isEmpty => totalCount == 0;

  factory TiebaPage.empty() => const TiebaPage(
    pageSize: 0,
    currentPage: 0,
    totalPage: 0,
    totalCount: 0,
    hasMore: false,
    hasPrev: false,
  );

  factory TiebaPage.fromJson(Map<String, dynamic> json) {
    return TiebaPage(
      pageSize: parseInt(json['page_size']),
      currentPage: parseInt(json['current_page']),
      totalPage: parseInt(json['total_page']),
      totalCount: parseInt(json['total_count']),
      hasMore: parseInt(json['has_more']) != 0,
      hasPrev: parseInt(json['has_prev']) != 0,
    );
  }

  /// Parses a Page message.
  ///
  /// [computeHasMore] is used by comment pages, where the proto `has_more`
  /// field is unreliable and aiotieba computes it from the page numbers.
  /// [normalizeFirstPage] maps page 0 back to 1 for legacy thread responses.
  factory TiebaPage.fromProto(
    pb.Page proto, {
    bool computeHasMore = false,
    bool normalizeFirstPage = false,
  }) {
    var currentPage = proto.currentPage;
    if (normalizeFirstPage && currentPage == 0 && proto.pageSize != 0) {
      currentPage = 1;
    }
    final hasMore = computeHasMore
        ? currentPage < proto.totalPage
        : proto.hasMore != 0;
    final hasPrev = computeHasMore ? currentPage > 1 : proto.hasPrev != 0;
    return TiebaPage(
      pageSize: proto.pageSize,
      currentPage: currentPage,
      totalPage: proto.totalPage,
      totalCount: proto.totalCount,
      hasMore: hasMore,
      hasPrev: hasPrev,
    );
  }
}
