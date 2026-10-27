// This is a generated file - do not edit.
//
// Generated from PostInfoList.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Agree.pb.dart' as $4;
import 'Media.pb.dart' as $0;
import 'PbContent.pb.dart' as $5;
import 'PollInfo.pb.dart' as $2;
import 'VideoInfo.pb.dart' as $3;
import 'Voice.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PostInfoList_PostInfoContent_Abstract extends $pb.GeneratedMessage {
  factory PostInfoList_PostInfoContent_Abstract({
    $core.int? type,
    $core.String? text,
    $core.String? link,
    $core.String? src,
    $core.String? un,
    $core.String? duringTime,
    $core.String? voiceMd5,
  }) {
    final result = PostInfoList_PostInfoContent_Abstract._();
    if (type != null) result.type = type;
    if (text != null) result.text = text;
    if (link != null) result.link = link;
    if (src != null) result.src = src;
    if (un != null) result.un = un;
    if (duringTime != null) result.duringTime = duringTime;
    if (voiceMd5 != null) result.voiceMd5 = voiceMd5;
    return result;
  }

  PostInfoList_PostInfoContent_Abstract._();

  factory PostInfoList_PostInfoContent_Abstract.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList_PostInfoContent_Abstract()..mergeFromBuffer(data, registry);
  factory PostInfoList_PostInfoContent_Abstract.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList_PostInfoContent_Abstract()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostInfoList.PostInfoContent.Abstract',
      createEmptyInstance:
          PostInfoList_PostInfoContent_Abstract.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aOS(3, _omitFieldNames ? '' : 'link')
    ..aOS(4, _omitFieldNames ? '' : 'src')
    ..aOS(5, _omitFieldNames ? '' : 'un')
    ..aOS(6, _omitFieldNames ? '' : 'duringTime')
    ..aOS(7, _omitFieldNames ? '' : 'voiceMd5')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList_PostInfoContent_Abstract clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList_PostInfoContent_Abstract copyWith(
          void Function(PostInfoList_PostInfoContent_Abstract) updates) =>
      super.copyWith((message) =>
              updates(message as PostInfoList_PostInfoContent_Abstract))
          as PostInfoList_PostInfoContent_Abstract;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PostInfoList_PostInfoContent_Abstract() / PostInfoList_PostInfoContent_Abstract.new instead')
  static PostInfoList_PostInfoContent_Abstract create() =>
      PostInfoList_PostInfoContent_Abstract._();
  static $pb.GeneratedMessage $_createMessage() =>
      PostInfoList_PostInfoContent_Abstract._();
  @$core.override
  PostInfoList_PostInfoContent_Abstract createEmptyInstance() =>
      PostInfoList_PostInfoContent_Abstract._();
  @$core.pragma('dart2js:noInline')
  static PostInfoList_PostInfoContent_Abstract getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              PostInfoList_PostInfoContent_Abstract>(
          PostInfoList_PostInfoContent_Abstract.$_createMessage);
  static PostInfoList_PostInfoContent_Abstract? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get link => $_getSZ(2);
  @$pb.TagNumber(3)
  set link($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearLink() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get src => $_getSZ(3);
  @$pb.TagNumber(4)
  set src($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSrc() => $_has(3);
  @$pb.TagNumber(4)
  void clearSrc() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get un => $_getSZ(4);
  @$pb.TagNumber(5)
  set un($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUn() => $_has(4);
  @$pb.TagNumber(5)
  void clearUn() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get duringTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set duringTime($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDuringTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearDuringTime() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get voiceMd5 => $_getSZ(6);
  @$pb.TagNumber(7)
  set voiceMd5($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVoiceMd5() => $_has(6);
  @$pb.TagNumber(7)
  void clearVoiceMd5() => $_clearField(7);
}

class PostInfoList_PostInfoContent extends $pb.GeneratedMessage {
  factory PostInfoList_PostInfoContent({
    $core.Iterable<PostInfoList_PostInfoContent_Abstract>? postContent,
    $fixnum.Int64? createTime,
    $fixnum.Int64? postType,
    $fixnum.Int64? postId,
  }) {
    final result = PostInfoList_PostInfoContent._();
    if (postContent != null) result.postContent.addAll(postContent);
    if (createTime != null) result.createTime = createTime;
    if (postType != null) result.postType = postType;
    if (postId != null) result.postId = postId;
    return result;
  }

  PostInfoList_PostInfoContent._();

  factory PostInfoList_PostInfoContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList_PostInfoContent()..mergeFromBuffer(data, registry);
  factory PostInfoList_PostInfoContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList_PostInfoContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostInfoList.PostInfoContent',
      createEmptyInstance: PostInfoList_PostInfoContent.$_createMessage)
    ..pPM<PostInfoList_PostInfoContent_Abstract>(
        1, _omitFieldNames ? '' : 'postContent',
        subBuilder: PostInfoList_PostInfoContent_Abstract.$_createMessage)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'createTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'postType', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'postId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList_PostInfoContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList_PostInfoContent copyWith(
          void Function(PostInfoList_PostInfoContent) updates) =>
      super.copyWith(
              (message) => updates(message as PostInfoList_PostInfoContent))
          as PostInfoList_PostInfoContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PostInfoList_PostInfoContent() / PostInfoList_PostInfoContent.new instead')
  static PostInfoList_PostInfoContent create() =>
      PostInfoList_PostInfoContent._();
  static $pb.GeneratedMessage $_createMessage() =>
      PostInfoList_PostInfoContent._();
  @$core.override
  PostInfoList_PostInfoContent createEmptyInstance() =>
      PostInfoList_PostInfoContent._();
  @$core.pragma('dart2js:noInline')
  static PostInfoList_PostInfoContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostInfoList_PostInfoContent>(
          PostInfoList_PostInfoContent.$_createMessage);
  static PostInfoList_PostInfoContent? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PostInfoList_PostInfoContent_Abstract> get postContent =>
      $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get createTime => $_getI64(1);
  @$pb.TagNumber(2)
  set createTime($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreateTime() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get postType => $_getI64(2);
  @$pb.TagNumber(3)
  set postType($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPostType() => $_has(2);
  @$pb.TagNumber(3)
  void clearPostType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get postId => $_getI64(3);
  @$pb.TagNumber(4)
  set postId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPostId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPostId() => $_clearField(4);
}

class PostInfoList extends $pb.GeneratedMessage {
  factory PostInfoList({
    $fixnum.Int64? forumId,
    $fixnum.Int64? threadId,
    $fixnum.Int64? postId,
    $core.int? createTime,
    $core.String? forumName,
    $core.String? title,
    $core.Iterable<PostInfoList_PostInfoContent>? content,
    $core.String? userName,
    $core.Iterable<$0.Media>? media,
    $core.int? replyNum,
    $fixnum.Int64? userId,
    $core.String? userPortrait,
    $core.Iterable<$1.Voice>? voiceInfo,
    $fixnum.Int64? threadType,
    $2.PollInfo? pollInfo,
    $3.VideoInfo? videoInfo,
    $core.int? freqNum,
    $core.String? nameShow,
    $core.int? shareNum,
    $4.Agree? agree,
    $core.int? isShareThread,
    $core.Iterable<$5.PbContent>? firstPostContent,
  }) {
    final result = PostInfoList._();
    if (forumId != null) result.forumId = forumId;
    if (threadId != null) result.threadId = threadId;
    if (postId != null) result.postId = postId;
    if (createTime != null) result.createTime = createTime;
    if (forumName != null) result.forumName = forumName;
    if (title != null) result.title = title;
    if (content != null) result.content.addAll(content);
    if (userName != null) result.userName = userName;
    if (media != null) result.media.addAll(media);
    if (replyNum != null) result.replyNum = replyNum;
    if (userId != null) result.userId = userId;
    if (userPortrait != null) result.userPortrait = userPortrait;
    if (voiceInfo != null) result.voiceInfo.addAll(voiceInfo);
    if (threadType != null) result.threadType = threadType;
    if (pollInfo != null) result.pollInfo = pollInfo;
    if (videoInfo != null) result.videoInfo = videoInfo;
    if (freqNum != null) result.freqNum = freqNum;
    if (nameShow != null) result.nameShow = nameShow;
    if (shareNum != null) result.shareNum = shareNum;
    if (agree != null) result.agree = agree;
    if (isShareThread != null) result.isShareThread = isShareThread;
    if (firstPostContent != null)
      result.firstPostContent.addAll(firstPostContent);
    return result;
  }

  PostInfoList._();

  factory PostInfoList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList()..mergeFromBuffer(data, registry);
  factory PostInfoList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PostInfoList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostInfoList',
      createEmptyInstance: PostInfoList.$_createMessage)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'forumId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'threadId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'postId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(5, _omitFieldNames ? '' : 'createTime', fieldType: $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'forumName')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..pPM<PostInfoList_PostInfoContent>(8, _omitFieldNames ? '' : 'content',
        subBuilder: PostInfoList_PostInfoContent.$_createMessage)
    ..aOS(10, _omitFieldNames ? '' : 'userName')
    ..pPM<$0.Media>(16, _omitFieldNames ? '' : 'media',
        subBuilder: $0.Media.$_createMessage)
    ..aI(17, _omitFieldNames ? '' : 'replyNum', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(18, _omitFieldNames ? '' : 'userId')
    ..aOS(19, _omitFieldNames ? '' : 'userPortrait')
    ..pPM<$1.Voice>(23, _omitFieldNames ? '' : 'voiceInfo',
        subBuilder: $1.Voice.$_createMessage)
    ..a<$fixnum.Int64>(
        26, _omitFieldNames ? '' : 'threadType', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.PollInfo>(28, _omitFieldNames ? '' : 'pollInfo',
        subBuilder: $2.PollInfo.$_createMessage)
    ..aOM<$3.VideoInfo>(29, _omitFieldNames ? '' : 'videoInfo',
        subBuilder: $3.VideoInfo.$_createMessage)
    ..aI(33, _omitFieldNames ? '' : 'freqNum')
    ..aOS(35, _omitFieldNames ? '' : 'nameShow')
    ..aI(39, _omitFieldNames ? '' : 'shareNum')
    ..aOM<$4.Agree>(40, _omitFieldNames ? '' : 'agree',
        subBuilder: $4.Agree.$_createMessage)
    ..aI(44, _omitFieldNames ? '' : 'isShareThread')
    ..pPM<$5.PbContent>(49, _omitFieldNames ? '' : 'firstPostContent',
        subBuilder: $5.PbContent.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostInfoList copyWith(void Function(PostInfoList) updates) =>
      super.copyWith((message) => updates(message as PostInfoList))
          as PostInfoList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PostInfoList() / PostInfoList.new instead')
  static PostInfoList create() => PostInfoList._();
  static $pb.GeneratedMessage $_createMessage() => PostInfoList._();
  @$core.override
  PostInfoList createEmptyInstance() => PostInfoList._();
  @$core.pragma('dart2js:noInline')
  static PostInfoList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PostInfoList>(
          PostInfoList.$_createMessage);
  static PostInfoList? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get forumId => $_getI64(0);
  @$pb.TagNumber(1)
  set forumId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasForumId() => $_has(0);
  @$pb.TagNumber(1)
  void clearForumId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get threadId => $_getI64(1);
  @$pb.TagNumber(2)
  set threadId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasThreadId() => $_has(1);
  @$pb.TagNumber(2)
  void clearThreadId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get postId => $_getI64(2);
  @$pb.TagNumber(3)
  set postId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPostId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPostId() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.int get createTime => $_getIZ(3);
  @$pb.TagNumber(5)
  set createTime($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasCreateTime() => $_has(3);
  @$pb.TagNumber(5)
  void clearCreateTime() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get forumName => $_getSZ(4);
  @$pb.TagNumber(6)
  set forumName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasForumName() => $_has(4);
  @$pb.TagNumber(6)
  void clearForumName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(7)
  set title($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(7)
  void clearTitle() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<PostInfoList_PostInfoContent> get content => $_getList(6);

  @$pb.TagNumber(10)
  $core.String get userName => $_getSZ(7);
  @$pb.TagNumber(10)
  set userName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(10)
  $core.bool hasUserName() => $_has(7);
  @$pb.TagNumber(10)
  void clearUserName() => $_clearField(10);

  @$pb.TagNumber(16)
  $pb.PbList<$0.Media> get media => $_getList(8);

  @$pb.TagNumber(17)
  $core.int get replyNum => $_getIZ(9);
  @$pb.TagNumber(17)
  set replyNum($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(17)
  $core.bool hasReplyNum() => $_has(9);
  @$pb.TagNumber(17)
  void clearReplyNum() => $_clearField(17);

  @$pb.TagNumber(18)
  $fixnum.Int64 get userId => $_getI64(10);
  @$pb.TagNumber(18)
  set userId($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(18)
  $core.bool hasUserId() => $_has(10);
  @$pb.TagNumber(18)
  void clearUserId() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get userPortrait => $_getSZ(11);
  @$pb.TagNumber(19)
  set userPortrait($core.String value) => $_setString(11, value);
  @$pb.TagNumber(19)
  $core.bool hasUserPortrait() => $_has(11);
  @$pb.TagNumber(19)
  void clearUserPortrait() => $_clearField(19);

  @$pb.TagNumber(23)
  $pb.PbList<$1.Voice> get voiceInfo => $_getList(12);

  @$pb.TagNumber(26)
  $fixnum.Int64 get threadType => $_getI64(13);
  @$pb.TagNumber(26)
  set threadType($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(26)
  $core.bool hasThreadType() => $_has(13);
  @$pb.TagNumber(26)
  void clearThreadType() => $_clearField(26);

  @$pb.TagNumber(28)
  $2.PollInfo get pollInfo => $_getN(14);
  @$pb.TagNumber(28)
  set pollInfo($2.PollInfo value) => $_setField(28, value);
  @$pb.TagNumber(28)
  $core.bool hasPollInfo() => $_has(14);
  @$pb.TagNumber(28)
  void clearPollInfo() => $_clearField(28);
  @$pb.TagNumber(28)
  $2.PollInfo ensurePollInfo() => $_ensure(14);

  @$pb.TagNumber(29)
  $3.VideoInfo get videoInfo => $_getN(15);
  @$pb.TagNumber(29)
  set videoInfo($3.VideoInfo value) => $_setField(29, value);
  @$pb.TagNumber(29)
  $core.bool hasVideoInfo() => $_has(15);
  @$pb.TagNumber(29)
  void clearVideoInfo() => $_clearField(29);
  @$pb.TagNumber(29)
  $3.VideoInfo ensureVideoInfo() => $_ensure(15);

  @$pb.TagNumber(33)
  $core.int get freqNum => $_getIZ(16);
  @$pb.TagNumber(33)
  set freqNum($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(33)
  $core.bool hasFreqNum() => $_has(16);
  @$pb.TagNumber(33)
  void clearFreqNum() => $_clearField(33);

  @$pb.TagNumber(35)
  $core.String get nameShow => $_getSZ(17);
  @$pb.TagNumber(35)
  set nameShow($core.String value) => $_setString(17, value);
  @$pb.TagNumber(35)
  $core.bool hasNameShow() => $_has(17);
  @$pb.TagNumber(35)
  void clearNameShow() => $_clearField(35);

  @$pb.TagNumber(39)
  $core.int get shareNum => $_getIZ(18);
  @$pb.TagNumber(39)
  set shareNum($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(39)
  $core.bool hasShareNum() => $_has(18);
  @$pb.TagNumber(39)
  void clearShareNum() => $_clearField(39);

  @$pb.TagNumber(40)
  $4.Agree get agree => $_getN(19);
  @$pb.TagNumber(40)
  set agree($4.Agree value) => $_setField(40, value);
  @$pb.TagNumber(40)
  $core.bool hasAgree() => $_has(19);
  @$pb.TagNumber(40)
  void clearAgree() => $_clearField(40);
  @$pb.TagNumber(40)
  $4.Agree ensureAgree() => $_ensure(19);

  @$pb.TagNumber(44)
  $core.int get isShareThread => $_getIZ(20);
  @$pb.TagNumber(44)
  set isShareThread($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(44)
  $core.bool hasIsShareThread() => $_has(20);
  @$pb.TagNumber(44)
  void clearIsShareThread() => $_clearField(44);

  @$pb.TagNumber(49)
  $pb.PbList<$5.PbContent> get firstPostContent => $_getList(21);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
