// This is a generated file - do not edit.
//
// Generated from GetBawuInfoResIdl.proto.

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

class GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
    extends $pb.GeneratedMessage {
  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub({
    $fixnum.Int64? userId,
    $core.String? roleName,
    $core.String? portrait,
    $core.int? userLevel,
    $core.String? userName,
    $core.String? nameShow,
  }) {
    final result =
        GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub._();
    if (userId != null) result.userId = userId;
    if (roleName != null) result.roleName = roleName;
    if (portrait != null) result.portrait = portrait;
    if (userLevel != null) result.userLevel = userLevel;
    if (userName != null) result.userName = userName;
    if (nameShow != null) result.nameShow = nameShow;
    return result;
  }

  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub._();

  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub()
        ..mergeFromBuffer(data, registry);
  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetBawuInfoResIdl.DataRes.BawuTeam.BawuRoleDes.BawuRoleInfoPub',
      createEmptyInstance:
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
              .$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'roleName')
    ..aOS(5, _omitFieldNames ? '' : 'portrait')
    ..aI(6, _omitFieldNames ? '' : 'userLevel')
    ..aOS(8, _omitFieldNames ? '' : 'userName')
    ..aOS(9, _omitFieldNames ? '' : 'nameShow')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub clone() =>
      deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub copyWith(
          void Function(
                  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub)
              updates) =>
      super.copyWith((message) => updates(message
              as GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub))
          as GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub() / GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub.new instead')
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
      create() =>
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub._();
  @$core.override
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
      createEmptyInstance() =>
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
      getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>(
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
              .$_createMessage);
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub?
      _defaultInstance;

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.String get roleName => $_getSZ(1);
  @$pb.TagNumber(4)
  set roleName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(4)
  $core.bool hasRoleName() => $_has(1);
  @$pb.TagNumber(4)
  void clearRoleName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get portrait => $_getSZ(2);
  @$pb.TagNumber(5)
  set portrait($core.String value) => $_setString(2, value);
  @$pb.TagNumber(5)
  $core.bool hasPortrait() => $_has(2);
  @$pb.TagNumber(5)
  void clearPortrait() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get userLevel => $_getIZ(3);
  @$pb.TagNumber(6)
  set userLevel($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(6)
  $core.bool hasUserLevel() => $_has(3);
  @$pb.TagNumber(6)
  void clearUserLevel() => $_clearField(6);

  @$pb.TagNumber(8)
  $core.String get userName => $_getSZ(4);
  @$pb.TagNumber(8)
  set userName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(8)
  $core.bool hasUserName() => $_has(4);
  @$pb.TagNumber(8)
  void clearUserName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get nameShow => $_getSZ(5);
  @$pb.TagNumber(9)
  set nameShow($core.String value) => $_setString(5, value);
  @$pb.TagNumber(9)
  $core.bool hasNameShow() => $_has(5);
  @$pb.TagNumber(9)
  void clearNameShow() => $_clearField(9);
}

class GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes
    extends $pb.GeneratedMessage {
  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes({
    $core.String? roleName,
    $core.Iterable<
            GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>?
        roleInfo,
  }) {
    final result = GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes._();
    if (roleName != null) result.roleName = roleName;
    if (roleInfo != null) result.roleInfo.addAll(roleInfo);
    return result;
  }

  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes._();

  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes()
        ..mergeFromBuffer(data, registry);
  factory GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoResIdl.DataRes.BawuTeam.BawuRoleDes',
      createEmptyInstance:
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'roleName')
    ..pPM<GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>(
        2, _omitFieldNames ? '' : 'roleInfo',
        subBuilder:
            GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub
                .$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes copyWith(
          void Function(GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes)
              updates) =>
      super.copyWith((message) => updates(
              message as GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes))
          as GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes() / GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.new instead')
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes create() =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes._();
  @$core.override
  GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes createEmptyInstance() =>
      GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes>(
          GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.$_createMessage);
  static GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roleName => $_getSZ(0);
  @$pb.TagNumber(1)
  set roleName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoleName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoleName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub>
      get roleInfo => $_getList(1);
}

class GetBawuInfoResIdl_DataRes_BawuTeam extends $pb.GeneratedMessage {
  factory GetBawuInfoResIdl_DataRes_BawuTeam({
    $core.int? totalNum,
    $core.Iterable<GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes>?
        bawuTeamList,
  }) {
    final result = GetBawuInfoResIdl_DataRes_BawuTeam._();
    if (totalNum != null) result.totalNum = totalNum;
    if (bawuTeamList != null) result.bawuTeamList.addAll(bawuTeamList);
    return result;
  }

  GetBawuInfoResIdl_DataRes_BawuTeam._();

  factory GetBawuInfoResIdl_DataRes_BawuTeam.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam()..mergeFromBuffer(data, registry);
  factory GetBawuInfoResIdl_DataRes_BawuTeam.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes_BawuTeam()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoResIdl.DataRes.BawuTeam',
      createEmptyInstance: GetBawuInfoResIdl_DataRes_BawuTeam.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'totalNum')
    ..pPM<GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes>(
        2, _omitFieldNames ? '' : 'bawuTeamList',
        subBuilder:
            GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes_BawuTeam copyWith(
          void Function(GetBawuInfoResIdl_DataRes_BawuTeam) updates) =>
      super.copyWith((message) =>
              updates(message as GetBawuInfoResIdl_DataRes_BawuTeam))
          as GetBawuInfoResIdl_DataRes_BawuTeam;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetBawuInfoResIdl_DataRes_BawuTeam() / GetBawuInfoResIdl_DataRes_BawuTeam.new instead')
  static GetBawuInfoResIdl_DataRes_BawuTeam create() =>
      GetBawuInfoResIdl_DataRes_BawuTeam._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetBawuInfoResIdl_DataRes_BawuTeam._();
  @$core.override
  GetBawuInfoResIdl_DataRes_BawuTeam createEmptyInstance() =>
      GetBawuInfoResIdl_DataRes_BawuTeam._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoResIdl_DataRes_BawuTeam getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBawuInfoResIdl_DataRes_BawuTeam>(
          GetBawuInfoResIdl_DataRes_BawuTeam.$_createMessage);
  static GetBawuInfoResIdl_DataRes_BawuTeam? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalNum => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalNum($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalNum() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalNum() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes> get bawuTeamList =>
      $_getList(1);
}

class GetBawuInfoResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetBawuInfoResIdl_DataRes({
    GetBawuInfoResIdl_DataRes_BawuTeam? bawuTeamInfo,
  }) {
    final result = GetBawuInfoResIdl_DataRes._();
    if (bawuTeamInfo != null) result.bawuTeamInfo = bawuTeamInfo;
    return result;
  }

  GetBawuInfoResIdl_DataRes._();

  factory GetBawuInfoResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetBawuInfoResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoResIdl.DataRes',
      createEmptyInstance: GetBawuInfoResIdl_DataRes.$_createMessage)
    ..aOM<GetBawuInfoResIdl_DataRes_BawuTeam>(
        1, _omitFieldNames ? '' : 'bawuTeamInfo',
        subBuilder: GetBawuInfoResIdl_DataRes_BawuTeam.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl_DataRes copyWith(
          void Function(GetBawuInfoResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as GetBawuInfoResIdl_DataRes))
          as GetBawuInfoResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetBawuInfoResIdl_DataRes() / GetBawuInfoResIdl_DataRes.new instead')
  static GetBawuInfoResIdl_DataRes create() => GetBawuInfoResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetBawuInfoResIdl_DataRes._();
  @$core.override
  GetBawuInfoResIdl_DataRes createEmptyInstance() =>
      GetBawuInfoResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBawuInfoResIdl_DataRes>(
          GetBawuInfoResIdl_DataRes.$_createMessage);
  static GetBawuInfoResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  GetBawuInfoResIdl_DataRes_BawuTeam get bawuTeamInfo => $_getN(0);
  @$pb.TagNumber(1)
  set bawuTeamInfo(GetBawuInfoResIdl_DataRes_BawuTeam value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBawuTeamInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearBawuTeamInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  GetBawuInfoResIdl_DataRes_BawuTeam ensureBawuTeamInfo() => $_ensure(0);
}

class GetBawuInfoResIdl extends $pb.GeneratedMessage {
  factory GetBawuInfoResIdl({
    GetBawuInfoResIdl_DataRes? data,
    $0.Error? error,
  }) {
    final result = GetBawuInfoResIdl._();
    if (data != null) result.data = data;
    if (error != null) result.error = error;
    return result;
  }

  GetBawuInfoResIdl._();

  factory GetBawuInfoResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl()..mergeFromBuffer(data, registry);
  factory GetBawuInfoResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetBawuInfoResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBawuInfoResIdl',
      createEmptyInstance: GetBawuInfoResIdl.$_createMessage)
    ..aOM<GetBawuInfoResIdl_DataRes>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetBawuInfoResIdl_DataRes.$_createMessage)
    ..aOM<$0.Error>(2, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBawuInfoResIdl copyWith(void Function(GetBawuInfoResIdl) updates) =>
      super.copyWith((message) => updates(message as GetBawuInfoResIdl))
          as GetBawuInfoResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetBawuInfoResIdl() / GetBawuInfoResIdl.new instead')
  static GetBawuInfoResIdl create() => GetBawuInfoResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetBawuInfoResIdl._();
  @$core.override
  GetBawuInfoResIdl createEmptyInstance() => GetBawuInfoResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetBawuInfoResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBawuInfoResIdl>(
          GetBawuInfoResIdl.$_createMessage);
  static GetBawuInfoResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetBawuInfoResIdl_DataRes get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetBawuInfoResIdl_DataRes value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetBawuInfoResIdl_DataRes ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($0.Error value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Error ensureError() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
