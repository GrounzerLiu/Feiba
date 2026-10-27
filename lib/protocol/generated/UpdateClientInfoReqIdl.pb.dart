// This is a generated file - do not edit.
//
// Generated from UpdateClientInfoReqIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UpdateClientInfoReqIdl_DataReq extends $pb.GeneratedMessage {
  factory UpdateClientInfoReqIdl_DataReq({
    $core.String? bduss,
    $core.String? device,
    $core.List<$core.int>? secretKey,
    $core.String? stoken,
  }) {
    final result = UpdateClientInfoReqIdl_DataReq._();
    if (bduss != null) result.bduss = bduss;
    if (device != null) result.device = device;
    if (secretKey != null) result.secretKey = secretKey;
    if (stoken != null) result.stoken = stoken;
    return result;
  }

  UpdateClientInfoReqIdl_DataReq._();

  factory UpdateClientInfoReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory UpdateClientInfoReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoReqIdl.DataReq',
      createEmptyInstance: UpdateClientInfoReqIdl_DataReq.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'bduss')
    ..aOS(2, _omitFieldNames ? '' : 'device')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'secretKey', $pb.PbFieldType.OY,
        protoName: 'secretKey')
    ..aOS(12, _omitFieldNames ? '' : 'stoken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoReqIdl_DataReq copyWith(
          void Function(UpdateClientInfoReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateClientInfoReqIdl_DataReq))
          as UpdateClientInfoReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoReqIdl_DataReq() / UpdateClientInfoReqIdl_DataReq.new instead')
  static UpdateClientInfoReqIdl_DataReq create() =>
      UpdateClientInfoReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateClientInfoReqIdl_DataReq._();
  @$core.override
  UpdateClientInfoReqIdl_DataReq createEmptyInstance() =>
      UpdateClientInfoReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClientInfoReqIdl_DataReq>(
          UpdateClientInfoReqIdl_DataReq.$_createMessage);
  static UpdateClientInfoReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bduss => $_getSZ(0);
  @$pb.TagNumber(1)
  set bduss($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBduss() => $_has(0);
  @$pb.TagNumber(1)
  void clearBduss() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get device => $_getSZ(1);
  @$pb.TagNumber(2)
  set device($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDevice() => $_has(1);
  @$pb.TagNumber(2)
  void clearDevice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get secretKey => $_getN(2);
  @$pb.TagNumber(3)
  set secretKey($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSecretKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecretKey() => $_clearField(3);

  @$pb.TagNumber(12)
  $core.String get stoken => $_getSZ(3);
  @$pb.TagNumber(12)
  set stoken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(12)
  $core.bool hasStoken() => $_has(3);
  @$pb.TagNumber(12)
  void clearStoken() => $_clearField(12);
}

class UpdateClientInfoReqIdl extends $pb.GeneratedMessage {
  factory UpdateClientInfoReqIdl({
    $core.String? cuid,
    UpdateClientInfoReqIdl_DataReq? data,
  }) {
    final result = UpdateClientInfoReqIdl._();
    if (cuid != null) result.cuid = cuid;
    if (data != null) result.data = data;
    return result;
  }

  UpdateClientInfoReqIdl._();

  factory UpdateClientInfoReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoReqIdl()..mergeFromBuffer(data, registry);
  factory UpdateClientInfoReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoReqIdl',
      createEmptyInstance: UpdateClientInfoReqIdl.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'cuid')
    ..aOM<UpdateClientInfoReqIdl_DataReq>(2, _omitFieldNames ? '' : 'data',
        subBuilder: UpdateClientInfoReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoReqIdl copyWith(
          void Function(UpdateClientInfoReqIdl) updates) =>
      super.copyWith((message) => updates(message as UpdateClientInfoReqIdl))
          as UpdateClientInfoReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoReqIdl() / UpdateClientInfoReqIdl.new instead')
  static UpdateClientInfoReqIdl create() => UpdateClientInfoReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => UpdateClientInfoReqIdl._();
  @$core.override
  UpdateClientInfoReqIdl createEmptyInstance() => UpdateClientInfoReqIdl._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClientInfoReqIdl>(
          UpdateClientInfoReqIdl.$_createMessage);
  static UpdateClientInfoReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCuid() => $_clearField(1);

  @$pb.TagNumber(2)
  UpdateClientInfoReqIdl_DataReq get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(UpdateClientInfoReqIdl_DataReq value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  UpdateClientInfoReqIdl_DataReq ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
