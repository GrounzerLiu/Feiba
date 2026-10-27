// This is a generated file - do not edit.
//
// Generated from UpdateClientInfoResIdl.proto.

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

class UpdateClientInfoResIdl_DataRes_GroupInfo extends $pb.GeneratedMessage {
  factory UpdateClientInfoResIdl_DataRes_GroupInfo({
    $fixnum.Int64? groupId,
    $core.int? groupType,
    $fixnum.Int64? lastMsgId,
  }) {
    final result = UpdateClientInfoResIdl_DataRes_GroupInfo._();
    if (groupId != null) result.groupId = groupId;
    if (groupType != null) result.groupType = groupType;
    if (lastMsgId != null) result.lastMsgId = lastMsgId;
    return result;
  }

  UpdateClientInfoResIdl_DataRes_GroupInfo._();

  factory UpdateClientInfoResIdl_DataRes_GroupInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes_GroupInfo()
        ..mergeFromBuffer(data, registry);
  factory UpdateClientInfoResIdl_DataRes_GroupInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes_GroupInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoResIdl.DataRes.GroupInfo',
      createEmptyInstance:
          UpdateClientInfoResIdl_DataRes_GroupInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aI(20, _omitFieldNames ? '' : 'groupType', protoName: 'groupType')
    ..aInt64(21, _omitFieldNames ? '' : 'lastMsgId', protoName: 'lastMsgId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes_GroupInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes_GroupInfo copyWith(
          void Function(UpdateClientInfoResIdl_DataRes_GroupInfo) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateClientInfoResIdl_DataRes_GroupInfo))
          as UpdateClientInfoResIdl_DataRes_GroupInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoResIdl_DataRes_GroupInfo() / UpdateClientInfoResIdl_DataRes_GroupInfo.new instead')
  static UpdateClientInfoResIdl_DataRes_GroupInfo create() =>
      UpdateClientInfoResIdl_DataRes_GroupInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateClientInfoResIdl_DataRes_GroupInfo._();
  @$core.override
  UpdateClientInfoResIdl_DataRes_GroupInfo createEmptyInstance() =>
      UpdateClientInfoResIdl_DataRes_GroupInfo._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoResIdl_DataRes_GroupInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              UpdateClientInfoResIdl_DataRes_GroupInfo>(
          UpdateClientInfoResIdl_DataRes_GroupInfo.$_createMessage);
  static UpdateClientInfoResIdl_DataRes_GroupInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get groupId => $_getI64(0);
  @$pb.TagNumber(1)
  set groupId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(20)
  $core.int get groupType => $_getIZ(1);
  @$pb.TagNumber(20)
  set groupType($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(20)
  $core.bool hasGroupType() => $_has(1);
  @$pb.TagNumber(20)
  void clearGroupType() => $_clearField(20);

  @$pb.TagNumber(21)
  $fixnum.Int64 get lastMsgId => $_getI64(2);
  @$pb.TagNumber(21)
  set lastMsgId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(21)
  $core.bool hasLastMsgId() => $_has(2);
  @$pb.TagNumber(21)
  void clearLastMsgId() => $_clearField(21);
}

class UpdateClientInfoResIdl_DataRes_UserInfo extends $pb.GeneratedMessage {
  factory UpdateClientInfoResIdl_DataRes_UserInfo({
    $fixnum.Int64? userId,
    $core.String? userName,
    $core.String? portrait,
  }) {
    final result = UpdateClientInfoResIdl_DataRes_UserInfo._();
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (portrait != null) result.portrait = portrait;
    return result;
  }

  UpdateClientInfoResIdl_DataRes_UserInfo._();

  factory UpdateClientInfoResIdl_DataRes_UserInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes_UserInfo()
        ..mergeFromBuffer(data, registry);
  factory UpdateClientInfoResIdl_DataRes_UserInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes_UserInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoResIdl.DataRes.UserInfo',
      createEmptyInstance:
          UpdateClientInfoResIdl_DataRes_UserInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId', protoName: 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'userName', protoName: 'userName')
    ..aOS(4, _omitFieldNames ? '' : 'portrait')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes_UserInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes_UserInfo copyWith(
          void Function(UpdateClientInfoResIdl_DataRes_UserInfo) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateClientInfoResIdl_DataRes_UserInfo))
          as UpdateClientInfoResIdl_DataRes_UserInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoResIdl_DataRes_UserInfo() / UpdateClientInfoResIdl_DataRes_UserInfo.new instead')
  static UpdateClientInfoResIdl_DataRes_UserInfo create() =>
      UpdateClientInfoResIdl_DataRes_UserInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateClientInfoResIdl_DataRes_UserInfo._();
  @$core.override
  UpdateClientInfoResIdl_DataRes_UserInfo createEmptyInstance() =>
      UpdateClientInfoResIdl_DataRes_UserInfo._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoResIdl_DataRes_UserInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              UpdateClientInfoResIdl_DataRes_UserInfo>(
          UpdateClientInfoResIdl_DataRes_UserInfo.$_createMessage);
  static UpdateClientInfoResIdl_DataRes_UserInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.String get portrait => $_getSZ(2);
  @$pb.TagNumber(4)
  set portrait($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasPortrait() => $_has(2);
  @$pb.TagNumber(4)
  void clearPortrait() => $_clearField(4);
}

class UpdateClientInfoResIdl_DataRes extends $pb.GeneratedMessage {
  factory UpdateClientInfoResIdl_DataRes({
    $core.Iterable<UpdateClientInfoResIdl_DataRes_GroupInfo>? groupInfo,
    UpdateClientInfoResIdl_DataRes_UserInfo? userInfo,
    $fixnum.Int64? isUserAvailable,
  }) {
    final result = UpdateClientInfoResIdl_DataRes._();
    if (groupInfo != null) result.groupInfo.addAll(groupInfo);
    if (userInfo != null) result.userInfo = userInfo;
    if (isUserAvailable != null) result.isUserAvailable = isUserAvailable;
    return result;
  }

  UpdateClientInfoResIdl_DataRes._();

  factory UpdateClientInfoResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory UpdateClientInfoResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoResIdl.DataRes',
      createEmptyInstance: UpdateClientInfoResIdl_DataRes.$_createMessage)
    ..pPM<UpdateClientInfoResIdl_DataRes_GroupInfo>(
        1, _omitFieldNames ? '' : 'groupInfo',
        protoName: 'groupInfo',
        subBuilder: UpdateClientInfoResIdl_DataRes_GroupInfo.$_createMessage)
    ..aOM<UpdateClientInfoResIdl_DataRes_UserInfo>(
        2, _omitFieldNames ? '' : 'userInfo',
        protoName: 'userInfo',
        subBuilder: UpdateClientInfoResIdl_DataRes_UserInfo.$_createMessage)
    ..aInt64(6, _omitFieldNames ? '' : 'isUserAvailable',
        protoName: 'isUserAvailable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl_DataRes copyWith(
          void Function(UpdateClientInfoResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateClientInfoResIdl_DataRes))
          as UpdateClientInfoResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoResIdl_DataRes() / UpdateClientInfoResIdl_DataRes.new instead')
  static UpdateClientInfoResIdl_DataRes create() =>
      UpdateClientInfoResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateClientInfoResIdl_DataRes._();
  @$core.override
  UpdateClientInfoResIdl_DataRes createEmptyInstance() =>
      UpdateClientInfoResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClientInfoResIdl_DataRes>(
          UpdateClientInfoResIdl_DataRes.$_createMessage);
  static UpdateClientInfoResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpdateClientInfoResIdl_DataRes_GroupInfo> get groupInfo =>
      $_getList(0);

  @$pb.TagNumber(2)
  UpdateClientInfoResIdl_DataRes_UserInfo get userInfo => $_getN(1);
  @$pb.TagNumber(2)
  set userInfo(UpdateClientInfoResIdl_DataRes_UserInfo value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUserInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  UpdateClientInfoResIdl_DataRes_UserInfo ensureUserInfo() => $_ensure(1);

  @$pb.TagNumber(6)
  $fixnum.Int64 get isUserAvailable => $_getI64(2);
  @$pb.TagNumber(6)
  set isUserAvailable($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(6)
  $core.bool hasIsUserAvailable() => $_has(2);
  @$pb.TagNumber(6)
  void clearIsUserAvailable() => $_clearField(6);
}

class UpdateClientInfoResIdl extends $pb.GeneratedMessage {
  factory UpdateClientInfoResIdl({
    $0.Error? error,
    UpdateClientInfoResIdl_DataRes? data,
  }) {
    final result = UpdateClientInfoResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  UpdateClientInfoResIdl._();

  factory UpdateClientInfoResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl()..mergeFromBuffer(data, registry);
  factory UpdateClientInfoResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateClientInfoResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClientInfoResIdl',
      createEmptyInstance: UpdateClientInfoResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<UpdateClientInfoResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: UpdateClientInfoResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClientInfoResIdl copyWith(
          void Function(UpdateClientInfoResIdl) updates) =>
      super.copyWith((message) => updates(message as UpdateClientInfoResIdl))
          as UpdateClientInfoResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateClientInfoResIdl() / UpdateClientInfoResIdl.new instead')
  static UpdateClientInfoResIdl create() => UpdateClientInfoResIdl._();
  static $pb.GeneratedMessage $_createMessage() => UpdateClientInfoResIdl._();
  @$core.override
  UpdateClientInfoResIdl createEmptyInstance() => UpdateClientInfoResIdl._();
  @$core.pragma('dart2js:noInline')
  static UpdateClientInfoResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClientInfoResIdl>(
          UpdateClientInfoResIdl.$_createMessage);
  static UpdateClientInfoResIdl? _defaultInstance;

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
  UpdateClientInfoResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(UpdateClientInfoResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  UpdateClientInfoResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
