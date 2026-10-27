// This is a generated file - do not edit.
//
// Generated from SearchPostForumResIdl.proto.

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
import 'FrsTabInfo.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SearchPostForumResIdl_DataRes_SearchForum extends $pb.GeneratedMessage {
  factory SearchPostForumResIdl_DataRes_SearchForum({
    $fixnum.Int64? forumId,
    $core.String? forumName,
    $core.Iterable<$1.FrsTabInfo>? tabInfo,
  }) {
    final result = SearchPostForumResIdl_DataRes_SearchForum._();
    if (forumId != null) result.forumId = forumId;
    if (forumName != null) result.forumName = forumName;
    if (tabInfo != null) result.tabInfo.addAll(tabInfo);
    return result;
  }

  SearchPostForumResIdl_DataRes_SearchForum._();

  factory SearchPostForumResIdl_DataRes_SearchForum.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl_DataRes_SearchForum()
        ..mergeFromBuffer(data, registry);
  factory SearchPostForumResIdl_DataRes_SearchForum.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl_DataRes_SearchForum()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchPostForumResIdl.DataRes.SearchForum',
      createEmptyInstance:
          SearchPostForumResIdl_DataRes_SearchForum.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'forumId')
    ..aOS(2, _omitFieldNames ? '' : 'forumName')
    ..pPM<$1.FrsTabInfo>(9, _omitFieldNames ? '' : 'tabInfo',
        subBuilder: $1.FrsTabInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl_DataRes_SearchForum clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl_DataRes_SearchForum copyWith(
          void Function(SearchPostForumResIdl_DataRes_SearchForum) updates) =>
      super.copyWith((message) =>
              updates(message as SearchPostForumResIdl_DataRes_SearchForum))
          as SearchPostForumResIdl_DataRes_SearchForum;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SearchPostForumResIdl_DataRes_SearchForum() / SearchPostForumResIdl_DataRes_SearchForum.new instead')
  static SearchPostForumResIdl_DataRes_SearchForum create() =>
      SearchPostForumResIdl_DataRes_SearchForum._();
  static $pb.GeneratedMessage $_createMessage() =>
      SearchPostForumResIdl_DataRes_SearchForum._();
  @$core.override
  SearchPostForumResIdl_DataRes_SearchForum createEmptyInstance() =>
      SearchPostForumResIdl_DataRes_SearchForum._();
  @$core.pragma('dart2js:noInline')
  static SearchPostForumResIdl_DataRes_SearchForum getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              SearchPostForumResIdl_DataRes_SearchForum>(
          SearchPostForumResIdl_DataRes_SearchForum.$_createMessage);
  static SearchPostForumResIdl_DataRes_SearchForum? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get forumId => $_getI64(0);
  @$pb.TagNumber(1)
  set forumId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasForumId() => $_has(0);
  @$pb.TagNumber(1)
  void clearForumId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get forumName => $_getSZ(1);
  @$pb.TagNumber(2)
  set forumName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForumName() => $_has(1);
  @$pb.TagNumber(2)
  void clearForumName() => $_clearField(2);

  @$pb.TagNumber(9)
  $pb.PbList<$1.FrsTabInfo> get tabInfo => $_getList(2);
}

class SearchPostForumResIdl_DataRes extends $pb.GeneratedMessage {
  factory SearchPostForumResIdl_DataRes({
    SearchPostForumResIdl_DataRes_SearchForum? exactMatch,
  }) {
    final result = SearchPostForumResIdl_DataRes._();
    if (exactMatch != null) result.exactMatch = exactMatch;
    return result;
  }

  SearchPostForumResIdl_DataRes._();

  factory SearchPostForumResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory SearchPostForumResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchPostForumResIdl.DataRes',
      createEmptyInstance: SearchPostForumResIdl_DataRes.$_createMessage)
    ..aOM<SearchPostForumResIdl_DataRes_SearchForum>(
        1, _omitFieldNames ? '' : 'exactMatch',
        subBuilder: SearchPostForumResIdl_DataRes_SearchForum.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl_DataRes copyWith(
          void Function(SearchPostForumResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as SearchPostForumResIdl_DataRes))
          as SearchPostForumResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SearchPostForumResIdl_DataRes() / SearchPostForumResIdl_DataRes.new instead')
  static SearchPostForumResIdl_DataRes create() =>
      SearchPostForumResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      SearchPostForumResIdl_DataRes._();
  @$core.override
  SearchPostForumResIdl_DataRes createEmptyInstance() =>
      SearchPostForumResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static SearchPostForumResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchPostForumResIdl_DataRes>(
          SearchPostForumResIdl_DataRes.$_createMessage);
  static SearchPostForumResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  SearchPostForumResIdl_DataRes_SearchForum get exactMatch => $_getN(0);
  @$pb.TagNumber(1)
  set exactMatch(SearchPostForumResIdl_DataRes_SearchForum value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExactMatch() => $_has(0);
  @$pb.TagNumber(1)
  void clearExactMatch() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchPostForumResIdl_DataRes_SearchForum ensureExactMatch() => $_ensure(0);
}

class SearchPostForumResIdl extends $pb.GeneratedMessage {
  factory SearchPostForumResIdl({
    $0.Error? error,
    SearchPostForumResIdl_DataRes? data,
  }) {
    final result = SearchPostForumResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  SearchPostForumResIdl._();

  factory SearchPostForumResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl()..mergeFromBuffer(data, registry);
  factory SearchPostForumResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchPostForumResIdl',
      createEmptyInstance: SearchPostForumResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<SearchPostForumResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: SearchPostForumResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumResIdl copyWith(
          void Function(SearchPostForumResIdl) updates) =>
      super.copyWith((message) => updates(message as SearchPostForumResIdl))
          as SearchPostForumResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SearchPostForumResIdl() / SearchPostForumResIdl.new instead')
  static SearchPostForumResIdl create() => SearchPostForumResIdl._();
  static $pb.GeneratedMessage $_createMessage() => SearchPostForumResIdl._();
  @$core.override
  SearchPostForumResIdl createEmptyInstance() => SearchPostForumResIdl._();
  @$core.pragma('dart2js:noInline')
  static SearchPostForumResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchPostForumResIdl>(
          SearchPostForumResIdl.$_createMessage);
  static SearchPostForumResIdl? _defaultInstance;

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
  SearchPostForumResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(SearchPostForumResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchPostForumResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
