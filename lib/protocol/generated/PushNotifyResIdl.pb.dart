// This is a generated file - do not edit.
//
// Generated from PushNotifyResIdl.proto.

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

class PushNotifyResIdl_PusherMsg_PusherMsgInfo extends $pb.GeneratedMessage {
  factory PushNotifyResIdl_PusherMsg_PusherMsgInfo({
    $fixnum.Int64? groupId,
    $fixnum.Int64? msgId,
    $core.int? type,
    $core.String? et,
    $core.int? groupType,
  }) {
    final result = PushNotifyResIdl_PusherMsg_PusherMsgInfo._();
    if (groupId != null) result.groupId = groupId;
    if (msgId != null) result.msgId = msgId;
    if (type != null) result.type = type;
    if (et != null) result.et = et;
    if (groupType != null) result.groupType = groupType;
    return result;
  }

  PushNotifyResIdl_PusherMsg_PusherMsgInfo._();

  factory PushNotifyResIdl_PusherMsg_PusherMsgInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl_PusherMsg_PusherMsgInfo()
        ..mergeFromBuffer(data, registry);
  factory PushNotifyResIdl_PusherMsg_PusherMsgInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl_PusherMsg_PusherMsgInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PushNotifyResIdl.PusherMsg.PusherMsgInfo',
      createEmptyInstance:
          PushNotifyResIdl_PusherMsg_PusherMsgInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aInt64(2, _omitFieldNames ? '' : 'msgId', protoName: 'msgId')
    ..aI(4, _omitFieldNames ? '' : 'type')
    ..aOS(6, _omitFieldNames ? '' : 'et')
    ..aI(7, _omitFieldNames ? '' : 'groupType', protoName: 'groupType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl_PusherMsg_PusherMsgInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl_PusherMsg_PusherMsgInfo copyWith(
          void Function(PushNotifyResIdl_PusherMsg_PusherMsgInfo) updates) =>
      super.copyWith((message) =>
              updates(message as PushNotifyResIdl_PusherMsg_PusherMsgInfo))
          as PushNotifyResIdl_PusherMsg_PusherMsgInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PushNotifyResIdl_PusherMsg_PusherMsgInfo() / PushNotifyResIdl_PusherMsg_PusherMsgInfo.new instead')
  static PushNotifyResIdl_PusherMsg_PusherMsgInfo create() =>
      PushNotifyResIdl_PusherMsg_PusherMsgInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      PushNotifyResIdl_PusherMsg_PusherMsgInfo._();
  @$core.override
  PushNotifyResIdl_PusherMsg_PusherMsgInfo createEmptyInstance() =>
      PushNotifyResIdl_PusherMsg_PusherMsgInfo._();
  @$core.pragma('dart2js:noInline')
  static PushNotifyResIdl_PusherMsg_PusherMsgInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              PushNotifyResIdl_PusherMsg_PusherMsgInfo>(
          PushNotifyResIdl_PusherMsg_PusherMsgInfo.$_createMessage);
  static PushNotifyResIdl_PusherMsg_PusherMsgInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get groupId => $_getI64(0);
  @$pb.TagNumber(1)
  set groupId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get msgId => $_getI64(1);
  @$pb.TagNumber(2)
  set msgId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsgId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsgId() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.int get type => $_getIZ(2);
  @$pb.TagNumber(4)
  set type($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(6)
  $core.String get et => $_getSZ(3);
  @$pb.TagNumber(6)
  set et($core.String value) => $_setString(3, value);
  @$pb.TagNumber(6)
  $core.bool hasEt() => $_has(3);
  @$pb.TagNumber(6)
  void clearEt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get groupType => $_getIZ(4);
  @$pb.TagNumber(7)
  set groupType($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(7)
  $core.bool hasGroupType() => $_has(4);
  @$pb.TagNumber(7)
  void clearGroupType() => $_clearField(7);
}

class PushNotifyResIdl_PusherMsg extends $pb.GeneratedMessage {
  factory PushNotifyResIdl_PusherMsg({
    PushNotifyResIdl_PusherMsg_PusherMsgInfo? data,
  }) {
    final result = PushNotifyResIdl_PusherMsg._();
    if (data != null) result.data = data;
    return result;
  }

  PushNotifyResIdl_PusherMsg._();

  factory PushNotifyResIdl_PusherMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl_PusherMsg()..mergeFromBuffer(data, registry);
  factory PushNotifyResIdl_PusherMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl_PusherMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PushNotifyResIdl.PusherMsg',
      createEmptyInstance: PushNotifyResIdl_PusherMsg.$_createMessage)
    ..aOM<PushNotifyResIdl_PusherMsg_PusherMsgInfo>(
        2, _omitFieldNames ? '' : 'data',
        subBuilder: PushNotifyResIdl_PusherMsg_PusherMsgInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl_PusherMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl_PusherMsg copyWith(
          void Function(PushNotifyResIdl_PusherMsg) updates) =>
      super.copyWith(
              (message) => updates(message as PushNotifyResIdl_PusherMsg))
          as PushNotifyResIdl_PusherMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PushNotifyResIdl_PusherMsg() / PushNotifyResIdl_PusherMsg.new instead')
  static PushNotifyResIdl_PusherMsg create() => PushNotifyResIdl_PusherMsg._();
  static $pb.GeneratedMessage $_createMessage() =>
      PushNotifyResIdl_PusherMsg._();
  @$core.override
  PushNotifyResIdl_PusherMsg createEmptyInstance() =>
      PushNotifyResIdl_PusherMsg._();
  @$core.pragma('dart2js:noInline')
  static PushNotifyResIdl_PusherMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PushNotifyResIdl_PusherMsg>(
          PushNotifyResIdl_PusherMsg.$_createMessage);
  static PushNotifyResIdl_PusherMsg? _defaultInstance;

  @$pb.TagNumber(2)
  PushNotifyResIdl_PusherMsg_PusherMsgInfo get data => $_getN(0);
  @$pb.TagNumber(2)
  set data(PushNotifyResIdl_PusherMsg_PusherMsgInfo value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  PushNotifyResIdl_PusherMsg_PusherMsgInfo ensureData() => $_ensure(0);
}

class PushNotifyResIdl extends $pb.GeneratedMessage {
  factory PushNotifyResIdl({
    $core.Iterable<PushNotifyResIdl_PusherMsg>? multiMsg,
  }) {
    final result = PushNotifyResIdl._();
    if (multiMsg != null) result.multiMsg.addAll(multiMsg);
    return result;
  }

  PushNotifyResIdl._();

  factory PushNotifyResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl()..mergeFromBuffer(data, registry);
  factory PushNotifyResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PushNotifyResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PushNotifyResIdl',
      createEmptyInstance: PushNotifyResIdl.$_createMessage)
    ..pPM<PushNotifyResIdl_PusherMsg>(2, _omitFieldNames ? '' : 'multiMsg',
        protoName: 'multiMsg',
        subBuilder: PushNotifyResIdl_PusherMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushNotifyResIdl copyWith(void Function(PushNotifyResIdl) updates) =>
      super.copyWith((message) => updates(message as PushNotifyResIdl))
          as PushNotifyResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PushNotifyResIdl() / PushNotifyResIdl.new instead')
  static PushNotifyResIdl create() => PushNotifyResIdl._();
  static $pb.GeneratedMessage $_createMessage() => PushNotifyResIdl._();
  @$core.override
  PushNotifyResIdl createEmptyInstance() => PushNotifyResIdl._();
  @$core.pragma('dart2js:noInline')
  static PushNotifyResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotifyResIdl>(
          PushNotifyResIdl.$_createMessage);
  static PushNotifyResIdl? _defaultInstance;

  @$pb.TagNumber(2)
  $pb.PbList<PushNotifyResIdl_PusherMsg> get multiMsg => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
