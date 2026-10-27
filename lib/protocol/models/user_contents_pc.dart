import '../core/enums.dart';
import '../core/exceptions.dart';
import '../core/utils.dart';
import 'contents.dart';

/// Author block of a PC user-post item.
///
/// Mirrors aiotieba's `UserInfo_pcu`.
class UserInfoPcu {
  const UserInfoPcu({
    required this.userId,
    required this.portrait,
    required this.userName,
    required this.nickNameNew,
    required this.gender,
    required this.privLike,
    required this.privReply,
  });

  const UserInfoPcu.empty()
    : userId = 0,
      portrait = '',
      userName = '',
      nickNameNew = '',
      gender = Gender.unknown,
      privLike = PrivLike.visible,
      privReply = PrivReply.all;

  final int userId;
  final String portrait;
  final String userName;
  final String nickNameNew;

  final Gender gender;

  /// Visibility of the user's followed-forum list.
  final PrivLike privLike;

  /// Who is allowed to comment on the user's posts.
  final PrivReply privReply;

  bool get isValid => userId != 0;

  String get nickName => nickNameNew;

  String get showName => nickNameNew.isNotEmpty ? nickNameNew : userName;

  String get logName {
    if (userName.isNotEmpty) return userName;
    if (portrait.isNotEmpty) return '$nickNameNew/$portrait';
    return '$userId';
  }

  factory UserInfoPcu.fromJson(Map<String, dynamic> json) {
    final privSets = _asMap(json['priv_sets']);
    // A zero or missing privilege means the default public setting.
    final like = privSets == null ? 0 : parseInt(privSets['like']);
    final reply = privSets == null ? 0 : parseInt(privSets['reply']);
    return UserInfoPcu(
      userId: parseInt(json['id']),
      portrait: normalizePortrait(parseString(json['portrait'])),
      userName: parseString(json['name']),
      nickNameNew: parseString(json['name_show']),
      gender: Gender.fromValue(parseInt(json['gender'])),
      privLike: like == 0 ? PrivLike.visible : PrivLike.fromValue(like),
      privReply: reply == 0 ? PrivReply.all : PrivReply.fromValue(reply),
    );
  }
}

/// Parent forum of a PC user post.
///
/// Mirrors aiotieba's `Forum_pcup`.
class ForumPcup {
  const ForumPcup({
    required this.fid,
    required this.fname,
    required this.memberNum,
    required this.postNum,
    required this.isLiked,
  });

  const ForumPcup.empty()
    : fid = 0,
      fname = '',
      memberNum = 0,
      postNum = 0,
      isLiked = false;

  final int fid;
  final String fname;
  final int memberNum;
  final int postNum;
  final bool isLiked;

  bool get isValid => fid != 0;

  factory ForumPcup.fromJson(Map<String, dynamic> json) {
    return ForumPcup(
      fid: parseInt(json['id']),
      fname: parseString(json['name']),
      memberNum: parseInt(json['member_num']),
      postNum: parseInt(json['post_num']),
      isLiked: _asBool(json['is_liked']),
    );
  }
}

/// Parent thread of a PC user post.
///
/// Mirrors aiotieba's `Thread_pcup`.
class ThreadPcup {
  const ThreadPcup({
    required this.contents,
    required this.title,
    required this.fid,
    required this.fname,
    required this.tid,
    required this.pid,
    required this.user,
    required this.forum,
    required this.type,
    required this.viewNum,
    required this.replyNum,
    required this.shareNum,
    required this.agree,
    required this.disagree,
    required this.createTime,
    required this.lastTime,
    required this.isGood,
    required this.isTop,
    required this.isDeleted,
  });

  final Contents contents;
  final String title;

  final int fid;
  final String fname;
  final int tid;
  final int pid;
  final UserInfoPcu user;
  final ForumPcup forum;

  final ThreadType type;
  final int viewNum;
  final int replyNum;
  final int shareNum;
  final int agree;
  final int disagree;
  final int createTime;
  final int lastTime;
  final bool isGood;
  final bool isTop;
  final bool isDeleted;

  bool get isValid => tid != 0;

  int get authorId => user.userId;

  String get text => title.isEmpty ? contents.text : '$title\n${contents.text}';

  DateTime get createDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  DateTime get lastDateTime =>
      DateTime.fromMillisecondsSinceEpoch(lastTime * 1000);

  factory ThreadPcup.fromJson(Map<String, dynamic> json) {
    final agreeMap = _asMap(json['agree']);
    return ThreadPcup(
      contents: _buildContents(json['first_post_content']),
      title: parseString(json['title']),
      fid: parseInt(json['fid']),
      fname: parseString(json['fname']),
      tid: parseInt(json['tid']),
      pid: parseInt(json['first_post_id']),
      user: UserInfoPcu.fromJson(_requireMap(json['author'], 'author')),
      forum: ForumPcup.fromJson(_requireMap(json['forum_info'], 'forum_info')),
      type: ThreadType.fromValue(parseInt(json['thread_type'])),
      viewNum: parseInt(json['view_num']),
      replyNum: parseInt(json['reply_num']),
      shareNum: parseInt(json['share_num']),
      agree: agreeMap == null ? 0 : parseInt(agreeMap['agree_num']),
      disagree: agreeMap == null ? 0 : parseInt(agreeMap['disagree_num']),
      createTime: parseInt(json['create_time']),
      lastTime: parseInt(json['last_time_int']),
      isGood: _asBool(json['is_good']),
      isTop: _asBool(json['is_top']),
      isDeleted: _asBool(json['is_deleted']),
    );
  }
}

/// One reply published by a user, as returned by the PC web endpoint.
///
/// Mirrors aiotieba's `PcUserPost`.
class PcUserPost {
  const PcUserPost({
    required this.contents,
    required this.fid,
    required this.ppid,
    required this.pid,
    required this.user,
    required this.thread,
    required this.contentType,
    required this.createTime,
  });

  final Contents contents;

  final int fid;

  /// Parent reply id.
  final int ppid;
  final int pid;
  final UserInfoPcu user;
  final ThreadPcup thread;

  final ContentType contentType;
  final int createTime;

  String get text => contents.text;

  int get authorId => user.userId;

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000);

  factory PcUserPost.fromJson(Map<String, dynamic> json) {
    final thread = ThreadPcup.fromJson(
      _requireMap(json['thread_info'], 'thread_info'),
    );
    final postInfo = _asMap(json['post_info']);
    final Contents contents;
    final int ppid;
    final int pid;
    final UserInfoPcu user;
    final int createTime;
    if (postInfo != null && postInfo.isNotEmpty) {
      contents = _buildContents(postInfo['content']);
      ppid = int.tryParse(parseString(postInfo['quote_id'])) ?? 0;
      pid = parseInt(postInfo['id']);
      user = UserInfoPcu.fromJson(_requireMap(postInfo['author'], 'author'));
      createTime = parseInt(postInfo['time']);
    } else {
      // A thread first post carries no post_info; reuse the thread block.
      contents = thread.contents;
      ppid = 0;
      pid = thread.pid;
      user = thread.user;
      createTime = thread.createTime;
    }
    return PcUserPost(
      contents: contents,
      fid: thread.fid,
      ppid: ppid,
      pid: pid,
      user: user,
      thread: thread,
      contentType: ContentType.fromValue(parseInt(json['type'])),
      createTime: createTime,
    );
  }

  @override
  bool operator ==(Object other) => other is PcUserPost && other.pid == pid;

  @override
  int get hashCode => pid.hashCode;
}

/// One page of PC user replies.
///
/// Mirrors aiotieba's `PcUserPosts`.
class PcUserPosts {
  const PcUserPosts({required this.objs});

  final List<PcUserPost> objs;

  bool get isEmpty => objs.isEmpty;
  bool get isNotEmpty => objs.isNotEmpty;

  factory PcUserPosts.fromJson(Map<String, dynamic> data) {
    return PcUserPosts(
      objs: <PcUserPost>[
        for (final item in _asList(data['list']))
          if (item is Map) PcUserPost.fromJson(item.cast<String, dynamic>()),
      ],
    );
  }
}

/// Builds rich contents from the PC web fragment list.
Contents _buildContents(dynamic rawContent) {
  final objs = <ContentFragment>[];
  final texts = <ContentFragment>[];
  final emojis = <FragEmoji>[];
  final imgs = <FragImage>[];
  final ats = <FragAt>[];
  final links = <FragLink>[];
  FragVideo? video;
  FragVoice? voice;

  for (final item in _asList(rawContent)) {
    if (item is! Map) continue;
    final map = item.cast<String, dynamic>();
    final type = parseInt(map['type']);
    if (type == 0 || type == 9 || type == 18 || type == 27 || type == 40) {
      final fragment = FragText(parseString(map['text']));
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 2 || type == 11) {
      final fragment = FragEmoji(
        parseString(map['text']),
        parseString(map['c']),
      );
      emojis.add(fragment);
      objs.add(fragment);
    } else if (type == 3 || type == 20) {
      final size = parseString(map['bsize']).split(',');
      final fragment = FragImage(
        src: parseString(map['cdn_src']),
        bigSrc: parseString(map['big_cdn_src']),
        originSrc: parseString(map['origin_src']),
        originSize: 0,
        showWidth: size.isNotEmpty ? parseInt(size[0]) : 0,
        showHeight: size.length > 1 ? parseInt(size[1]) : 0,
        hash: _imageHash(parseString(map['cdn_src'])),
      );
      imgs.add(fragment);
      objs.add(fragment);
    } else if (type == 4) {
      final fragment = FragAt(
        parseString(map['text']),
        parseInt(map['uid']),
        normalizePortrait(parseString(map['portrait'])),
      );
      ats.add(fragment);
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 1) {
      final link = parseString(map['link']);
      final fragment = FragLink(
        text: link,
        title: parseString(map['text']),
        rawUri: Uri.tryParse(link) ?? Uri(),
      );
      links.add(fragment);
      texts.add(fragment);
      objs.add(fragment);
    } else if (type == 5) {
      final fragment = FragVideo(
        src: parseString(map['link']),
        coverSrc: parseString(map['src']),
        duration: parseInt(map['during_time']),
        width: parseInt(map['width']),
        height: parseInt(map['height']),
        viewNum: 0,
      );
      video = fragment;
      objs.add(fragment);
    } else if (type == 10) {
      final fragment = FragVoice(
        parseString(map['voice_md5']),
        parseInt(map['during_time']) / 1000,
      );
      voice = fragment;
      objs.add(fragment);
    }
    // Other fragment types carry no renderable payload and are skipped.
  }

  return Contents(
    objs: objs,
    texts: texts,
    emojis: emojis,
    imgs: imgs,
    ats: ats,
    links: links,
    tiebaPluses: const <FragTiebaPlus>[],
    video: video,
    voice: voice,
  );
}

final RegExp _imageHashPattern = RegExp(r'/([a-z0-9]{32,})\.');

String _imageHash(String src) {
  final match = _imageHashPattern.firstMatch(src);
  return match == null ? '' : (match.group(1) ?? '');
}

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  return null;
}

Map<String, dynamic> _requireMap(dynamic value, String name) {
  final map = _asMap(value);
  if (map == null) {
    throw TiebaFormatException('$name is missing');
  }
  return map;
}

List<dynamic> _asList(dynamic value) =>
    value is List ? value : const <dynamic>[];

bool _asBool(dynamic value) {
  if (value is bool) return value;
  return parseInt(value) != 0;
}
