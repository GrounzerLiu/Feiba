// This is a generated file - do not edit.
//
// Generated from GetUserInfoReqIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetUserInfoReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetUserInfoReqIdl_DataReq({
    $fixnum.Int64? userId,
  }) {
    final result = GetUserInfoReqIdl_DataReq._();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserInfoReqIdl_DataReq._();

  factory GetUserInfoReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetUserInfoReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInfoReqIdl.DataReq',
      createEmptyInstance: GetUserInfoReqIdl_DataReq.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoReqIdl_DataReq copyWith(
          void Function(GetUserInfoReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as GetUserInfoReqIdl_DataReq))
          as GetUserInfoReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserInfoReqIdl_DataReq() / GetUserInfoReqIdl_DataReq.new instead')
  static GetUserInfoReqIdl_DataReq create() => GetUserInfoReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetUserInfoReqIdl_DataReq._();
  @$core.override
  GetUserInfoReqIdl_DataReq createEmptyInstance() =>
      GetUserInfoReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetUserInfoReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInfoReqIdl_DataReq>(
          GetUserInfoReqIdl_DataReq.$_createMessage);
  static GetUserInfoReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class GetUserInfoReqIdl extends $pb.GeneratedMessage {
  factory GetUserInfoReqIdl({
    GetUserInfoReqIdl_DataReq? data,
  }) {
    final result = GetUserInfoReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetUserInfoReqIdl._();

  factory GetUserInfoReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoReqIdl()..mergeFromBuffer(data, registry);
  factory GetUserInfoReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInfoReqIdl',
      createEmptyInstance: GetUserInfoReqIdl.$_createMessage)
    ..aOM<GetUserInfoReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetUserInfoReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoReqIdl copyWith(void Function(GetUserInfoReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetUserInfoReqIdl))
          as GetUserInfoReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUserInfoReqIdl() / GetUserInfoReqIdl.new instead')
  static GetUserInfoReqIdl create() => GetUserInfoReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetUserInfoReqIdl._();
  @$core.override
  GetUserInfoReqIdl createEmptyInstance() => GetUserInfoReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetUserInfoReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInfoReqIdl>(
          GetUserInfoReqIdl.$_createMessage);
  static GetUserInfoReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetUserInfoReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetUserInfoReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetUserInfoReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
