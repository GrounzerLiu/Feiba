// This is a generated file - do not edit.
//
// Generated from GetGroupMsgReqIdl.proto.

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

class GetGroupMsgReqIdl_DataReq_GroupLastId extends $pb.GeneratedMessage {
  factory GetGroupMsgReqIdl_DataReq_GroupLastId({
    $fixnum.Int64? groupId,
    $fixnum.Int64? lastMsgId,
  }) {
    final result = GetGroupMsgReqIdl_DataReq_GroupLastId._();
    if (groupId != null) result.groupId = groupId;
    if (lastMsgId != null) result.lastMsgId = lastMsgId;
    return result;
  }

  GetGroupMsgReqIdl_DataReq_GroupLastId._();

  factory GetGroupMsgReqIdl_DataReq_GroupLastId.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl_DataReq_GroupLastId()..mergeFromBuffer(data, registry);
  factory GetGroupMsgReqIdl_DataReq_GroupLastId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl_DataReq_GroupLastId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgReqIdl.DataReq.GroupLastId',
      createEmptyInstance:
          GetGroupMsgReqIdl_DataReq_GroupLastId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aInt64(2, _omitFieldNames ? '' : 'lastMsgId', protoName: 'lastMsgId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl_DataReq_GroupLastId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl_DataReq_GroupLastId copyWith(
          void Function(GetGroupMsgReqIdl_DataReq_GroupLastId) updates) =>
      super.copyWith((message) =>
              updates(message as GetGroupMsgReqIdl_DataReq_GroupLastId))
          as GetGroupMsgReqIdl_DataReq_GroupLastId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgReqIdl_DataReq_GroupLastId() / GetGroupMsgReqIdl_DataReq_GroupLastId.new instead')
  static GetGroupMsgReqIdl_DataReq_GroupLastId create() =>
      GetGroupMsgReqIdl_DataReq_GroupLastId._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgReqIdl_DataReq_GroupLastId._();
  @$core.override
  GetGroupMsgReqIdl_DataReq_GroupLastId createEmptyInstance() =>
      GetGroupMsgReqIdl_DataReq_GroupLastId._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgReqIdl_DataReq_GroupLastId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetGroupMsgReqIdl_DataReq_GroupLastId>(
          GetGroupMsgReqIdl_DataReq_GroupLastId.$_createMessage);
  static GetGroupMsgReqIdl_DataReq_GroupLastId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get groupId => $_getI64(0);
  @$pb.TagNumber(1)
  set groupId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lastMsgId => $_getI64(1);
  @$pb.TagNumber(2)
  set lastMsgId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastMsgId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastMsgId() => $_clearField(2);
}

class GetGroupMsgReqIdl_DataReq extends $pb.GeneratedMessage {
  factory GetGroupMsgReqIdl_DataReq({
    $core.Iterable<GetGroupMsgReqIdl_DataReq_GroupLastId>? groupMids,
    $core.String? gettype,
  }) {
    final result = GetGroupMsgReqIdl_DataReq._();
    if (groupMids != null) result.groupMids.addAll(groupMids);
    if (gettype != null) result.gettype = gettype;
    return result;
  }

  GetGroupMsgReqIdl_DataReq._();

  factory GetGroupMsgReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory GetGroupMsgReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgReqIdl.DataReq',
      createEmptyInstance: GetGroupMsgReqIdl_DataReq.$_createMessage)
    ..pPM<GetGroupMsgReqIdl_DataReq_GroupLastId>(
        6, _omitFieldNames ? '' : 'groupMids',
        protoName: 'groupMids',
        subBuilder: GetGroupMsgReqIdl_DataReq_GroupLastId.$_createMessage)
    ..aOS(7, _omitFieldNames ? '' : 'gettype')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl_DataReq copyWith(
          void Function(GetGroupMsgReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as GetGroupMsgReqIdl_DataReq))
          as GetGroupMsgReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgReqIdl_DataReq() / GetGroupMsgReqIdl_DataReq.new instead')
  static GetGroupMsgReqIdl_DataReq create() => GetGroupMsgReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgReqIdl_DataReq._();
  @$core.override
  GetGroupMsgReqIdl_DataReq createEmptyInstance() =>
      GetGroupMsgReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupMsgReqIdl_DataReq>(
          GetGroupMsgReqIdl_DataReq.$_createMessage);
  static GetGroupMsgReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(6)
  $pb.PbList<GetGroupMsgReqIdl_DataReq_GroupLastId> get groupMids =>
      $_getList(0);

  @$pb.TagNumber(7)
  $core.String get gettype => $_getSZ(1);
  @$pb.TagNumber(7)
  set gettype($core.String value) => $_setString(1, value);
  @$pb.TagNumber(7)
  $core.bool hasGettype() => $_has(1);
  @$pb.TagNumber(7)
  void clearGettype() => $_clearField(7);
}

class GetGroupMsgReqIdl extends $pb.GeneratedMessage {
  factory GetGroupMsgReqIdl({
    $core.String? cuid,
    GetGroupMsgReqIdl_DataReq? data,
  }) {
    final result = GetGroupMsgReqIdl._();
    if (cuid != null) result.cuid = cuid;
    if (data != null) result.data = data;
    return result;
  }

  GetGroupMsgReqIdl._();

  factory GetGroupMsgReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl()..mergeFromBuffer(data, registry);
  factory GetGroupMsgReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgReqIdl',
      createEmptyInstance: GetGroupMsgReqIdl.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'cuid')
    ..aOM<GetGroupMsgReqIdl_DataReq>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetGroupMsgReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgReqIdl copyWith(void Function(GetGroupMsgReqIdl) updates) =>
      super.copyWith((message) => updates(message as GetGroupMsgReqIdl))
          as GetGroupMsgReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetGroupMsgReqIdl() / GetGroupMsgReqIdl.new instead')
  static GetGroupMsgReqIdl create() => GetGroupMsgReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetGroupMsgReqIdl._();
  @$core.override
  GetGroupMsgReqIdl createEmptyInstance() => GetGroupMsgReqIdl._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupMsgReqIdl>(
          GetGroupMsgReqIdl.$_createMessage);
  static GetGroupMsgReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCuid() => $_clearField(1);

  @$pb.TagNumber(2)
  GetGroupMsgReqIdl_DataReq get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetGroupMsgReqIdl_DataReq value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetGroupMsgReqIdl_DataReq ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
