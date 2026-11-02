import 'thread.dart';

/// A topic entry returned by the home hot list.
class RecommendTopic {
  const RecommendTopic({
    required this.id,
    required this.name,
    this.description = '',
    this.discussNum = 0,
    this.tag = 0,
    this.imageUrl,
  });

  final int id;
  final String name;
  final String description;
  final int discussNum;
  final int tag;
  final String? imageUrl;
}

/// One tab in the home hot list.
class HotThreadTab {
  const HotThreadTab({required this.code, required this.name});

  final String code;
  final String name;
}

/// A page returned by the home hot list endpoint.
class HotThreadPage {
  const HotThreadPage({
    required this.topics,
    required this.tabs,
    required this.threads,
  });

  final List<RecommendTopic> topics;
  final List<HotThreadTab> tabs;
  final List<TiebaThread> threads;
}
