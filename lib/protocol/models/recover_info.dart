import '../core/utils.dart';
import 'bawu_parse.dart';

/// A text fragment of a post waiting to be restored.
class RecoverTextFrag {
  const RecoverTextFrag({required this.text});

  final String text;

  factory RecoverTextFrag.fromJson(Map<String, dynamic> json) {
    return RecoverTextFrag(text: parseString(json['value']));
  }
}

/// An image fragment of a post waiting to be restored.
class RecoverImageFrag {
  const RecoverImageFrag({
    required this.src,
    required this.showWidth,
    required this.showHeight,
    required this.hash,
  });

  /// Thumbnail URL, 720px wide.
  final String src;
  final int showWidth;
  final int showHeight;

  /// Baidu image hash.
  final String hash;

  factory RecoverImageFrag.fromJson(Map<String, dynamic> json) {
    final src = parseString(json['url']);
    return RecoverImageFrag(
      src: src,
      showWidth: parseInt(json['width']),
      showHeight: parseInt(json['height']),
      hash: bawuImageHash(src),
    );
  }
}

/// The parsed body of a post waiting to be restored.
class RecoverContents {
  const RecoverContents({
    required this.texts,
    required this.imgs,
    required this.text,
  });

  final List<RecoverTextFrag> texts;
  final List<RecoverImageFrag> imgs;

  /// Concatenated text fragments.
  final String text;

  factory RecoverContents.fromJson(Map<String, dynamic> json) {
    final texts = <RecoverTextFrag>[];
    for (final item in bawuList(json['content_detail'])) {
      final detail = bawuMap(item);
      if (parseInt(detail['type']) == 1) {
        texts.add(RecoverTextFrag.fromJson(detail));
      }
    }
    final imgs = <RecoverImageFrag>[
      for (final item in bawuList(json['all_pics']))
        RecoverImageFrag.fromJson(bawuMap(item)),
    ];
    return RecoverContents(
      texts: texts,
      imgs: imgs,
      text: texts.map((frag) => frag.text).join(),
    );
  }
}

/// The author of a post waiting to be restored.
class RecoverInfoUser {
  const RecoverInfoUser({
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
  });

  final String portrait;
  final String userName;
  final String nickNameNew;

  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get displayName =>
      userName.isNotEmpty ? userName : '$nickNameNew/$portrait';

  factory RecoverInfoUser.fromJson(Map<String, dynamic> json) {
    return RecoverInfoUser(
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['user_name']),
      nickNameNew: parseString(json['show_nickname']),
    );
  }
}

/// The detailed content of a post waiting to be restored.
class TiebaRecoverInfo {
  const TiebaRecoverInfo({
    required this.contents,
    required this.title,
    required this.tid,
    required this.pid,
    required this.user,
  });

  final RecoverContents contents;
  final String title;
  final int tid;
  final int pid;
  final RecoverInfoUser user;

  /// Title and body combined, as shown in the client.
  String get text => title.isEmpty ? contents.text : '$title\n${contents.text}';

  factory TiebaRecoverInfo.fromJson(Map<String, dynamic> json) {
    final threadInfo = bawuMap(json['thread_info']);
    return TiebaRecoverInfo(
      contents: RecoverContents.fromJson(threadInfo),
      title: parseString(threadInfo['title']),
      tid: parseInt(threadInfo['thread_id']),
      pid: parseInt(threadInfo['post_id']),
      user: RecoverInfoUser.fromJson(bawuMap(json['user_info'])),
    );
  }
}
