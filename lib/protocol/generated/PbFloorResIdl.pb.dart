// This is a generated file - do not edit.
//
// Generated from PbFloorResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;
import 'Page.pb.dart' as $1;
import 'Post.pb.dart' as $2;
import 'SimpleForum.pb.dart' as $5;
import 'SubPostList.pb.dart' as $3;
import 'ThreadInfo.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PbFloorResIdl_DataRes extends $pb.GeneratedMessage {
  factory PbFloorResIdl_DataRes({
    $1.Page? page,
    $2.Post? post,
    $core.Iterable<$3.SubPostList>? subpostList,
    $4.ThreadInfo? thread,
    $5.SimpleForum? forum,
  }) {
    final result = PbFloorResIdl_DataRes._();
    if (page != null) result.page = page;
    if (post != null) result.post = post;
    if (subpostList != null) result.subpostList.addAll(subpostList);
    if (thread != null) result.thread = thread;
    if (forum != null) result.forum = forum;
    return result;
  }

  PbFloorResIdl_DataRes._();

  factory PbFloorResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory PbFloorResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PbFloorResIdl.DataRes',
      createEmptyInstance: PbFloorResIdl_DataRes.$_createMessage)
    ..aOM<$1.Page>(1, _omitFieldNames ? '' : 'page',
        subBuilder: $1.Page.$_createMessage)
    ..aOM<$2.Post>(3, _omitFieldNames ? '' : 'post',
        subBuilder: $2.Post.$_createMessage)
    ..pPM<$3.SubPostList>(4, _omitFieldNames ? '' : 'subpostList',
        subBuilder: $3.SubPostList.$_createMessage)
    ..aOM<$4.ThreadInfo>(5, _omitFieldNames ? '' : 'thread',
        subBuilder: $4.ThreadInfo.$_createMessage)
    ..aOM<$5.SimpleForum>(6, _omitFieldNames ? '' : 'forum',
        subBuilder: $5.SimpleForum.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorResIdl_DataRes copyWith(
          void Function(PbFloorResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as PbFloorResIdl_DataRes))
          as PbFloorResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PbFloorResIdl_DataRes() / PbFloorResIdl_DataRes.new instead')
  static PbFloorResIdl_DataRes create() => PbFloorResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() => PbFloorResIdl_DataRes._();
  @$core.override
  PbFloorResIdl_DataRes createEmptyInstance() => PbFloorResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static PbFloorResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PbFloorResIdl_DataRes>(
          PbFloorResIdl_DataRes.$_createMessage);
  static PbFloorResIdl_DataRes? _defaultInstance;

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

  @$pb.TagNumber(3)
  $2.Post get post => $_getN(1);
  @$pb.TagNumber(3)
  set post($2.Post value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPost() => $_has(1);
  @$pb.TagNumber(3)
  void clearPost() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Post ensurePost() => $_ensure(1);

  @$pb.TagNumber(4)
  $pb.PbList<$3.SubPostList> get subpostList => $_getList(2);

  @$pb.TagNumber(5)
  $4.ThreadInfo get thread => $_getN(3);
  @$pb.TagNumber(5)
  set thread($4.ThreadInfo value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasThread() => $_has(3);
  @$pb.TagNumber(5)
  void clearThread() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.ThreadInfo ensureThread() => $_ensure(3);

  @$pb.TagNumber(6)
  $5.SimpleForum get forum => $_getN(4);
  @$pb.TagNumber(6)
  set forum($5.SimpleForum value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasForum() => $_has(4);
  @$pb.TagNumber(6)
  void clearForum() => $_clearField(6);
  @$pb.TagNumber(6)
  $5.SimpleForum ensureForum() => $_ensure(4);
}

class PbFloorResIdl extends $pb.GeneratedMessage {
  factory PbFloorResIdl({
    $0.Error? error,
    PbFloorResIdl_DataRes? data,
  }) {
    final result = PbFloorResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  PbFloorResIdl._();

  factory PbFloorResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorResIdl()..mergeFromBuffer(data, registry);
  factory PbFloorResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PbFloorResIdl',
      createEmptyInstance: PbFloorResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<PbFloorResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: PbFloorResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorResIdl copyWith(void Function(PbFloorResIdl) updates) =>
      super.copyWith((message) => updates(message as PbFloorResIdl))
          as PbFloorResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PbFloorResIdl() / PbFloorResIdl.new instead')
  static PbFloorResIdl create() => PbFloorResIdl._();
  static $pb.GeneratedMessage $_createMessage() => PbFloorResIdl._();
  @$core.override
  PbFloorResIdl createEmptyInstance() => PbFloorResIdl._();
  @$core.pragma('dart2js:noInline')
  static PbFloorResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PbFloorResIdl>(
          PbFloorResIdl.$_createMessage);
  static PbFloorResIdl? _defaultInstance;

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
  PbFloorResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(PbFloorResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  PbFloorResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
