// This is a generated file - do not edit.
//
// Generated from GetForumSquareReqIdl.proto.

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

class GetForumSquareReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetForumSquareReqIdl_DataReq({
    $0.CommonReq? common,
    $core.String? className,
    $core.int? pn,
    $core.int? rn,
    $fixnum.Int64? userId,
  }) {
    final result = GetForumSquareReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (className != null) result.className = className;
    if (pn != null) result.pn = pn;
    if (rn != null) result.rn = rn;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetForumSquareReqIdl_DataReq._();

  factory GetForumSquareReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetForumSquareReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumSquareReqIdl.DataReq',
      createEmptyInstance: GetForumSquareReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'className')
    ..aI(3, _omitFieldNames ? '' : 'pn')
    ..aI(4, _omitFieldNames ? '' : 'rn')
    ..aInt64(5, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareReqIdl_DataReq copyWith(
          void Function(GetForumSquareReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as GetForumSquareReqIdl_DataReq))
          as GetForumSquareReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumSquareReqIdl_DataReq() / GetForumSquareReqIdl_DataReq.new instead')
  static GetForumSquareReqIdl_DataReq create() =>
      GetForumSquareReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumSquareReqIdl_DataReq._();
  @$core.override
  GetForumSquareReqIdl_DataReq createEmptyInstance() =>
      GetForumSquareReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetForumSquareReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumSquareReqIdl_DataReq>(
          GetForumSquareReqIdl_DataReq.$_createMessage);
  static GetForumSquareReqIdl_DataReq? _defaultInstance;

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
  $core.String get className => $_getSZ(1);
  @$pb.TagNumber(2)
  set className($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClassName() => $_has(1);
  @$pb.TagNumber(2)
  void clearClassName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pn => $_getIZ(2);
  @$pb.TagNumber(3)
  set pn($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPn() => $_has(2);
  @$pb.TagNumber(3)
  void clearPn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get rn => $_getIZ(3);
  @$pb.TagNumber(4)
  set rn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRn() => $_has(3);
  @$pb.TagNumber(4)
  void clearRn() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get userId => $_getI64(4);
  @$pb.TagNumber(5)
  set userId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);
}

class GetForumSquareReqIdl extends $pb.GeneratedMessage {
  factory GetForumSquareReqIdl({
    GetForumSquareReqIdl_DataReq? data,
  }) {
    final result = GetForumSquareReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetForumSquareReqIdl._();

  factory GetForumSquareReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareReqIdl()..mergeFromBuffer(data, registry);
  factory GetForumSquareReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumSquareReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumSquareReqIdl',
      createEmptyInstance: GetForumSquareReqIdl.$_createMessage)
    ..aOM<GetForumSquareReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetForumSquareReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumSquareReqIdl copyWith(void Function(GetForumSquareReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetForumSquareReqIdl))
          as GetForumSquareReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumSquareReqIdl() / GetForumSquareReqIdl.new instead')
  static GetForumSquareReqIdl create() => GetForumSquareReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetForumSquareReqIdl._();
  @$core.override
  GetForumSquareReqIdl createEmptyInstance() => GetForumSquareReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetForumSquareReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumSquareReqIdl>(
          GetForumSquareReqIdl.$_createMessage);
  static GetForumSquareReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetForumSquareReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetForumSquareReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetForumSquareReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
