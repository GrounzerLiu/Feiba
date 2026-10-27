// This is a generated file - do not edit.
//
// Generated from PbFloorReqIdl.proto.

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

class PbFloorReqIdl_DataReq extends $pb.GeneratedMessage {
  factory PbFloorReqIdl_DataReq({
    $fixnum.Int64? kz,
    $fixnum.Int64? pid,
    $fixnum.Int64? spid,
    $core.int? pn,
    $0.CommonReq? common,
    $core.int? sort,
  }) {
    final result = PbFloorReqIdl_DataReq._();
    if (kz != null) result.kz = kz;
    if (pid != null) result.pid = pid;
    if (spid != null) result.spid = spid;
    if (pn != null) result.pn = pn;
    if (common != null) result.common = common;
    if (sort != null) result.sort = sort;
    return result;
  }

  PbFloorReqIdl_DataReq._();

  factory PbFloorReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory PbFloorReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PbFloorReqIdl.DataReq',
      createEmptyInstance: PbFloorReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'kz')
    ..aInt64(2, _omitFieldNames ? '' : 'pid')
    ..aInt64(3, _omitFieldNames ? '' : 'spid')
    ..aI(4, _omitFieldNames ? '' : 'pn')
    ..aOM<$0.CommonReq>(9, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(19, _omitFieldNames ? '' : 'sort')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorReqIdl_DataReq copyWith(
          void Function(PbFloorReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as PbFloorReqIdl_DataReq))
          as PbFloorReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PbFloorReqIdl_DataReq() / PbFloorReqIdl_DataReq.new instead')
  static PbFloorReqIdl_DataReq create() => PbFloorReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() => PbFloorReqIdl_DataReq._();
  @$core.override
  PbFloorReqIdl_DataReq createEmptyInstance() => PbFloorReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static PbFloorReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PbFloorReqIdl_DataReq>(
          PbFloorReqIdl_DataReq.$_createMessage);
  static PbFloorReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get kz => $_getI64(0);
  @$pb.TagNumber(1)
  set kz($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKz() => $_has(0);
  @$pb.TagNumber(1)
  void clearKz() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pid => $_getI64(1);
  @$pb.TagNumber(2)
  set pid($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPid() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get spid => $_getI64(2);
  @$pb.TagNumber(3)
  set spid($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpid() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pn => $_getIZ(3);
  @$pb.TagNumber(4)
  set pn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPn() => $_has(3);
  @$pb.TagNumber(4)
  void clearPn() => $_clearField(4);

  @$pb.TagNumber(9)
  $0.CommonReq get common => $_getN(4);
  @$pb.TagNumber(9)
  set common($0.CommonReq value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCommon() => $_has(4);
  @$pb.TagNumber(9)
  void clearCommon() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.CommonReq ensureCommon() => $_ensure(4);

  @$pb.TagNumber(19)
  $core.int get sort => $_getIZ(5);
  @$pb.TagNumber(19)
  set sort($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(19)
  $core.bool hasSort() => $_has(5);
  @$pb.TagNumber(19)
  void clearSort() => $_clearField(19);
}

class PbFloorReqIdl extends $pb.GeneratedMessage {
  factory PbFloorReqIdl({
    PbFloorReqIdl_DataReq? data,
  }) {
    final result = PbFloorReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  PbFloorReqIdl._();

  factory PbFloorReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorReqIdl()..mergeFromBuffer(data, registry);
  factory PbFloorReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PbFloorReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PbFloorReqIdl',
      createEmptyInstance: PbFloorReqIdl.$_createMessage)
    ..aOM<PbFloorReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: PbFloorReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbFloorReqIdl copyWith(void Function(PbFloorReqIdl) updates) =>
      super.copyWith((message) => updates(message as PbFloorReqIdl))
          as PbFloorReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PbFloorReqIdl() / PbFloorReqIdl.new instead')
  static PbFloorReqIdl create() => PbFloorReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => PbFloorReqIdl._();
  @$core.override
  PbFloorReqIdl createEmptyInstance() => PbFloorReqIdl._();
  @$core.pragma('dart2js:noInline')
  static PbFloorReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PbFloorReqIdl>(
          PbFloorReqIdl.$_createMessage);
  static PbFloorReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  PbFloorReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(PbFloorReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  PbFloorReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
