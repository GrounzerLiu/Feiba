// This is a generated file - do not edit.
//
// Generated from CommitReceivedPmsgReqIdl.proto.

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

class CommitReceivedPmsgReqIdl_DataReq extends $pb.GeneratedMessage {
  factory CommitReceivedPmsgReqIdl_DataReq({
    $fixnum.Int64? groupId,
    $fixnum.Int64? toUid,
    $core.int? msgType,
    $fixnum.Int64? msgId,
  }) {
    final result = CommitReceivedPmsgReqIdl_DataReq._();
    if (groupId != null) result.groupId = groupId;
    if (toUid != null) result.toUid = toUid;
    if (msgType != null) result.msgType = msgType;
    if (msgId != null) result.msgId = msgId;
    return result;
  }

  CommitReceivedPmsgReqIdl_DataReq._();

  factory CommitReceivedPmsgReqIdl_DataReq.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory CommitReceivedPmsgReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitReceivedPmsgReqIdl.DataReq',
      createEmptyInstance: CommitReceivedPmsgReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aInt64(2, _omitFieldNames ? '' : 'toUid', protoName: 'toUid')
    ..aI(3, _omitFieldNames ? '' : 'msgType', protoName: 'msgType')
    ..aInt64(4, _omitFieldNames ? '' : 'msgId', protoName: 'msgId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgReqIdl_DataReq copyWith(
          void Function(CommitReceivedPmsgReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as CommitReceivedPmsgReqIdl_DataReq))
          as CommitReceivedPmsgReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitReceivedPmsgReqIdl_DataReq() / CommitReceivedPmsgReqIdl_DataReq.new instead')
  static CommitReceivedPmsgReqIdl_DataReq create() =>
      CommitReceivedPmsgReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      CommitReceivedPmsgReqIdl_DataReq._();
  @$core.override
  CommitReceivedPmsgReqIdl_DataReq createEmptyInstance() =>
      CommitReceivedPmsgReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static CommitReceivedPmsgReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitReceivedPmsgReqIdl_DataReq>(
          CommitReceivedPmsgReqIdl_DataReq.$_createMessage);
  static CommitReceivedPmsgReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get groupId => $_getI64(0);
  @$pb.TagNumber(1)
  set groupId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get toUid => $_getI64(1);
  @$pb.TagNumber(2)
  set toUid($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearToUid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get msgType => $_getIZ(2);
  @$pb.TagNumber(3)
  set msgType($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsgType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsgType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get msgId => $_getI64(3);
  @$pb.TagNumber(4)
  set msgId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsgId() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsgId() => $_clearField(4);
}

class CommitReceivedPmsgReqIdl extends $pb.GeneratedMessage {
  factory CommitReceivedPmsgReqIdl({
    CommitReceivedPmsgReqIdl_DataReq? data,
  }) {
    final result = CommitReceivedPmsgReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  CommitReceivedPmsgReqIdl._();

  factory CommitReceivedPmsgReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgReqIdl()..mergeFromBuffer(data, registry);
  factory CommitReceivedPmsgReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitReceivedPmsgReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitReceivedPmsgReqIdl',
      createEmptyInstance: CommitReceivedPmsgReqIdl.$_createMessage)
    ..aOM<CommitReceivedPmsgReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: CommitReceivedPmsgReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitReceivedPmsgReqIdl copyWith(
          void Function(CommitReceivedPmsgReqIdl) updates) =>
      super.copyWith((message) => updates(message as CommitReceivedPmsgReqIdl))
          as CommitReceivedPmsgReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitReceivedPmsgReqIdl() / CommitReceivedPmsgReqIdl.new instead')
  static CommitReceivedPmsgReqIdl create() => CommitReceivedPmsgReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => CommitReceivedPmsgReqIdl._();
  @$core.override
  CommitReceivedPmsgReqIdl createEmptyInstance() =>
      CommitReceivedPmsgReqIdl._();
  @$core.pragma('dart2js:noInline')
  static CommitReceivedPmsgReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitReceivedPmsgReqIdl>(
          CommitReceivedPmsgReqIdl.$_createMessage);
  static CommitReceivedPmsgReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  CommitReceivedPmsgReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(CommitReceivedPmsgReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  CommitReceivedPmsgReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
