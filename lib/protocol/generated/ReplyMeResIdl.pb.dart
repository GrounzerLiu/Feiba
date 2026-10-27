// This is a generated file - do not edit.
//
// Generated from ReplyMeResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;
import 'Page.pb.dart' as $1;
import 'PbContent.pb.dart' as $3;
import 'User.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo
    extends $pb.GeneratedMessage {
  factory ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo({
    $core.Iterable<$3.PbContent>? content,
  }) {
    final result = ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo._();
    if (content != null) result.content.addAll(content);
    return result;
  }

  ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo._();

  factory ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo()
        ..mergeFromBuffer(data, registry);
  factory ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeResIdl.DataRes.ReplyList.NewFloorInfo',
      createEmptyInstance:
          ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.$_createMessage)
    ..pPM<$3.PbContent>(1, _omitFieldNames ? '' : 'content',
        subBuilder: $3.PbContent.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo copyWith(
          void Function(ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo)
              updates) =>
      super.copyWith((message) =>
              updates(message as ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo))
          as ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo() / ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.new instead')
  static ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo create() =>
      ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo._();
  @$core.override
  ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo createEmptyInstance() =>
      ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo>(
          ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.$_createMessage);
  static ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$3.PbContent> get content => $_getList(0);
}

class ReplyMeResIdl_DataRes_ReplyList extends $pb.GeneratedMessage {
  factory ReplyMeResIdl_DataRes_ReplyList({
    $fixnum.Int64? threadId,
    $fixnum.Int64? postId,
    $core.int? time,
    $core.String? fname,
    $core.String? content,
    $core.int? isFloor,
    $core.String? quoteContent,
    $2.User? replyer,
    $fixnum.Int64? quotePid,
    $2.User? quoteUser,
    $2.User? threadAuthorUser,
    $core.Iterable<ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo>? newFloorInfo,
  }) {
    final result = ReplyMeResIdl_DataRes_ReplyList._();
    if (threadId != null) result.threadId = threadId;
    if (postId != null) result.postId = postId;
    if (time != null) result.time = time;
    if (fname != null) result.fname = fname;
    if (content != null) result.content = content;
    if (isFloor != null) result.isFloor = isFloor;
    if (quoteContent != null) result.quoteContent = quoteContent;
    if (replyer != null) result.replyer = replyer;
    if (quotePid != null) result.quotePid = quotePid;
    if (quoteUser != null) result.quoteUser = quoteUser;
    if (threadAuthorUser != null) result.threadAuthorUser = threadAuthorUser;
    if (newFloorInfo != null) result.newFloorInfo.addAll(newFloorInfo);
    return result;
  }

  ReplyMeResIdl_DataRes_ReplyList._();

  factory ReplyMeResIdl_DataRes_ReplyList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes_ReplyList()..mergeFromBuffer(data, registry);
  factory ReplyMeResIdl_DataRes_ReplyList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes_ReplyList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeResIdl.DataRes.ReplyList',
      createEmptyInstance: ReplyMeResIdl_DataRes_ReplyList.$_createMessage)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'threadId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'postId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(3, _omitFieldNames ? '' : 'time', fieldType: $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'fname')
    ..aOS(6, _omitFieldNames ? '' : 'content')
    ..aI(7, _omitFieldNames ? '' : 'isFloor', fieldType: $pb.PbFieldType.OU3)
    ..aOS(8, _omitFieldNames ? '' : 'quoteContent')
    ..aOM<$2.User>(9, _omitFieldNames ? '' : 'replyer',
        subBuilder: $2.User.$_createMessage)
    ..a<$fixnum.Int64>(
        14, _omitFieldNames ? '' : 'quotePid', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.User>(15, _omitFieldNames ? '' : 'quoteUser',
        subBuilder: $2.User.$_createMessage)
    ..aOM<$2.User>(25, _omitFieldNames ? '' : 'threadAuthorUser',
        subBuilder: $2.User.$_createMessage)
    ..pPM<ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo>(
        28, _omitFieldNames ? '' : 'newFloorInfo',
        subBuilder:
            ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes_ReplyList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes_ReplyList copyWith(
          void Function(ReplyMeResIdl_DataRes_ReplyList) updates) =>
      super.copyWith(
              (message) => updates(message as ReplyMeResIdl_DataRes_ReplyList))
          as ReplyMeResIdl_DataRes_ReplyList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReplyMeResIdl_DataRes_ReplyList() / ReplyMeResIdl_DataRes_ReplyList.new instead')
  static ReplyMeResIdl_DataRes_ReplyList create() =>
      ReplyMeResIdl_DataRes_ReplyList._();
  static $pb.GeneratedMessage $_createMessage() =>
      ReplyMeResIdl_DataRes_ReplyList._();
  @$core.override
  ReplyMeResIdl_DataRes_ReplyList createEmptyInstance() =>
      ReplyMeResIdl_DataRes_ReplyList._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeResIdl_DataRes_ReplyList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplyMeResIdl_DataRes_ReplyList>(
          ReplyMeResIdl_DataRes_ReplyList.$_createMessage);
  static ReplyMeResIdl_DataRes_ReplyList? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get threadId => $_getI64(0);
  @$pb.TagNumber(1)
  set threadId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get postId => $_getI64(1);
  @$pb.TagNumber(2)
  set postId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPostId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPostId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get time => $_getIZ(2);
  @$pb.TagNumber(3)
  set time($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.String get fname => $_getSZ(3);
  @$pb.TagNumber(5)
  set fname($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasFname() => $_has(3);
  @$pb.TagNumber(5)
  void clearFname() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get content => $_getSZ(4);
  @$pb.TagNumber(6)
  set content($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(6)
  void clearContent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get isFloor => $_getIZ(5);
  @$pb.TagNumber(7)
  set isFloor($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(7)
  $core.bool hasIsFloor() => $_has(5);
  @$pb.TagNumber(7)
  void clearIsFloor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get quoteContent => $_getSZ(6);
  @$pb.TagNumber(8)
  set quoteContent($core.String value) => $_setString(6, value);
  @$pb.TagNumber(8)
  $core.bool hasQuoteContent() => $_has(6);
  @$pb.TagNumber(8)
  void clearQuoteContent() => $_clearField(8);

  @$pb.TagNumber(9)
  $2.User get replyer => $_getN(7);
  @$pb.TagNumber(9)
  set replyer($2.User value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReplyer() => $_has(7);
  @$pb.TagNumber(9)
  void clearReplyer() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.User ensureReplyer() => $_ensure(7);

  @$pb.TagNumber(14)
  $fixnum.Int64 get quotePid => $_getI64(8);
  @$pb.TagNumber(14)
  set quotePid($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(14)
  $core.bool hasQuotePid() => $_has(8);
  @$pb.TagNumber(14)
  void clearQuotePid() => $_clearField(14);

  @$pb.TagNumber(15)
  $2.User get quoteUser => $_getN(9);
  @$pb.TagNumber(15)
  set quoteUser($2.User value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasQuoteUser() => $_has(9);
  @$pb.TagNumber(15)
  void clearQuoteUser() => $_clearField(15);
  @$pb.TagNumber(15)
  $2.User ensureQuoteUser() => $_ensure(9);

  @$pb.TagNumber(25)
  $2.User get threadAuthorUser => $_getN(10);
  @$pb.TagNumber(25)
  set threadAuthorUser($2.User value) => $_setField(25, value);
  @$pb.TagNumber(25)
  $core.bool hasThreadAuthorUser() => $_has(10);
  @$pb.TagNumber(25)
  void clearThreadAuthorUser() => $_clearField(25);
  @$pb.TagNumber(25)
  $2.User ensureThreadAuthorUser() => $_ensure(10);

  @$pb.TagNumber(28)
  $pb.PbList<ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo> get newFloorInfo =>
      $_getList(11);
}

class ReplyMeResIdl_DataRes extends $pb.GeneratedMessage {
  factory ReplyMeResIdl_DataRes({
    $1.Page? page,
    $core.Iterable<ReplyMeResIdl_DataRes_ReplyList>? replyList,
  }) {
    final result = ReplyMeResIdl_DataRes._();
    if (page != null) result.page = page;
    if (replyList != null) result.replyList.addAll(replyList);
    return result;
  }

  ReplyMeResIdl_DataRes._();

  factory ReplyMeResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory ReplyMeResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeResIdl.DataRes',
      createEmptyInstance: ReplyMeResIdl_DataRes.$_createMessage)
    ..aOM<$1.Page>(1, _omitFieldNames ? '' : 'page',
        subBuilder: $1.Page.$_createMessage)
    ..pPM<ReplyMeResIdl_DataRes_ReplyList>(
        2, _omitFieldNames ? '' : 'replyList',
        subBuilder: ReplyMeResIdl_DataRes_ReplyList.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl_DataRes copyWith(
          void Function(ReplyMeResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as ReplyMeResIdl_DataRes))
          as ReplyMeResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReplyMeResIdl_DataRes() / ReplyMeResIdl_DataRes.new instead')
  static ReplyMeResIdl_DataRes create() => ReplyMeResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() => ReplyMeResIdl_DataRes._();
  @$core.override
  ReplyMeResIdl_DataRes createEmptyInstance() => ReplyMeResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplyMeResIdl_DataRes>(
          ReplyMeResIdl_DataRes.$_createMessage);
  static ReplyMeResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Page get page => $_getN(0);
  @$pb.TagNumber(1)
  set page($1.Page value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Page ensurePage() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ReplyMeResIdl_DataRes_ReplyList> get replyList => $_getList(1);
}

class ReplyMeResIdl extends $pb.GeneratedMessage {
  factory ReplyMeResIdl({
    $0.Error? error,
    ReplyMeResIdl_DataRes? data,
  }) {
    final result = ReplyMeResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  ReplyMeResIdl._();

  factory ReplyMeResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl()..mergeFromBuffer(data, registry);
  factory ReplyMeResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeResIdl',
      createEmptyInstance: ReplyMeResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<ReplyMeResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: ReplyMeResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeResIdl copyWith(void Function(ReplyMeResIdl) updates) =>
      super.copyWith((message) => updates(message as ReplyMeResIdl))
          as ReplyMeResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReplyMeResIdl() / ReplyMeResIdl.new instead')
  static ReplyMeResIdl create() => ReplyMeResIdl._();
  static $pb.GeneratedMessage $_createMessage() => ReplyMeResIdl._();
  @$core.override
  ReplyMeResIdl createEmptyInstance() => ReplyMeResIdl._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReplyMeResIdl>(
          ReplyMeResIdl.$_createMessage);
  static ReplyMeResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($0.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  ReplyMeResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(ReplyMeResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  ReplyMeResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
