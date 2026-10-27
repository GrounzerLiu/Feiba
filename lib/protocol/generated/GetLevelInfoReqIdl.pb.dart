// This is a generated file - do not edit.
//
// Generated from GetLevelInfoReqIdl.proto.

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

class GetLevelInfoReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetLevelInfoReqIdl_DataReq({
    $fixnum.Int64? forumId,
    $0.CommonReq? common,
  }) {
    final result = GetLevelInfoReqIdl_DataReq._();
    if (forumId != null) result.forumId = forumId;
    if (common != null) result.common = common;
    return result;
  }

  GetLevelInfoReqIdl_DataReq._();

  factory GetLevelInfoReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetLevelInfoReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLevelInfoReqIdl.DataReq',
      createEmptyInstance: GetLevelInfoReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'forumId')
    ..aOM<$0.CommonReq>(2, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoReqIdl_DataReq copyWith(
          void Function(GetLevelInfoReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as GetLevelInfoReqIdl_DataReq))
          as GetLevelInfoReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetLevelInfoReqIdl_DataReq() / GetLevelInfoReqIdl_DataReq.new instead')
  static GetLevelInfoReqIdl_DataReq create() => GetLevelInfoReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetLevelInfoReqIdl_DataReq._();
  @$core.override
  GetLevelInfoReqIdl_DataReq createEmptyInstance() =>
      GetLevelInfoReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetLevelInfoReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLevelInfoReqIdl_DataReq>(
          GetLevelInfoReqIdl_DataReq.$_createMessage);
  static GetLevelInfoReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get forumId => $_getI64(0);
  @$pb.TagNumber(1)
  set forumId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasForumId() => $_has(0);
  @$pb.TagNumber(1)
  void clearForumId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.CommonReq get common => $_getN(1);
  @$pb.TagNumber(2)
  set common($0.CommonReq value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCommon() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommon() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.CommonReq ensureCommon() => $_ensure(1);
}

class GetLevelInfoReqIdl extends $pb.GeneratedMessage {
  factory GetLevelInfoReqIdl({
    GetLevelInfoReqIdl_DataReq? data,
  }) {
    final result = GetLevelInfoReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetLevelInfoReqIdl._();

  factory GetLevelInfoReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoReqIdl()..mergeFromBuffer(data, registry);
  factory GetLevelInfoReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLevelInfoReqIdl',
      createEmptyInstance: GetLevelInfoReqIdl.$_createMessage)
    ..aOM<GetLevelInfoReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetLevelInfoReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoReqIdl copyWith(void Function(GetLevelInfoReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetLevelInfoReqIdl))
          as GetLevelInfoReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetLevelInfoReqIdl() / GetLevelInfoReqIdl.new instead')
  static GetLevelInfoReqIdl create() => GetLevelInfoReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetLevelInfoReqIdl._();
  @$core.override
  GetLevelInfoReqIdl createEmptyInstance() => GetLevelInfoReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetLevelInfoReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLevelInfoReqIdl>(
          GetLevelInfoReqIdl.$_createMessage);
  static GetLevelInfoReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetLevelInfoReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetLevelInfoReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetLevelInfoReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
