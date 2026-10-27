// This is a generated file - do not edit.
//
// Generated from GetForumDetailReqIdl.proto.

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

class GetForumDetailReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetForumDetailReqIdl_DataReq({
    $fixnum.Int64? forumId,
    $0.CommonReq? common,
  }) {
    final result = GetForumDetailReqIdl_DataReq._();
    if (forumId != null) result.forumId = forumId;
    if (common != null) result.common = common;
    return result;
  }

  GetForumDetailReqIdl_DataReq._();

  factory GetForumDetailReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetForumDetailReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumDetailReqIdl.DataReq',
      createEmptyInstance: GetForumDetailReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'forumId')
    ..aOM<$0.CommonReq>(2, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailReqIdl_DataReq copyWith(
          void Function(GetForumDetailReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as GetForumDetailReqIdl_DataReq))
          as GetForumDetailReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailReqIdl_DataReq() / GetForumDetailReqIdl_DataReq.new instead')
  static GetForumDetailReqIdl_DataReq create() =>
      GetForumDetailReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumDetailReqIdl_DataReq._();
  @$core.override
  GetForumDetailReqIdl_DataReq createEmptyInstance() =>
      GetForumDetailReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumDetailReqIdl_DataReq>(
          GetForumDetailReqIdl_DataReq.$_createMessage);
  static GetForumDetailReqIdl_DataReq? _defaultInstance;

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

class GetForumDetailReqIdl extends $pb.GeneratedMessage {
  factory GetForumDetailReqIdl({
    GetForumDetailReqIdl_DataReq? data,
  }) {
    final result = GetForumDetailReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  GetForumDetailReqIdl._();

  factory GetForumDetailReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailReqIdl()..mergeFromBuffer(data, registry);
  factory GetForumDetailReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumDetailReqIdl',
      createEmptyInstance: GetForumDetailReqIdl.$_createMessage)
    ..aOM<GetForumDetailReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetForumDetailReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailReqIdl copyWith(void Function(GetForumDetailReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetForumDetailReqIdl))
          as GetForumDetailReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailReqIdl() / GetForumDetailReqIdl.new instead')
  static GetForumDetailReqIdl create() => GetForumDetailReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetForumDetailReqIdl._();
  @$core.override
  GetForumDetailReqIdl createEmptyInstance() => GetForumDetailReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumDetailReqIdl>(
          GetForumDetailReqIdl.$_createMessage);
  static GetForumDetailReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetForumDetailReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetForumDetailReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetForumDetailReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
