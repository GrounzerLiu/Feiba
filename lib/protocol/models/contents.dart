import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// Which response message a [Contents] value was parsed from.
///
/// Tieba uses slightly different fragment layouts for thread first posts,
/// replies, comments and shared-thread origins.
enum ContentsKind { thread, post, comment, threadOrigin }

/// A single rich-content fragment.
sealed class ContentFragment {
  const ContentFragment();

  String get text;
}

/// Plain text (also used for phone numbers, topics and wiki entries).
class FragText extends ContentFragment {
  FragText(this.text);

  @override
  String text;
}

/// Emoticon, e.g. image_emoticon25.
class FragEmoji extends ContentFragment {
  const FragEmoji(this.id, this.desc);

  final String id;
  final String desc;

  @override
  String get text => '[表情]';

  String get imageUrl => id.isEmpty
      ? ''
      : 'https://tb2.bdstatic.com/tb/editor/images/client/$id.png';
}

/// Image fragment.
class FragImage extends ContentFragment {
  const FragImage({
    required this.src,
    required this.bigSrc,
    required this.originSrc,
    required this.originSize,
    required this.showWidth,
    required this.showHeight,
    required this.hash,
  });

  final String src;
  final String bigSrc;
  final String originSrc;
  final int originSize;
  final int showWidth;
  final int showHeight;
  final String hash;

  @override
  String get text => '[图片]';

  String get imageUrl => bigSrc.isNotEmpty ? bigSrc : src;

  factory FragImage.fromContent(pb.PbContent proto) {
    final size = proto.bsize.split(',');
    final width = size.isNotEmpty ? parseInt(size[0]) : 0;
    final height = size.length > 1 ? parseInt(size[1]) : 0;
    return FragImage(
      src: proto.cdnSrc,
      bigSrc: proto.bigCdnSrc,
      originSrc: proto.originSrc,
      originSize: proto.originSize,
      showWidth: width,
      showHeight: height,
      hash: _imageHash(proto.cdnSrc),
    );
  }

  factory FragImage.fromMedia(pb.Media proto) {
    return FragImage(
      src: proto.waterPic,
      bigSrc: proto.smallPic,
      originSrc: proto.bigPic,
      originSize: proto.originSize,
      showWidth: proto.width,
      showHeight: proto.height,
      hash: _imageHash(proto.waterPic),
    );
  }

  static final RegExp _hashPattern = RegExp(r'/([a-z0-9]{32,})\.');

  static String _imageHash(String src) {
    final match = _hashPattern.firstMatch(src);
    return match == null ? '' : (match.group(1) ?? '');
  }
}

/// @mention fragment.
class FragAt extends ContentFragment {
  FragAt(this.text, this.userId, this.portrait);

  @override
  String text;
  final int userId;
  final String portrait;

  factory FragAt.fromContent(pb.PbContent proto) {
    return FragAt(
      proto.text,
      proto.uid.toInt(),
      normalizePortrait(proto.portrait),
    );
  }
}

/// Audio fragment.
class FragVoice extends ContentFragment {
  const FragVoice(this.md5, this.duration);

  final String md5;

  /// Duration in seconds.
  final double duration;

  @override
  String get text => '[语音]';

  bool get isValid => md5.isNotEmpty;

  factory FragVoice.fromContent(pb.PbContent proto) {
    return FragVoice(proto.voiceMd5, proto.duringTime / 1000);
  }

  factory FragVoice.fromVoice(pb.Voice proto) {
    return FragVoice(proto.voiceMd5, proto.duringTime / 1000);
  }
}

/// Video fragment.
class FragVideo extends ContentFragment {
  const FragVideo({
    required this.src,
    required this.coverSrc,
    required this.duration,
    required this.width,
    required this.height,
    required this.viewNum,
  });

  final String src;
  final String coverSrc;
  final int duration;
  final int width;
  final int height;
  final int viewNum;

  @override
  String get text => '[视频]';

  bool get isValid => width != 0;

  factory FragVideo.fromContent(pb.PbContent proto) {
    return FragVideo(
      src: proto.link,
      coverSrc: proto.src,
      duration: proto.duringTime,
      width: proto.width,
      height: proto.height,
      viewNum: proto.count,
    );
  }

  factory FragVideo.fromInfo(pb.VideoInfo proto) {
    return FragVideo(
      src: proto.videoUrl,
      coverSrc: proto.thumbnailUrl,
      duration: proto.videoDuration,
      width: proto.videoWidth,
      height: proto.videoHeight,
      viewNum: proto.playCount,
    );
  }
}

/// Link fragment. [text] is the raw URL, matching aiotieba; [title] is the
/// display title returned by the server.
class FragLink extends ContentFragment {
  FragLink({required this.text, required this.title, required this.rawUri});

  @override
  String text;
  final String title;
  final Uri rawUri;

  bool get isExternal => rawUri.path == '/mo/q/checkurl';

  Uri get uri {
    if (!isExternal) return rawUri;
    final target = rawUri.queryParameters['url'];
    if (target == null || target.isEmpty) return rawUri;
    return Uri.tryParse(target) ?? rawUri;
  }

  factory FragLink.fromContent(pb.PbContent proto) {
    return FragLink(
      text: proto.link,
      title: proto.text,
      rawUri: Uri.tryParse(proto.link) ?? Uri(),
    );
  }
}

/// Tieba-plus advertisement fragment.
class FragTiebaPlus extends ContentFragment {
  FragTiebaPlus(this.text, this.url);

  @override
  String text;
  final Uri url;

  factory FragTiebaPlus.fromContent(pb.PbContent proto) {
    return FragTiebaPlus(
      proto.tiebaplusInfo.desc,
      Uri.tryParse(proto.tiebaplusInfo.jumpUrl) ?? Uri(),
    );
  }
}

/// A fragment type the protocol layer does not understand yet.
class FragUnknown extends ContentFragment {
  const FragUnknown(this.data);

  final pb.PbContent data;

  @override
  String get text => '';
}

/// Rich contents of a post-like object.
class Contents {
  Contents({
    required this.objs,
    required this.texts,
    required this.emojis,
    required this.imgs,
    required this.ats,
    required this.links,
    required this.tiebaPluses,
    this.video,
    this.voice,
  });

  /// All fragments in server order.
  final List<ContentFragment> objs;

  /// Fragments that contribute plain text (text, @, links, tieba-plus).
  final List<ContentFragment> texts;
  final List<FragEmoji> emojis;
  final List<FragImage> imgs;
  final List<FragAt> ats;
  final List<FragLink> links;
  final List<FragTiebaPlus> tiebaPluses;
  final FragVideo? video;
  final FragVoice? voice;

  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  /// Text projection matching aiotieba: links contribute their raw URL.
  String get text => texts.map((e) => e.text).join();

  /// Human-oriented projection used by the Flutter UI.
  String get displayText {
    final buffer = StringBuffer();
    for (final fragment in objs) {
      if (fragment is FragText) {
        buffer.write(fragment.text);
      } else if (fragment is FragAt) {
        buffer.write(fragment.text);
      } else if (fragment is FragLink) {
        buffer.write(
          fragment.title.isNotEmpty ? fragment.title : fragment.text,
        );
      } else if (fragment is FragTiebaPlus) {
        buffer.write(fragment.text);
      } else if (fragment is FragEmoji) {
        buffer.write('[表情]');
      } else if (fragment is FragImage) {
        buffer.write('[图片]');
      } else if (fragment is FragVideo) {
        buffer.write('[视频]');
      } else if (fragment is FragVoice) {
        buffer.write('[语音]');
      }
    }
    return buffer.toString();
  }

  factory Contents.fromPlainText(String text) {
    final fragment = FragText(text);
    return Contents(
      objs: <ContentFragment>[fragment],
      texts: <ContentFragment>[fragment],
      emojis: <FragEmoji>[],
      imgs: <FragImage>[],
      ats: <FragAt>[],
      links: <FragLink>[],
      tiebaPluses: <FragTiebaPlus>[],
    );
  }

  factory Contents.empty() => Contents(
    objs: <ContentFragment>[],
    texts: <ContentFragment>[],
    emojis: <FragEmoji>[],
    imgs: <FragImage>[],
    ats: <FragAt>[],
    links: <FragLink>[],
    tiebaPluses: <FragTiebaPlus>[],
  );

  factory Contents.fromThread(pb.ThreadInfo proto) {
    return _build(
      content: proto.firstPostContent,
      kind: ContentsKind.thread,
      videoInfo: proto.videoInfo,
      voiceInfo: proto.voiceInfo,
    );
  }

  factory Contents.fromThreadOrigin(pb.ThreadInfo_OriginThreadInfo proto) {
    return _build(
      content: proto.content,
      kind: ContentsKind.threadOrigin,
      media: proto.media,
      videoInfo: proto.videoInfo,
      voiceInfo: proto.voiceInfo,
    );
  }

  factory Contents.fromPost(pb.Post proto) {
    return _build(content: proto.content, kind: ContentsKind.post);
  }

  factory Contents.fromComment(pb.SubPostList proto) {
    return _build(content: proto.content, kind: ContentsKind.comment);
  }

  /// Builds contents from a raw fragment list (notifications, search).
  factory Contents.fromContentList(
    Iterable<pb.PbContent> content, {
    ContentsKind kind = ContentsKind.comment,
  }) {
    return _build(content: content, kind: kind);
  }

  static Contents _build({
    required Iterable<pb.PbContent> content,
    required ContentsKind kind,
    Iterable<pb.Media>? media,
    pb.VideoInfo? videoInfo,
    Iterable<pb.Voice>? voiceInfo,
  }) {
    final objs = <ContentFragment>[];
    final texts = <ContentFragment>[];
    final emojis = <FragEmoji>[];
    final imgs = <FragImage>[];
    final ats = <FragAt>[];
    final links = <FragLink>[];
    final tiebaPluses = <FragTiebaPlus>[];
    FragVideo? video;
    FragVoice? voice;

    if (kind == ContentsKind.threadOrigin && media != null) {
      for (final item in media) {
        imgs.add(FragImage.fromMedia(item));
      }
    }

    for (final proto in content) {
      final type = proto.type;
      if (type == 0 || type == 9 || type == 18 || type == 27 || type == 40) {
        final fragment = FragText(proto.text);
        texts.add(fragment);
        objs.add(fragment);
      } else if (type == 2 || type == 11) {
        final fragment = FragEmoji(proto.text, proto.c);
        emojis.add(fragment);
        objs.add(fragment);
      } else if (type == 3 || type == 20) {
        if (kind == ContentsKind.threadOrigin) {
          // Images of shared threads live in the media list.
          continue;
        }
        final fragment = FragImage.fromContent(proto);
        imgs.add(fragment);
        objs.add(fragment);
      } else if (type == 4) {
        final fragment = FragAt.fromContent(proto);
        ats.add(fragment);
        texts.add(fragment);
        objs.add(fragment);
      } else if (type == 1) {
        final fragment = FragLink.fromContent(proto);
        links.add(fragment);
        texts.add(fragment);
        objs.add(fragment);
      } else if (type == 10) {
        if (kind == ContentsKind.thread || kind == ContentsKind.threadOrigin) {
          // Thread audio is carried by voice_info instead.
          continue;
        }
        final fragment = FragVoice.fromContent(proto);
        voice = fragment;
        objs.add(fragment);
      } else if (type == 5) {
        if (kind == ContentsKind.thread || kind == ContentsKind.threadOrigin) {
          continue;
        }
        final fragment = FragVideo.fromContent(proto);
        video = fragment;
        objs.add(fragment);
      } else if (type == 35 || type == 36 || type == 37) {
        final fragment = FragTiebaPlus.fromContent(proto);
        tiebaPluses.add(fragment);
        texts.add(fragment);
        objs.add(fragment);
      } else if (type == 34 || type == 52) {
        continue;
      } else {
        objs.add(FragUnknown(proto));
      }
    }

    if (kind == ContentsKind.thread || kind == ContentsKind.threadOrigin) {
      if (videoInfo != null && videoInfo.videoWidth != 0) {
        video = FragVideo.fromInfo(videoInfo);
        objs.add(video);
      }
      if (voiceInfo != null && voiceInfo.isNotEmpty) {
        voice = FragVoice.fromVoice(voiceInfo.first);
        objs.add(voice);
      }
    }

    if (kind == ContentsKind.threadOrigin || kind == ContentsKind.post) {
      if (ats.isNotEmpty && objs.isNotEmpty) {
        ats.removeAt(0);
        objs.removeAt(0);
      }
    }

    if (kind == ContentsKind.threadOrigin) {
      objs.addAll(imgs);
    }

    return Contents(
      objs: objs,
      texts: texts,
      emojis: emojis,
      imgs: imgs,
      ats: ats,
      links: links,
      tiebaPluses: tiebaPluses,
      video: video,
      voice: voice,
    );
  }

  /// Removes the leading reply prefix used by comment replies.
  ///
  /// Returns the replied-to user id, or 0 when no prefix was present.
  int stripReplyPrefix() {
    if (objs.length < 2) return 0;
    final first = objs[0];
    if (first is! FragText || first.text != '回复 ') return 0;
    final second = objs[1];
    final replyToId = second is FragAt ? second.userId : 0;
    if (replyToId == 0) return 0;

    if (ats.isNotEmpty) ats.removeAt(0);
    objs.removeRange(0, 2);
    if (texts.length >= 2) {
      texts.removeRange(0, 2);
    } else {
      texts.clear();
    }
    if (texts.isNotEmpty && texts.first is FragText) {
      final fragment = texts.first as FragText;
      if (fragment.text.startsWith(' :')) {
        fragment.text = fragment.text.substring(2);
      }
    }
    return replyToId;
  }
}
