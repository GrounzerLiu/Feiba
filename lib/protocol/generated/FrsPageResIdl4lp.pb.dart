// This is a generated file - do not edit.
//
// Generated from FrsPageResIdl4lp.proto.

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
import 'ThreadInfo.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FrsPageResIdl4lp_DataRes_ForumInfo extends $pb.GeneratedMessage {
  factory FrsPageResIdl4lp_DataRes_ForumInfo({
    $fixnum.Int64? id,
    $core.String? name,
  }) {
    final result = FrsPageResIdl4lp_DataRes_ForumInfo._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  FrsPageResIdl4lp_DataRes_ForumInfo._();

  factory FrsPageResIdl4lp_DataRes_ForumInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp_DataRes_ForumInfo()..mergeFromBuffer(data, registry);
  factory FrsPageResIdl4lp_DataRes_ForumInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp_DataRes_ForumInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FrsPageResIdl4lp.DataRes.ForumInfo',
      createEmptyInstance: FrsPageResIdl4lp_DataRes_ForumInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp_DataRes_ForumInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp_DataRes_ForumInfo copyWith(
          void Function(FrsPageResIdl4lp_DataRes_ForumInfo) updates) =>
      super.copyWith((message) =>
              updates(message as FrsPageResIdl4lp_DataRes_ForumInfo))
          as FrsPageResIdl4lp_DataRes_ForumInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FrsPageResIdl4lp_DataRes_ForumInfo() / FrsPageResIdl4lp_DataRes_ForumInfo.new instead')
  static FrsPageResIdl4lp_DataRes_ForumInfo create() =>
      FrsPageResIdl4lp_DataRes_ForumInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      FrsPageResIdl4lp_DataRes_ForumInfo._();
  @$core.override
  FrsPageResIdl4lp_DataRes_ForumInfo createEmptyInstance() =>
      FrsPageResIdl4lp_DataRes_ForumInfo._();
  @$core.pragma('dart2js:noInline')
  static FrsPageResIdl4lp_DataRes_ForumInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FrsPageResIdl4lp_DataRes_ForumInfo>(
          FrsPageResIdl4lp_DataRes_ForumInfo.$_createMessage);
  static FrsPageResIdl4lp_DataRes_ForumInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class FrsPageResIdl4lp_DataRes extends $pb.GeneratedMessage {
  factory FrsPageResIdl4lp_DataRes({
    FrsPageResIdl4lp_DataRes_ForumInfo? forum,
    $1.Page? page,
    $core.Iterable<$2.ThreadInfo>? threadList,
  }) {
    final result = FrsPageResIdl4lp_DataRes._();
    if (forum != null) result.forum = forum;
    if (page != null) result.page = page;
    if (threadList != null) result.threadList.addAll(threadList);
    return result;
  }

  FrsPageResIdl4lp_DataRes._();

  factory FrsPageResIdl4lp_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp_DataRes()..mergeFromBuffer(data, registry);
  factory FrsPageResIdl4lp_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FrsPageResIdl4lp.DataRes',
      createEmptyInstance: FrsPageResIdl4lp_DataRes.$_createMessage)
    ..aOM<FrsPageResIdl4lp_DataRes_ForumInfo>(2, _omitFieldNames ? '' : 'forum',
        subBuilder: FrsPageResIdl4lp_DataRes_ForumInfo.$_createMessage)
    ..aOM<$1.Page>(4, _omitFieldNames ? '' : 'page',
        subBuilder: $1.Page.$_createMessage)
    ..pPM<$2.ThreadInfo>(7, _omitFieldNames ? '' : 'threadList',
        subBuilder: $2.ThreadInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp_DataRes copyWith(
          void Function(FrsPageResIdl4lp_DataRes) updates) =>
      super.copyWith((message) => updates(message as FrsPageResIdl4lp_DataRes))
          as FrsPageResIdl4lp_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FrsPageResIdl4lp_DataRes() / FrsPageResIdl4lp_DataRes.new instead')
  static FrsPageResIdl4lp_DataRes create() => FrsPageResIdl4lp_DataRes._();
  static $pb.GeneratedMessage $_createMessage() => FrsPageResIdl4lp_DataRes._();
  @$core.override
  FrsPageResIdl4lp_DataRes createEmptyInstance() =>
      FrsPageResIdl4lp_DataRes._();
  @$core.pragma('dart2js:noInline')
  static FrsPageResIdl4lp_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FrsPageResIdl4lp_DataRes>(
          FrsPageResIdl4lp_DataRes.$_createMessage);
  static FrsPageResIdl4lp_DataRes? _defaultInstance;

  @$pb.TagNumber(2)
  FrsPageResIdl4lp_DataRes_ForumInfo get forum => $_getN(0);
  @$pb.TagNumber(2)
  set forum(FrsPageResIdl4lp_DataRes_ForumInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasForum() => $_has(0);
  @$pb.TagNumber(2)
  void clearForum() => $_clearField(2);
  @$pb.TagNumber(2)
  FrsPageResIdl4lp_DataRes_ForumInfo ensureForum() => $_ensure(0);

  @$pb.TagNumber(4)
  $1.Page get page => $_getN(1);
  @$pb.TagNumber(4)
  set page($1.Page value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Page ensurePage() => $_ensure(1);

  @$pb.TagNumber(7)
  $pb.PbList<$2.ThreadInfo> get threadList => $_getList(2);
}

class FrsPageResIdl4lp extends $pb.GeneratedMessage {
  factory FrsPageResIdl4lp({
    $0.Error? error,
    FrsPageResIdl4lp_DataRes? data,
  }) {
    final result = FrsPageResIdl4lp._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  FrsPageResIdl4lp._();

  factory FrsPageResIdl4lp.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp()..mergeFromBuffer(data, registry);
  factory FrsPageResIdl4lp.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FrsPageResIdl4lp()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FrsPageResIdl4lp',
      createEmptyInstance: FrsPageResIdl4lp.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<FrsPageResIdl4lp_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: FrsPageResIdl4lp_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FrsPageResIdl4lp copyWith(void Function(FrsPageResIdl4lp) updates) =>
      super.copyWith((message) => updates(message as FrsPageResIdl4lp))
          as FrsPageResIdl4lp;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FrsPageResIdl4lp() / FrsPageResIdl4lp.new instead')
  static FrsPageResIdl4lp create() => FrsPageResIdl4lp._();
  static $pb.GeneratedMessage $_createMessage() => FrsPageResIdl4lp._();
  @$core.override
  FrsPageResIdl4lp createEmptyInstance() => FrsPageResIdl4lp._();
  @$core.pragma('dart2js:noInline')
  static FrsPageResIdl4lp getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FrsPageResIdl4lp>(
          FrsPageResIdl4lp.$_createMessage);
  static FrsPageResIdl4lp? _defaultInstance;

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
  FrsPageResIdl4lp_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(FrsPageResIdl4lp_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  FrsPageResIdl4lp_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
