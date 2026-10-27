// This is a generated file - do not edit.
//
// Generated from CommitReceivedPmsgResIdl.proto.

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

class CommitReceivedPmsgResIdl_DataRes extends $pb.GeneratedMessage {
  factory CommitReceivedPmsgResIdl_DataRes({
    $fixnum.Int64? readMsgId,
    $fixnum.Int64? groupId,
    $fixnum.Int64? toUid,
    $core.int? toUserType,
  }) {
    final result = CommitReceivedPmsgResIdl_DataRes._();
    if (readMsgId != null) result.readMsgId = readMsgId;
    if (groupId != null) result.groupId = groupId;
    if (toUid != null) result.toUid = toUid;
    if (toUserType != null) result.toUserType = toUserType;
    return result;
  }

  CommitReceivedPmsgResIdl_DataRes._();

  factory CommitReceivedPmsgResIdl_DataRes.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory CommitReceivedPmsgResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitReceivedPmsgResIdl.DataRes',
      createEmptyInstance: CommitReceivedPmsgResIdl_DataRes.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'readMsgId', protoName: 'readMsgId')
    ..aInt64(2, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aInt64(3, _omitFieldNames ? '' : 'toUid', protoName: 'toUid')
    ..aI(4, _omitFieldNames ? '' : 'toUserType', protoName: 'toUserType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgResIdl_DataRes copyWith(
          void Function(CommitReceivedPmsgResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as CommitReceivedPmsgResIdl_DataRes))
          as CommitReceivedPmsgResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitReceivedPmsgResIdl_DataRes() / CommitReceivedPmsgResIdl_DataRes.new instead')
  static CommitReceivedPmsgResIdl_DataRes create() =>
      CommitReceivedPmsgResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      CommitReceivedPmsgResIdl_DataRes._();
  @$core.override
  CommitReceivedPmsgResIdl_DataRes createEmptyInstance() =>
      CommitReceivedPmsgResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static CommitReceivedPmsgResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitReceivedPmsgResIdl_DataRes>(
          CommitReceivedPmsgResIdl_DataRes.$_createMessage);
  static CommitReceivedPmsgResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get readMsgId => $_getI64(0);
  @$pb.TagNumber(1)
  set readMsgId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReadMsgId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadMsgId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get groupId => $_getI64(1);
  @$pb.TagNumber(2)
  set groupId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get toUid => $_getI64(2);
  @$pb.TagNumber(3)
  set toUid($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToUid() => $_has(2);
  @$pb.TagNumber(3)
  void clearToUid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get toUserType => $_getIZ(3);
  @$pb.TagNumber(4)
  set toUserType($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToUserType() => $_has(3);
  @$pb.TagNumber(4)
  void clearToUserType() => $_clearField(4);
}

class CommitReceivedPmsgResIdl extends $pb.GeneratedMessage {
  factory CommitReceivedPmsgResIdl({
    $0.Error? error,
    CommitReceivedPmsgResIdl_DataRes? data,
  }) {
    final result = CommitReceivedPmsgResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  CommitReceivedPmsgResIdl._();

  factory CommitReceivedPmsgResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgResIdl()..mergeFromBuffer(data, registry);
  factory CommitReceivedPmsgResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitReceivedPmsgResIdl',
      createEmptyInstance: CommitReceivedPmsgResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<CommitReceivedPmsgResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: CommitReceivedPmsgResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgResIdl copyWith(
          void Function(CommitReceivedPmsgResIdl) updates) =>
      super.copyWith((message) => updates(message as CommitReceivedPmsgResIdl))
          as CommitReceivedPmsgResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitReceivedPmsgResIdl() / CommitReceivedPmsgResIdl.new instead')
  static CommitReceivedPmsgResIdl create() => CommitReceivedPmsgResIdl._();
  static $pb.GeneratedMessage $_createMessage() => CommitReceivedPmsgResIdl._();
  @$core.override
  CommitReceivedPmsgResIdl createEmptyInstance() =>
      CommitReceivedPmsgResIdl._();
  @$core.pragma('dart2js:noInline')
  static CommitReceivedPmsgResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitReceivedPmsgResIdl>(
          CommitReceivedPmsgResIdl.$_createMessage);
  static CommitReceivedPmsgResIdl? _defaultInstance;

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
  CommitReceivedPmsgResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(CommitReceivedPmsgResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  CommitReceivedPmsgResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
