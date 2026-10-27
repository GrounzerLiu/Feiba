// This is a generated file - do not edit.
//
// Generated from SetUserBlackReqIdl.proto.

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

class SetUserBlackReqIdl_DataReq_PermissionList extends $pb.GeneratedMessage {
  factory SetUserBlackReqIdl_DataReq_PermissionList({
    $core.int? follow,
    $core.int? interact,
    $core.int? chat,
  }) {
    final result = SetUserBlackReqIdl_DataReq_PermissionList._();
    if (follow != null) result.follow = follow;
    if (interact != null) result.interact = interact;
    if (chat != null) result.chat = chat;
    return result;
  }

  SetUserBlackReqIdl_DataReq_PermissionList._();

  factory SetUserBlackReqIdl_DataReq_PermissionList.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl_DataReq_PermissionList()
        ..mergeFromBuffer(data, registry);
  factory SetUserBlackReqIdl_DataReq_PermissionList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl_DataReq_PermissionList()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserBlackReqIdl.DataReq.PermissionList',
      createEmptyInstance:
          SetUserBlackReqIdl_DataReq_PermissionList.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'follow')
    ..aI(2, _omitFieldNames ? '' : 'interact')
    ..aI(3, _omitFieldNames ? '' : 'chat')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl_DataReq_PermissionList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl_DataReq_PermissionList copyWith(
          void Function(SetUserBlackReqIdl_DataReq_PermissionList) updates) =>
      super.copyWith((message) =>
              updates(message as SetUserBlackReqIdl_DataReq_PermissionList))
          as SetUserBlackReqIdl_DataReq_PermissionList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetUserBlackReqIdl_DataReq_PermissionList() / SetUserBlackReqIdl_DataReq_PermissionList.new instead')
  static SetUserBlackReqIdl_DataReq_PermissionList create() =>
      SetUserBlackReqIdl_DataReq_PermissionList._();
  static $pb.GeneratedMessage $_createMessage() =>
      SetUserBlackReqIdl_DataReq_PermissionList._();
  @$core.override
  SetUserBlackReqIdl_DataReq_PermissionList createEmptyInstance() =>
      SetUserBlackReqIdl_DataReq_PermissionList._();
  @$core.pragma('dart2js:noInline')
  static SetUserBlackReqIdl_DataReq_PermissionList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              SetUserBlackReqIdl_DataReq_PermissionList>(
          SetUserBlackReqIdl_DataReq_PermissionList.$_createMessage);
  static SetUserBlackReqIdl_DataReq_PermissionList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get follow => $_getIZ(0);
  @$pb.TagNumber(1)
  set follow($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFollow() => $_has(0);
  @$pb.TagNumber(1)
  void clearFollow() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get interact => $_getIZ(1);
  @$pb.TagNumber(2)
  set interact($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInteract() => $_has(1);
  @$pb.TagNumber(2)
  void clearInteract() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get chat => $_getIZ(2);
  @$pb.TagNumber(3)
  set chat($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChat() => $_has(2);
  @$pb.TagNumber(3)
  void clearChat() => $_clearField(3);
}

class SetUserBlackReqIdl_DataReq extends $pb.GeneratedMessage {
  factory SetUserBlackReqIdl_DataReq({
    $0.CommonReq? common,
    $fixnum.Int64? blackUid,
    SetUserBlackReqIdl_DataReq_PermissionList? permList,
  }) {
    final result = SetUserBlackReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (blackUid != null) result.blackUid = blackUid;
    if (permList != null) result.permList = permList;
    return result;
  }

  SetUserBlackReqIdl_DataReq._();

  factory SetUserBlackReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory SetUserBlackReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserBlackReqIdl.DataReq',
      createEmptyInstance: SetUserBlackReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'blackUid')
    ..aOM<SetUserBlackReqIdl_DataReq_PermissionList>(
        3, _omitFieldNames ? '' : 'permList',
        subBuilder: SetUserBlackReqIdl_DataReq_PermissionList.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl_DataReq copyWith(
          void Function(SetUserBlackReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as SetUserBlackReqIdl_DataReq))
          as SetUserBlackReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetUserBlackReqIdl_DataReq() / SetUserBlackReqIdl_DataReq.new instead')
  static SetUserBlackReqIdl_DataReq create() => SetUserBlackReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      SetUserBlackReqIdl_DataReq._();
  @$core.override
  SetUserBlackReqIdl_DataReq createEmptyInstance() =>
      SetUserBlackReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static SetUserBlackReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUserBlackReqIdl_DataReq>(
          SetUserBlackReqIdl_DataReq.$_createMessage);
  static SetUserBlackReqIdl_DataReq? _defaultInstance;

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
  $fixnum.Int64 get blackUid => $_getI64(1);
  @$pb.TagNumber(2)
  set blackUid($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlackUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlackUid() => $_clearField(2);

  @$pb.TagNumber(3)
  SetUserBlackReqIdl_DataReq_PermissionList get permList => $_getN(2);
  @$pb.TagNumber(3)
  set permList(SetUserBlackReqIdl_DataReq_PermissionList value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPermList() => $_has(2);
  @$pb.TagNumber(3)
  void clearPermList() => $_clearField(3);
  @$pb.TagNumber(3)
  SetUserBlackReqIdl_DataReq_PermissionList ensurePermList() => $_ensure(2);
}

class SetUserBlackReqIdl extends $pb.GeneratedMessage {
  factory SetUserBlackReqIdl({
    SetUserBlackReqIdl_DataReq? data,
  }) {
    final result = SetUserBlackReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  SetUserBlackReqIdl._();

  factory SetUserBlackReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl()..mergeFromBuffer(data, registry);
  factory SetUserBlackReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserBlackReqIdl',
      createEmptyInstance: SetUserBlackReqIdl.$_createMessage)
    ..aOM<SetUserBlackReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: SetUserBlackReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackReqIdl copyWith(void Function(SetUserBlackReqIdl) updates) =>
      super.copyWith((message) => updates(message as SetUserBlackReqIdl))
          as SetUserBlackReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetUserBlackReqIdl() / SetUserBlackReqIdl.new instead')
  static SetUserBlackReqIdl create() => SetUserBlackReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => SetUserBlackReqIdl._();
  @$core.override
  SetUserBlackReqIdl createEmptyInstance() => SetUserBlackReqIdl._();
  @$core.pragma('dart2js:noInline')
  static SetUserBlackReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUserBlackReqIdl>(
          SetUserBlackReqIdl.$_createMessage);
  static SetUserBlackReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  SetUserBlackReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(SetUserBlackReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  SetUserBlackReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
