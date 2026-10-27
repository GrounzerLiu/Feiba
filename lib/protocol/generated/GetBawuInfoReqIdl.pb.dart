// This is a generated file - do not edit.
//
// Generated from GetBawuInfoReqIdl.proto.

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

class GetBawuInfoReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetBawuInfoReqIdl_DataReq({
    $0.CommonReq? common,
    $fixnum.Int64? fid,
  }) {
    final result = GetBawuInfoReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (fid != null) result.fid = fid;
    return result;
  }

  GetBawuInfoReqIdl_DataReq._();

  factory GetBawuInfoReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetBawuInfoReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoReqIdl.DataReq',
      createEmptyInstance: GetBawuInfoReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fid', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoReqIdl_DataReq copyWith(
          void Function(GetBawuInfoReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as GetBawuInfoReqIdl_DataReq))
          as GetBawuInfoReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetBawuInfoReqIdl_DataReq() / GetBawuInfoReqIdl_DataReq.new instead')
  static GetBawuInfoReqIdl_DataReq create() => GetBawuInfoReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetBawuInfoReqIdl_DataReq._();
  @$core.override
  GetBawuInfoReqIdl_DataReq createEmptyInstance() =>
      GetBawuInfoReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBawuInfoReqIdl_DataReq>(
          GetBawuInfoReqIdl_DataReq.$_createMessage);
  static GetBawuInfoReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.CommonReq get common => $_getN(0);
  @$pb.TagNumber(1)
  set common($0.CommonReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.CommonReq ensureCommon() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fid => $_getI64(1);
  @$pb.TagNumber(2)
  set fid($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFid() => $_has(1);
  @$pb.TagNumber(2)
  void clearFid() => $_clearField(2);
}

class GetBawuInfoReqIdl extends $pb.GeneratedMessage {
  factory GetBawuInfoReqIdl({
    GetBawuInfoReqIdl_DataReq? data,
  }) {
    final result = GetBawuInfoReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetBawuInfoReqIdl._();

  factory GetBawuInfoReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoReqIdl()..mergeFromBuffer(data, registry);
  factory GetBawuInfoReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoReqIdl',
      createEmptyInstance: GetBawuInfoReqIdl.$_createMessage)
    ..aOM<GetBawuInfoReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetBawuInfoReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoReqIdl copyWith(void Function(GetBawuInfoReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetBawuInfoReqIdl))
          as GetBawuInfoReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetBawuInfoReqIdl() / GetBawuInfoReqIdl.new instead')
  static GetBawuInfoReqIdl create() => GetBawuInfoReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetBawuInfoReqIdl._();
  @$core.override
  GetBawuInfoReqIdl createEmptyInstance() => GetBawuInfoReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBawuInfoReqIdl>(
          GetBawuInfoReqIdl.$_createMessage);
  static GetBawuInfoReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetBawuInfoReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetBawuInfoReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetBawuInfoReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
