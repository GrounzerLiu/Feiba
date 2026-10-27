// This is a generated file - do not edit.
//
// Generated from GetDislikeListResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;
import 'ForumList.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetDislikeListResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetDislikeListResIdl_DataRes({
    $core.Iterable<$1.ForumList>? forumList,
    $core.int? hasMore,
    $core.int? curPage,
  }) {
    final result = GetDislikeListResIdl_DataRes._();
    if (forumList != null) result.forumList.addAll(forumList);
    if (hasMore != null) result.hasMore = hasMore;
    if (curPage != null) result.curPage = curPage;
    return result;
  }

  GetDislikeListResIdl_DataRes._();

  factory GetDislikeListResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetDislikeListResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDislikeListResIdl.DataRes',
      createEmptyInstance: GetDislikeListResIdl_DataRes.$_createMessage)
    ..pPM<$1.ForumList>(1, _omitFieldNames ? '' : 'forumList',
        subBuilder: $1.ForumList.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'hasMore')
    ..aI(3, _omitFieldNames ? '' : 'curPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListResIdl_DataRes copyWith(
          void Function(GetDislikeListResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as GetDislikeListResIdl_DataRes))
          as GetDislikeListResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDislikeListResIdl_DataRes() / GetDislikeListResIdl_DataRes.new instead')
  static GetDislikeListResIdl_DataRes create() =>
      GetDislikeListResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetDislikeListResIdl_DataRes._();
  @$core.override
  GetDislikeListResIdl_DataRes createEmptyInstance() =>
      GetDislikeListResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetDislikeListResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDislikeListResIdl_DataRes>(
          GetDislikeListResIdl_DataRes.$_createMessage);
  static GetDislikeListResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.ForumList> get forumList => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get hasMore => $_getIZ(1);
  @$pb.TagNumber(2)
  set hasMore($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHasMore() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasMore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get curPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set curPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurPage() => $_clearField(3);
}

class GetDislikeListResIdl extends $pb.GeneratedMessage {
  factory GetDislikeListResIdl({
    $0.Error? error,
    GetDislikeListResIdl_DataRes? data,
  }) {
    final result = GetDislikeListResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetDislikeListResIdl._();

  factory GetDislikeListResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListResIdl()..mergeFromBuffer(data, registry);
  factory GetDislikeListResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDislikeListResIdl',
      createEmptyInstance: GetDislikeListResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetDislikeListResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetDislikeListResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListResIdl copyWith(void Function(GetDislikeListResIdl) updates) =>
      super.copyWith((message) => updates(message as GetDislikeListResIdl))
          as GetDislikeListResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDislikeListResIdl() / GetDislikeListResIdl.new instead')
  static GetDislikeListResIdl create() => GetDislikeListResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetDislikeListResIdl._();
  @$core.override
  GetDislikeListResIdl createEmptyInstance() => GetDislikeListResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetDislikeListResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDislikeListResIdl>(
          GetDislikeListResIdl.$_createMessage);
  static GetDislikeListResIdl? _defaultInstance;

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
  GetDislikeListResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetDislikeListResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetDislikeListResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
