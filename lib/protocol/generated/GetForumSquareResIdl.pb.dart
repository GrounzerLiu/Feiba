// This is a generated file - do not edit.
//
// Generated from GetForumSquareResIdl.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetForumSquareResIdl_DataRes_RecommendForumInfo
    extends $pb.GeneratedMessage {
  factory GetForumSquareResIdl_DataRes_RecommendForumInfo({
    $fixnum.Int64? forumId,
    $core.String? forumName,
    $core.int? isLike,
    $core.int? memberCount,
    $core.int? threadCount,
  }) {
    final result = GetForumSquareResIdl_DataRes_RecommendForumInfo._();
    if (forumId != null) result.forumId = forumId;
    if (forumName != null) result.forumName = forumName;
    if (isLike != null) result.isLike = isLike;
    if (memberCount != null) result.memberCount = memberCount;
    if (threadCount != null) result.threadCount = threadCount;
    return result;
  }

  GetForumSquareResIdl_DataRes_RecommendForumInfo._();

  factory GetForumSquareResIdl_DataRes_RecommendForumInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl_DataRes_RecommendForumInfo()
        ..mergeFromBuffer(data, registry);
  factory GetForumSquareResIdl_DataRes_RecommendForumInfo.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl_DataRes_RecommendForumInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetForumSquareResIdl.DataRes.RecommendForumInfo',
      createEmptyInstance:
          GetForumSquareResIdl_DataRes_RecommendForumInfo.$_createMessage)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'forumId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'forumName')
    ..aI(4, _omitFieldNames ? '' : 'isLike', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'memberCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'threadCount',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl_DataRes_RecommendForumInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl_DataRes_RecommendForumInfo copyWith(
          void Function(GetForumSquareResIdl_DataRes_RecommendForumInfo)
              updates) =>
      super.copyWith((message) => updates(
              message as GetForumSquareResIdl_DataRes_RecommendForumInfo))
          as GetForumSquareResIdl_DataRes_RecommendForumInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumSquareResIdl_DataRes_RecommendForumInfo() / GetForumSquareResIdl_DataRes_RecommendForumInfo.new instead')
  static GetForumSquareResIdl_DataRes_RecommendForumInfo create() =>
      GetForumSquareResIdl_DataRes_RecommendForumInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumSquareResIdl_DataRes_RecommendForumInfo._();
  @$core.override
  GetForumSquareResIdl_DataRes_RecommendForumInfo createEmptyInstance() =>
      GetForumSquareResIdl_DataRes_RecommendForumInfo._();
  @$core.pragma('dart2js:noInline')
  static GetForumSquareResIdl_DataRes_RecommendForumInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetForumSquareResIdl_DataRes_RecommendForumInfo>(
          GetForumSquareResIdl_DataRes_RecommendForumInfo.$_createMessage);
  static GetForumSquareResIdl_DataRes_RecommendForumInfo? _defaultInstance;

  @$pb.TagNumber(2)
  $fixnum.Int64 get forumId => $_getI64(0);
  @$pb.TagNumber(2)
  set forumId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(2)
  $core.bool hasForumId() => $_has(0);
  @$pb.TagNumber(2)
  void clearForumId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get forumName => $_getSZ(1);
  @$pb.TagNumber(3)
  set forumName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasForumName() => $_has(1);
  @$pb.TagNumber(3)
  void clearForumName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get isLike => $_getIZ(2);
  @$pb.TagNumber(4)
  set isLike($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasIsLike() => $_has(2);
  @$pb.TagNumber(4)
  void clearIsLike() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get memberCount => $_getIZ(3);
  @$pb.TagNumber(5)
  set memberCount($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasMemberCount() => $_has(3);
  @$pb.TagNumber(5)
  void clearMemberCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get threadCount => $_getIZ(4);
  @$pb.TagNumber(6)
  set threadCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(6)
  $core.bool hasThreadCount() => $_has(4);
  @$pb.TagNumber(6)
  void clearThreadCount() => $_clearField(6);
}

class GetForumSquareResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetForumSquareResIdl_DataRes({
    $core.Iterable<GetForumSquareResIdl_DataRes_RecommendForumInfo>? forumInfo,
    $1.Page? page,
  }) {
    final result = GetForumSquareResIdl_DataRes._();
    if (forumInfo != null) result.forumInfo.addAll(forumInfo);
    if (page != null) result.page = page;
    return result;
  }

  GetForumSquareResIdl_DataRes._();

  factory GetForumSquareResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetForumSquareResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumSquareResIdl.DataRes',
      createEmptyInstance: GetForumSquareResIdl_DataRes.$_createMessage)
    ..pPM<GetForumSquareResIdl_DataRes_RecommendForumInfo>(
        2, _omitFieldNames ? '' : 'forumInfo',
        subBuilder:
            GetForumSquareResIdl_DataRes_RecommendForumInfo.$_createMessage)
    ..aOM<$1.Page>(3, _omitFieldNames ? '' : 'page',
        subBuilder: $1.Page.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl_DataRes copyWith(
          void Function(GetForumSquareResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as GetForumSquareResIdl_DataRes))
          as GetForumSquareResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumSquareResIdl_DataRes() / GetForumSquareResIdl_DataRes.new instead')
  static GetForumSquareResIdl_DataRes create() =>
      GetForumSquareResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumSquareResIdl_DataRes._();
  @$core.override
  GetForumSquareResIdl_DataRes createEmptyInstance() =>
      GetForumSquareResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetForumSquareResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumSquareResIdl_DataRes>(
          GetForumSquareResIdl_DataRes.$_createMessage);
  static GetForumSquareResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(2)
  $pb.PbList<GetForumSquareResIdl_DataRes_RecommendForumInfo> get forumInfo =>
      $_getList(0);

  @$pb.TagNumber(3)
  $1.Page get page => $_getN(1);
  @$pb.TagNumber(3)
  set page($1.Page value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Page ensurePage() => $_ensure(1);
}

class GetForumSquareResIdl extends $pb.GeneratedMessage {
  factory GetForumSquareResIdl({
    $0.Error? error,
    GetForumSquareResIdl_DataRes? data,
  }) {
    final result = GetForumSquareResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetForumSquareResIdl._();

  factory GetForumSquareResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl()..mergeFromBuffer(data, registry);
  factory GetForumSquareResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumSquareResIdl',
      createEmptyInstance: GetForumSquareResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetForumSquareResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetForumSquareResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareResIdl copyWith(void Function(GetForumSquareResIdl) updates) =>
      super.copyWith((message) => updates(message as GetForumSquareResIdl))
          as GetForumSquareResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumSquareResIdl() / GetForumSquareResIdl.new instead')
  static GetForumSquareResIdl create() => GetForumSquareResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetForumSquareResIdl._();
  @$core.override
  GetForumSquareResIdl createEmptyInstance() => GetForumSquareResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetForumSquareResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumSquareResIdl>(
          GetForumSquareResIdl.$_createMessage);
  static GetForumSquareResIdl? _defaultInstance;

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
  GetForumSquareResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetForumSquareResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetForumSquareResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
