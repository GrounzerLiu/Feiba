// This is a generated file - do not edit.
//
// Generated from GetDislikeListReqIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'CommonReq.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetDislikeListReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetDislikeListReqIdl_DataReq({
    $0.CommonReq? common,
    $core.int? pn,
    $core.int? rn,
  }) {
    final result = GetDislikeListReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (pn != null) result.pn = pn;
    if (rn != null) result.rn = rn;
    return result;
  }

  GetDislikeListReqIdl_DataReq._();

  factory GetDislikeListReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetDislikeListReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDislikeListReqIdl.DataReq',
      createEmptyInstance: GetDislikeListReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'pn')
    ..aI(4, _omitFieldNames ? '' : 'rn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListReqIdl_DataReq copyWith(
          void Function(GetDislikeListReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as GetDislikeListReqIdl_DataReq))
          as GetDislikeListReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDislikeListReqIdl_DataReq() / GetDislikeListReqIdl_DataReq.new instead')
  static GetDislikeListReqIdl_DataReq create() =>
      GetDislikeListReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetDislikeListReqIdl_DataReq._();
  @$core.override
  GetDislikeListReqIdl_DataReq createEmptyInstance() =>
      GetDislikeListReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetDislikeListReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDislikeListReqIdl_DataReq>(
          GetDislikeListReqIdl_DataReq.$_createMessage);
  static GetDislikeListReqIdl_DataReq? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get pn => $_getIZ(1);
  @$pb.TagNumber(3)
  set pn($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasPn() => $_has(1);
  @$pb.TagNumber(3)
  void clearPn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get rn => $_getIZ(2);
  @$pb.TagNumber(4)
  set rn($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasRn() => $_has(2);
  @$pb.TagNumber(4)
  void clearRn() => $_clearField(4);
}

class GetDislikeListReqIdl extends $pb.GeneratedMessage {
  factory GetDislikeListReqIdl({
    GetDislikeListReqIdl_DataReq? data,
  }) {
    final result = GetDislikeListReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetDislikeListReqIdl._();

  factory GetDislikeListReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListReqIdl()..mergeFromBuffer(data, registry);
  factory GetDislikeListReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDislikeListReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDislikeListReqIdl',
      createEmptyInstance: GetDislikeListReqIdl.$_createMessage)
    ..aOM<GetDislikeListReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetDislikeListReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDislikeListReqIdl copyWith(void Function(GetDislikeListReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetDislikeListReqIdl))
          as GetDislikeListReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDislikeListReqIdl() / GetDislikeListReqIdl.new instead')
  static GetDislikeListReqIdl create() => GetDislikeListReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetDislikeListReqIdl._();
  @$core.override
  GetDislikeListReqIdl createEmptyInstance() => GetDislikeListReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetDislikeListReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDislikeListReqIdl>(
          GetDislikeListReqIdl.$_createMessage);
  static GetDislikeListReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetDislikeListReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetDislikeListReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetDislikeListReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
