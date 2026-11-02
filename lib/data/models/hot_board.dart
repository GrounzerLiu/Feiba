import 'feed.dart';
import 'hot_topic.dart';

class HotTabOption {
  const HotTabOption({required this.code, required this.name});

  final String code;
  final String name;
}

/// Data shown by the hot ranking tab.
class HotBoard {
  const HotBoard({
    required this.feed,
    required this.topics,
    required this.tabs,
  });

  final ThreadFeed feed;
  final List<HotTopic> topics;
  final List<HotTabOption> tabs;
}
