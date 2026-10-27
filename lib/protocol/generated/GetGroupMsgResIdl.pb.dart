// This is a generated file - do not edit.
//
// Generated from GetGroupMsgResIdl.proto.

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

class GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo
    extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo({
    $fixnum.Int64? groupId,
    $core.int? groupType,
  }) {
    final result = GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo._();
    if (groupId != null) result.groupId = groupId;
    if (groupType != null) result.groupType = groupType;
    return result;
  }

  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo._();

  factory GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo()
        ..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgResIdl.DataRes.GroupMsg.GroupInfo',
      createEmptyInstance:
          GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'groupId', protoName: 'groupId')
    ..aI(20, _omitFieldNames ? '' : 'groupType', protoName: 'groupType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo copyWith(
          void Function(GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo)
              updates) =>
      super.copyWith((message) =>
              updates(message as GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo))
          as GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo() / GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.new instead')
  static GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo create() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo._();
  @$core.override
  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo createEmptyInstance() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo>(
          GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.$_createMessage);
  static GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo? _defaultInstance;

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
}

class GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo
    extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo({
    $fixnum.Int64? userId,
    $core.String? userName,
    $core.String? portrait,
  }) {
    final result = GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo._();
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (portrait != null) result.portrait = portrait;
    return result;
  }

  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo._();

  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo()
        ..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetGroupMsgResIdl.DataRes.GroupMsg.MsgInfo.UserInfo',
      createEmptyInstance:
          GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId', protoName: 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'userName', protoName: 'userName')
    ..aOS(4, _omitFieldNames ? '' : 'portrait')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo copyWith(
          void Function(GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo)
              updates) =>
      super.copyWith((message) => updates(
              message as GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo))
          as GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo() / GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.new instead')
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo create() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo._();
  @$core.override
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo createEmptyInstance() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo>(
          GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.$_createMessage);
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo? _defaultInstance;

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

class GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo({
    $fixnum.Int64? msgId,
    $core.int? msgType,
    $core.String? content,
    $core.int? createTime,
    GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo? userInfo,
  }) {
    final result = GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo._();
    if (msgId != null) result.msgId = msgId;
    if (msgType != null) result.msgType = msgType;
    if (content != null) result.content = content;
    if (createTime != null) result.createTime = createTime;
    if (userInfo != null) result.userInfo = userInfo;
    return result;
  }

  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo._();

  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo()
        ..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgResIdl.DataRes.GroupMsg.MsgInfo',
      createEmptyInstance:
          GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'msgId', protoName: 'msgId')
    ..aI(3, _omitFieldNames ? '' : 'msgType', protoName: 'msgType')
    ..aOS(5, _omitFieldNames ? '' : 'content')
    ..aI(8, _omitFieldNames ? '' : 'createTime', protoName: 'createTime')
    ..aOM<GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo>(
        10, _omitFieldNames ? '' : 'userInfo',
        protoName: 'userInfo',
        subBuilder:
            GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo copyWith(
          void Function(GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo) updates) =>
      super.copyWith((message) =>
              updates(message as GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo))
          as GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo() / GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.new instead')
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo create() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo._();
  @$core.override
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo createEmptyInstance() =>
      GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo>(
          GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.$_createMessage);
  static GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get msgId => $_getI64(0);
  @$pb.TagNumber(1)
  set msgId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMsgId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsgId() => $_clearField(1);

  @$pb.TagNumber(3)
  $core.int get msgType => $_getIZ(1);
  @$pb.TagNumber(3)
  set msgType($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasMsgType() => $_has(1);
  @$pb.TagNumber(3)
  void clearMsgType() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(5)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(5)
  void clearContent() => $_clearField(5);

  @$pb.TagNumber(8)
  $core.int get createTime => $_getIZ(3);
  @$pb.TagNumber(8)
  set createTime($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(8)
  $core.bool hasCreateTime() => $_has(3);
  @$pb.TagNumber(8)
  void clearCreateTime() => $_clearField(8);

  @$pb.TagNumber(10)
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo get userInfo => $_getN(4);
  @$pb.TagNumber(10)
  set userInfo(GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo value) =>
      $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasUserInfo() => $_has(4);
  @$pb.TagNumber(10)
  void clearUserInfo() => $_clearField(10);
  @$pb.TagNumber(10)
  GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo ensureUserInfo() =>
      $_ensure(4);
}

class GetGroupMsgResIdl_DataRes_GroupMsg extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl_DataRes_GroupMsg({
    GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo? groupInfo,
    $core.Iterable<GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo>? msgList,
  }) {
    final result = GetGroupMsgResIdl_DataRes_GroupMsg._();
    if (groupInfo != null) result.groupInfo = groupInfo;
    if (msgList != null) result.msgList.addAll(msgList);
    return result;
  }

  GetGroupMsgResIdl_DataRes_GroupMsg._();

  factory GetGroupMsgResIdl_DataRes_GroupMsg.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg()..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl_DataRes_GroupMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes_GroupMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgResIdl.DataRes.GroupMsg',
      createEmptyInstance: GetGroupMsgResIdl_DataRes_GroupMsg.$_createMessage)
    ..aOM<GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo>(
        1, _omitFieldNames ? '' : 'groupInfo',
        protoName: 'groupInfo',
        subBuilder:
            GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo.$_createMessage)
    ..pPM<GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo>(
        2, _omitFieldNames ? '' : 'msgList',
        protoName: 'msgList',
        subBuilder: GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes_GroupMsg copyWith(
          void Function(GetGroupMsgResIdl_DataRes_GroupMsg) updates) =>
      super.copyWith((message) =>
              updates(message as GetGroupMsgResIdl_DataRes_GroupMsg))
          as GetGroupMsgResIdl_DataRes_GroupMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgResIdl_DataRes_GroupMsg() / GetGroupMsgResIdl_DataRes_GroupMsg.new instead')
  static GetGroupMsgResIdl_DataRes_GroupMsg create() =>
      GetGroupMsgResIdl_DataRes_GroupMsg._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgResIdl_DataRes_GroupMsg._();
  @$core.override
  GetGroupMsgResIdl_DataRes_GroupMsg createEmptyInstance() =>
      GetGroupMsgResIdl_DataRes_GroupMsg._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl_DataRes_GroupMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupMsgResIdl_DataRes_GroupMsg>(
          GetGroupMsgResIdl_DataRes_GroupMsg.$_createMessage);
  static GetGroupMsgResIdl_DataRes_GroupMsg? _defaultInstance;

  @$pb.TagNumber(1)
  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo get groupInfo => $_getN(0);
  @$pb.TagNumber(1)
  set groupInfo(GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo ensureGroupInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo> get msgList =>
      $_getList(1);
}

class GetGroupMsgResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl_DataRes({
    $core.Iterable<GetGroupMsgResIdl_DataRes_GroupMsg>? groupInfo,
  }) {
    final result = GetGroupMsgResIdl_DataRes._();
    if (groupInfo != null) result.groupInfo.addAll(groupInfo);
    return result;
  }

  GetGroupMsgResIdl_DataRes._();

  factory GetGroupMsgResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgResIdl.DataRes',
      createEmptyInstance: GetGroupMsgResIdl_DataRes.$_createMessage)
    ..pPM<GetGroupMsgResIdl_DataRes_GroupMsg>(
        1, _omitFieldNames ? '' : 'groupInfo',
        protoName: 'groupInfo',
        subBuilder: GetGroupMsgResIdl_DataRes_GroupMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl_DataRes copyWith(
          void Function(GetGroupMsgResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as GetGroupMsgResIdl_DataRes))
          as GetGroupMsgResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetGroupMsgResIdl_DataRes() / GetGroupMsgResIdl_DataRes.new instead')
  static GetGroupMsgResIdl_DataRes create() => GetGroupMsgResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetGroupMsgResIdl_DataRes._();
  @$core.override
  GetGroupMsgResIdl_DataRes createEmptyInstance() =>
      GetGroupMsgResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupMsgResIdl_DataRes>(
          GetGroupMsgResIdl_DataRes.$_createMessage);
  static GetGroupMsgResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GetGroupMsgResIdl_DataRes_GroupMsg> get groupInfo => $_getList(0);
}

class GetGroupMsgResIdl extends $pb.GeneratedMessage {
  factory GetGroupMsgResIdl({
    $0.Error? error,
    GetGroupMsgResIdl_DataRes? data,
  }) {
    final result = GetGroupMsgResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetGroupMsgResIdl._();

  factory GetGroupMsgResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl()..mergeFromBuffer(data, registry);
  factory GetGroupMsgResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetGroupMsgResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMsgResIdl',
      createEmptyInstance: GetGroupMsgResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetGroupMsgResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetGroupMsgResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMsgResIdl copyWith(void Function(GetGroupMsgResIdl) updates) =>
      super.copyWith((message) => updates(message as GetGroupMsgResIdl))
          as GetGroupMsgResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetGroupMsgResIdl() / GetGroupMsgResIdl.new instead')
  static GetGroupMsgResIdl create() => GetGroupMsgResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetGroupMsgResIdl._();
  @$core.override
  GetGroupMsgResIdl createEmptyInstance() => GetGroupMsgResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetGroupMsgResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupMsgResIdl>(
          GetGroupMsgResIdl.$_createMessage);
  static GetGroupMsgResIdl? _defaultInstance;

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
  GetGroupMsgResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetGroupMsgResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetGroupMsgResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
