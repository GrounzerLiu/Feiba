/// A single segment of Tieba rich post content.
///
/// The API returns content as an array of typed nodes instead of plain text.
class ContentNode {
  const ContentNode({
    required this.type,
    this.text = '',
    this.link,
    this.cdnSrc,
    this.bigCdnSrc,
    this.bsize,
    this.width,
    this.height,
  });

  factory ContentNode.fromJson(Map<String, dynamic> json) {
    return ContentNode(
      type: (json['type'] as num?)?.toInt() ?? 0,
      text: (json['text'] ?? '').toString(),
      link: json['link']?.toString(),
      cdnSrc: json['cdn_src']?.toString(),
      bigCdnSrc: json['big_cdn_src']?.toString(),
      bsize: json['bsize']?.toString(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );
  }

  static List<ContentNode> parseList(dynamic value) {
    if (value is! List) return const <ContentNode>[];
    return value
        .whereType<Map>()
        .map((e) => ContentNode.fromJson(e.cast<String, dynamic>()))
        .toList(growable: false);
  }

  /// 0: text, 1: link, 2: emoticon, 3: image, 4: audio, 5: video, 18: topic.
  final int type;
  final String text;
  final String? link;
  final String? cdnSrc;
  final String? bigCdnSrc;
  final String? bsize;
  final int? width;
  final int? height;

  bool get isImage => type == 3 && (cdnSrc != null || bigCdnSrc != null);
  bool get isEmoticon => type == 2;
  bool get isLink => link != null && link!.isNotEmpty;

  /// Best available image url (bigger variant preferred).
  String? get imageUrl => bigCdnSrc ?? cdnSrc;

  /// Public url of a Tieba emoticon, e.g. "image_emoticon25".
  String? get emoticonUrl {
    if (!isEmoticon || text.isEmpty) return null;
    return 'https://tb2.bdstatic.com/tb/editor/images/client/$text.png';
  }

  /// Plain-text projection, used for abstracts and search snippets.
  String get plainText {
    if (isEmoticon) return '[表情]';
    if (isImage) return '[图片]';
    return text;
  }
}

String nodesToPlainText(List<ContentNode> nodes) =>
    nodes.map((n) => n.plainText).join();
