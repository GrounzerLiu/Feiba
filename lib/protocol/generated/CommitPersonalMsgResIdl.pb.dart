// This is a generated file - do not edit.
//
// Generated from CommitPersonalMsgResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CommitPersonalMsgResIdl_DataRes_BlockInfo extends $pb.GeneratedMessage {
  factory CommitPersonalMsgResIdl_DataRes_BlockInfo({
    $core.int? blockErrno,
    $core.String? blockErrmsg,
  }) {
    final result = CommitPersonalMsgResIdl_DataRes_BlockInfo._();
    if (blockErrno != null) result.blockErrno = blockErrno;
    if (blockErrmsg != null) result.blockErrmsg = blockErrmsg;
    return result;
  }

  CommitPersonalMsgResIdl_DataRes_BlockInfo._();

  factory CommitPersonalMsgResIdl_DataRes_BlockInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl_DataRes_BlockInfo()
        ..mergeFromBuffer(data, registry);
  factory CommitPersonalMsgResIdl_DataRes_BlockInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl_DataRes_BlockInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitPersonalMsgResIdl.DataRes.BlockInfo',
      createEmptyInstance:
          CommitPersonalMsgResIdl_DataRes_BlockInfo.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'blockErrno', protoName: 'blockErrno')
    ..aOS(2, _omitFieldNames ? '' : 'blockErrmsg', protoName: 'blockErrmsg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl_DataRes_BlockInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl_DataRes_BlockInfo copyWith(
          void Function(CommitPersonalMsgResIdl_DataRes_BlockInfo) updates) =>
      super.copyWith((message) =>
              updates(message as CommitPersonalMsgResIdl_DataRes_BlockInfo))
          as CommitPersonalMsgResIdl_DataRes_BlockInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitPersonalMsgResIdl_DataRes_BlockInfo() / CommitPersonalMsgResIdl_DataRes_BlockInfo.new instead')
  static CommitPersonalMsgResIdl_DataRes_BlockInfo create() =>
      CommitPersonalMsgResIdl_DataRes_BlockInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      CommitPersonalMsgResIdl_DataRes_BlockInfo._();
  @$core.override
  CommitPersonalMsgResIdl_DataRes_BlockInfo createEmptyInstance() =>
      CommitPersonalMsgResIdl_DataRes_BlockInfo._();
  @$core.pragma('dart2js:noInline')
  static CommitPersonalMsgResIdl_DataRes_BlockInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              CommitPersonalMsgResIdl_DataRes_BlockInfo>(
          CommitPersonalMsgResIdl_DataRes_BlockInfo.$_createMessage);
  static CommitPersonalMsgResIdl_DataRes_BlockInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get blockErrno => $_getIZ(0);
  @$pb.TagNumber(1)
  set blockErrno($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBlockErrno() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockErrno() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get blockErrmsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set blockErrmsg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlockErrmsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlockErrmsg() => $_clearField(2);
}

class CommitPersonalMsgResIdl_DataRes extends $pb.GeneratedMessage {
  factory CommitPersonalMsgResIdl_DataRes({
    $fixnum.Int64? msgId,
    $fixnum.Int64? groupId,
    $fixnum.Int64? recordId,
    $fixnum.Int64? toUid,
    $core.int? toUserType,
    CommitPersonalMsgResIdl_DataRes_BlockInfo? blockInfo,
  }) {
    final result = CommitPersonalMsgResIdl_DataRes._();
    if (msgId != null) result.msgId = msgId;
    if (groupId != null) result.groupId = groupId;
    if (recordId != null) result.recordId = recordId;
    if (toUid != null) result.toUid = toUid;
    if (toUserType != null) result.toUserType = toUserType;
    if (blockInfo != null) result.blockInfo = blockInfo;
    return result;
  }

  CommitPersonalMsgResIdl_DataRes._();

  factory CommitPersonalMsgResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory CommitPersonalMsgResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitPersonalMsgResIdl.DataRes',
      createEmptyInstance: CommitPersonalMsgResIdl_DataRes.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'msgId', protoName: 'msgId')
    ..aInt64(2, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aInt64(3, _omitFieldNames ? '' : 'recordId', protoName: 'recordId')
    ..aInt64(4, _omitFieldNames ? '' : 'toUid', protoName: 'toUid')
    ..aI(5, _omitFieldNames ? '' : 'toUserType', protoName: 'toUserType')
    ..aOM<CommitPersonalMsgResIdl_DataRes_BlockInfo>(
        6, _omitFieldNames ? '' : 'blockInfo',
        protoName: 'blockInfo',
        subBuilder: CommitPersonalMsgResIdl_DataRes_BlockInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl_DataRes copyWith(
          void Function(CommitPersonalMsgResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as CommitPersonalMsgResIdl_DataRes))
          as CommitPersonalMsgResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitPersonalMsgResIdl_DataRes() / CommitPersonalMsgResIdl_DataRes.new instead')
  static CommitPersonalMsgResIdl_DataRes create() =>
      CommitPersonalMsgResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      CommitPersonalMsgResIdl_DataRes._();
  @$core.override
  CommitPersonalMsgResIdl_DataRes createEmptyInstance() =>
      CommitPersonalMsgResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static CommitPersonalMsgResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitPersonalMsgResIdl_DataRes>(
          CommitPersonalMsgResIdl_DataRes.$_createMessage);
  static CommitPersonalMsgResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get msgId => $_getI64(0);
  @$pb.TagNumber(1)
  set msgId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMsgId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsgId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get groupId => $_getI64(1);
  @$pb.TagNumber(2)
  set groupId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get recordId => $_getI64(2);
  @$pb.TagNumber(3)
  set recordId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecordId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecordId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get toUid => $_getI64(3);
  @$pb.TagNumber(4)
  set toUid($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToUid() => $_has(3);
  @$pb.TagNumber(4)
  void clearToUid() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get toUserType => $_getIZ(4);
  @$pb.TagNumber(5)
  set toUserType($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasToUserType() => $_has(4);
  @$pb.TagNumber(5)
  void clearToUserType() => $_clearField(5);

  @$pb.TagNumber(6)
  CommitPersonalMsgResIdl_DataRes_BlockInfo get blockInfo => $_getN(5);
  @$pb.TagNumber(6)
  set blockInfo(CommitPersonalMsgResIdl_DataRes_BlockInfo value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasBlockInfo() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlockInfo() => $_clearField(6);
  @$pb.TagNumber(6)
  CommitPersonalMsgResIdl_DataRes_BlockInfo ensureBlockInfo() => $_ensure(5);
}

class CommitPersonalMsgResIdl extends $pb.GeneratedMessage {
  factory CommitPersonalMsgResIdl({
    $0.Error? error,
    CommitPersonalMsgResIdl_DataRes? data,
  }) {
    final result = CommitPersonalMsgResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  CommitPersonalMsgResIdl._();

  factory CommitPersonalMsgResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl()..mergeFromBuffer(data, registry);
  factory CommitPersonalMsgResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitPersonalMsgResIdl',
      createEmptyInstance: CommitPersonalMsgResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<CommitPersonalMsgResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: CommitPersonalMsgResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgResIdl copyWith(
          void Function(CommitPersonalMsgResIdl) updates) =>
      super.copyWith((message) => updates(message as CommitPersonalMsgResIdl))
          as CommitPersonalMsgResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitPersonalMsgResIdl() / CommitPersonalMsgResIdl.new instead')
  static CommitPersonalMsgResIdl create() => CommitPersonalMsgResIdl._();
  static $pb.GeneratedMessage $_createMessage() => CommitPersonalMsgResIdl._();
  @$core.override
  CommitPersonalMsgResIdl createEmptyInstance() => CommitPersonalMsgResIdl._();
  @$core.pragma('dart2js:noInline')
  static CommitPersonalMsgResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitPersonalMsgResIdl>(
          CommitPersonalMsgResIdl.$_createMessage);
  static CommitPersonalMsgResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($0.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  CommitPersonalMsgResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(CommitPersonalMsgResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  CommitPersonalMsgResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
