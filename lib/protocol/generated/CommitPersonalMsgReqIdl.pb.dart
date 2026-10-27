// This is a generated file - do not edit.
//
// Generated from CommitPersonalMsgReqIdl.proto.

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

class CommitPersonalMsgReqIdl_DataReq extends $pb.GeneratedMessage {
  factory CommitPersonalMsgReqIdl_DataReq({
    $fixnum.Int64? toUid,
    $core.int? msgType,
    $core.String? content,
    $fixnum.Int64? recordId,
  }) {
    final result = CommitPersonalMsgReqIdl_DataReq._();
    if (toUid != null) result.toUid = toUid;
    if (msgType != null) result.msgType = msgType;
    if (content != null) result.content = content;
    if (recordId != null) result.recordId = recordId;
    return result;
  }

  CommitPersonalMsgReqIdl_DataReq._();

  factory CommitPersonalMsgReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory CommitPersonalMsgReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitPersonalMsgReqIdl.DataReq',
      createEmptyInstance: CommitPersonalMsgReqIdl_DataReq.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'toUid', protoName: 'toUid')
    ..aI(3, _omitFieldNames ? '' : 'msgType', protoName: 'msgType')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aInt64(6, _omitFieldNames ? '' : 'recordId', protoName: 'recordId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgReqIdl_DataReq copyWith(
          void Function(CommitPersonalMsgReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as CommitPersonalMsgReqIdl_DataReq))
          as CommitPersonalMsgReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitPersonalMsgReqIdl_DataReq() / CommitPersonalMsgReqIdl_DataReq.new instead')
  static CommitPersonalMsgReqIdl_DataReq create() =>
      CommitPersonalMsgReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      CommitPersonalMsgReqIdl_DataReq._();
  @$core.override
  CommitPersonalMsgReqIdl_DataReq createEmptyInstance() =>
      CommitPersonalMsgReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static CommitPersonalMsgReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitPersonalMsgReqIdl_DataReq>(
          CommitPersonalMsgReqIdl_DataReq.$_createMessage);
  static CommitPersonalMsgReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(2)
  $fixnum.Int64 get toUid => $_getI64(0);
  @$pb.TagNumber(2)
  set toUid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(2)
  $core.bool hasToUid() => $_has(0);
  @$pb.TagNumber(2)
  void clearToUid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get msgType => $_getIZ(1);
  @$pb.TagNumber(3)
  set msgType($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasMsgType() => $_has(1);
  @$pb.TagNumber(3)
  void clearMsgType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get recordId => $_getI64(3);
  @$pb.TagNumber(6)
  set recordId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(6)
  $core.bool hasRecordId() => $_has(3);
  @$pb.TagNumber(6)
  void clearRecordId() => $_clearField(6);
}

class CommitPersonalMsgReqIdl extends $pb.GeneratedMessage {
  factory CommitPersonalMsgReqIdl({
    CommitPersonalMsgReqIdl_DataReq? data,
  }) {
    final result = CommitPersonalMsgReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  CommitPersonalMsgReqIdl._();

  factory CommitPersonalMsgReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgReqIdl()..mergeFromBuffer(data, registry);
  factory CommitPersonalMsgReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CommitPersonalMsgReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitPersonalMsgReqIdl',
      createEmptyInstance: CommitPersonalMsgReqIdl.$_createMessage)
    ..aOM<CommitPersonalMsgReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: CommitPersonalMsgReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitPersonalMsgReqIdl copyWith(
          void Function(CommitPersonalMsgReqIdl) updates) =>
      super.copyWith((message) => updates(message as CommitPersonalMsgReqIdl))
          as CommitPersonalMsgReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CommitPersonalMsgReqIdl() / CommitPersonalMsgReqIdl.new instead')
  static CommitPersonalMsgReqIdl create() => CommitPersonalMsgReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => CommitPersonalMsgReqIdl._();
  @$core.override
  CommitPersonalMsgReqIdl createEmptyInstance() => CommitPersonalMsgReqIdl._();
  @$core.pragma('dart2js:noInline')
  static CommitPersonalMsgReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitPersonalMsgReqIdl>(
          CommitPersonalMsgReqIdl.$_createMessage);
  static CommitPersonalMsgReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  CommitPersonalMsgReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(CommitPersonalMsgReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  CommitPersonalMsgReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
