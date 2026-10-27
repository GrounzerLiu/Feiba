// This is a generated file - do not edit.
//
// Generated from AddPollReqIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'CommonReq.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AddPollReqIdl_DataReq extends $pb.GeneratedMessage {
  factory AddPollReqIdl_DataReq({
    $fixnum.Int64? threadId,
    $core.String? options,
    $0.CommonReq? common,
    $fixnum.Int64? forumId,
  }) {
    final result = AddPollReqIdl_DataReq._();
    if (threadId != null) result.threadId = threadId;
    if (options != null) result.options = options;
    if (common != null) result.common = common;
    if (forumId != null) result.forumId = forumId;
    return result;
  }

  AddPollReqIdl_DataReq._();

  factory AddPollReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory AddPollReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddPollReqIdl.DataReq',
      createEmptyInstance: AddPollReqIdl_DataReq.$_createMessage)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'threadId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'options')
    ..aOM<$0.CommonReq>(3, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'forumId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollReqIdl_DataReq copyWith(
          void Function(AddPollReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as AddPollReqIdl_DataReq))
          as AddPollReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddPollReqIdl_DataReq() / AddPollReqIdl_DataReq.new instead')
  static AddPollReqIdl_DataReq create() => AddPollReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() => AddPollReqIdl_DataReq._();
  @$core.override
  AddPollReqIdl_DataReq createEmptyInstance() => AddPollReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static AddPollReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddPollReqIdl_DataReq>(
          AddPollReqIdl_DataReq.$_createMessage);
  static AddPollReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get threadId => $_getI64(0);
  @$pb.TagNumber(1)
  set threadId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get options => $_getSZ(1);
  @$pb.TagNumber(2)
  set options($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.CommonReq get common => $_getN(2);
  @$pb.TagNumber(3)
  set common($0.CommonReq value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCommon() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommon() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.CommonReq ensureCommon() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get forumId => $_getI64(3);
  @$pb.TagNumber(4)
  set forumId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasForumId() => $_has(3);
  @$pb.TagNumber(4)
  void clearForumId() => $_clearField(4);
}

class AddPollReqIdl extends $pb.GeneratedMessage {
  factory AddPollReqIdl({
    AddPollReqIdl_DataReq? data,
  }) {
    final result = AddPollReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  AddPollReqIdl._();

  factory AddPollReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollReqIdl()..mergeFromBuffer(data, registry);
  factory AddPollReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddPollReqIdl',
      createEmptyInstance: AddPollReqIdl.$_createMessage)
    ..aOM<AddPollReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: AddPollReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollReqIdl copyWith(void Function(AddPollReqIdl) updates) =>
      super.copyWith((message) => updates(message as AddPollReqIdl))
          as AddPollReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AddPollReqIdl() / AddPollReqIdl.new instead')
  static AddPollReqIdl create() => AddPollReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => AddPollReqIdl._();
  @$core.override
  AddPollReqIdl createEmptyInstance() => AddPollReqIdl._();
  @$core.pragma('dart2js:noInline')
  static AddPollReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPollReqIdl>(
          AddPollReqIdl.$_createMessage);
  static AddPollReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  AddPollReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(AddPollReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  AddPollReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
