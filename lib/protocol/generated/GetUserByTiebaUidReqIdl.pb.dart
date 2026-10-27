// This is a generated file - do not edit.
//
// Generated from GetUserByTiebaUidReqIdl.proto.

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

class GetUserByTiebaUidReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetUserByTiebaUidReqIdl_DataReq({
    $0.CommonReq? common,
    $core.String? tiebaUid,
  }) {
    final result = GetUserByTiebaUidReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (tiebaUid != null) result.tiebaUid = tiebaUid;
    return result;
  }

  GetUserByTiebaUidReqIdl_DataReq._();

  factory GetUserByTiebaUidReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetUserByTiebaUidReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserByTiebaUidReqIdl.DataReq',
      createEmptyInstance: GetUserByTiebaUidReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'tiebaUid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidReqIdl_DataReq copyWith(
          void Function(GetUserByTiebaUidReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserByTiebaUidReqIdl_DataReq))
          as GetUserByTiebaUidReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserByTiebaUidReqIdl_DataReq() / GetUserByTiebaUidReqIdl_DataReq.new instead')
  static GetUserByTiebaUidReqIdl_DataReq create() =>
      GetUserByTiebaUidReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetUserByTiebaUidReqIdl_DataReq._();
  @$core.override
  GetUserByTiebaUidReqIdl_DataReq createEmptyInstance() =>
      GetUserByTiebaUidReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetUserByTiebaUidReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserByTiebaUidReqIdl_DataReq>(
          GetUserByTiebaUidReqIdl_DataReq.$_createMessage);
  static GetUserByTiebaUidReqIdl_DataReq? _defaultInstance;

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
  $core.String get tiebaUid => $_getSZ(1);
  @$pb.TagNumber(2)
  set tiebaUid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTiebaUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearTiebaUid() => $_clearField(2);
}

class GetUserByTiebaUidReqIdl extends $pb.GeneratedMessage {
  factory GetUserByTiebaUidReqIdl({
    GetUserByTiebaUidReqIdl_DataReq? data,
  }) {
    final result = GetUserByTiebaUidReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetUserByTiebaUidReqIdl._();

  factory GetUserByTiebaUidReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidReqIdl()..mergeFromBuffer(data, registry);
  factory GetUserByTiebaUidReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserByTiebaUidReqIdl',
      createEmptyInstance: GetUserByTiebaUidReqIdl.$_createMessage)
    ..aOM<GetUserByTiebaUidReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetUserByTiebaUidReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidReqIdl copyWith(
          void Function(GetUserByTiebaUidReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetUserByTiebaUidReqIdl))
          as GetUserByTiebaUidReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserByTiebaUidReqIdl() / GetUserByTiebaUidReqIdl.new instead')
  static GetUserByTiebaUidReqIdl create() => GetUserByTiebaUidReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetUserByTiebaUidReqIdl._();
  @$core.override
  GetUserByTiebaUidReqIdl createEmptyInstance() => GetUserByTiebaUidReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetUserByTiebaUidReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserByTiebaUidReqIdl>(
          GetUserByTiebaUidReqIdl.$_createMessage);
  static GetUserByTiebaUidReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetUserByTiebaUidReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetUserByTiebaUidReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetUserByTiebaUidReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
