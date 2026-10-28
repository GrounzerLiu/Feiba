/// One entry in the Tieba hot-topic ranking.
class HotTopic {
  const HotTopic({
    required this.id,
    required this.name,
    this.description = '',
    this.discussNum = 0,
    this.imageUrl,
    this.rank = 0,
    this.tag = 0,
    this.isVideo = false,
  });

  final int id;
  final String name;
  final String description;
  final int discussNum;
  final String? imageUrl;
  final int rank;
  final int tag;
  final bool isVideo;
}
