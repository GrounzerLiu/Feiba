// This is a generated file - do not edit.
//
// Generated from UserMuteQueryResIdl.proto.

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
import 'Page.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserMuteQueryResIdl_DataRes_MuteUser extends $pb.GeneratedMessage {
  factory UserMuteQueryResIdl_DataRes_MuteUser({
    $fixnum.Int64? userId,
    $core.String? userName,
    $core.int? muteTime,
    $core.String? portrait,
    $core.String? nameShow,
  }) {
    final result = UserMuteQueryResIdl_DataRes_MuteUser._();
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (muteTime != null) result.muteTime = muteTime;
    if (portrait != null) result.portrait = portrait;
    if (nameShow != null) result.nameShow = nameShow;
    return result;
  }

  UserMuteQueryResIdl_DataRes_MuteUser._();

  factory UserMuteQueryResIdl_DataRes_MuteUser.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl_DataRes_MuteUser()..mergeFromBuffer(data, registry);
  factory UserMuteQueryResIdl_DataRes_MuteUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl_DataRes_MuteUser()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMuteQueryResIdl.DataRes.MuteUser',
      createEmptyInstance: UserMuteQueryResIdl_DataRes_MuteUser.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'userName')
    ..aI(3, _omitFieldNames ? '' : 'muteTime')
    ..aOS(4, _omitFieldNames ? '' : 'portrait')
    ..aOS(5, _omitFieldNames ? '' : 'nameShow')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl_DataRes_MuteUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl_DataRes_MuteUser copyWith(
          void Function(UserMuteQueryResIdl_DataRes_MuteUser) updates) =>
      super.copyWith((message) =>
              updates(message as UserMuteQueryResIdl_DataRes_MuteUser))
          as UserMuteQueryResIdl_DataRes_MuteUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserMuteQueryResIdl_DataRes_MuteUser() / UserMuteQueryResIdl_DataRes_MuteUser.new instead')
  static UserMuteQueryResIdl_DataRes_MuteUser create() =>
      UserMuteQueryResIdl_DataRes_MuteUser._();
  static $pb.GeneratedMessage $_createMessage() =>
      UserMuteQueryResIdl_DataRes_MuteUser._();
  @$core.override
  UserMuteQueryResIdl_DataRes_MuteUser createEmptyInstance() =>
      UserMuteQueryResIdl_DataRes_MuteUser._();
  @$core.pragma('dart2js:noInline')
  static UserMuteQueryResIdl_DataRes_MuteUser getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              UserMuteQueryResIdl_DataRes_MuteUser>(
          UserMuteQueryResIdl_DataRes_MuteUser.$_createMessage);
  static UserMuteQueryResIdl_DataRes_MuteUser? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get muteTime => $_getIZ(2);
  @$pb.TagNumber(3)
  set muteTime($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMuteTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearMuteTime() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get portrait => $_getSZ(3);
  @$pb.TagNumber(4)
  set portrait($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPortrait() => $_has(3);
  @$pb.TagNumber(4)
  void clearPortrait() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get nameShow => $_getSZ(4);
  @$pb.TagNumber(5)
  set nameShow($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNameShow() => $_has(4);
  @$pb.TagNumber(5)
  void clearNameShow() => $_clearField(5);
}

class UserMuteQueryResIdl_DataRes extends $pb.GeneratedMessage {
  factory UserMuteQueryResIdl_DataRes({
    $core.Iterable<UserMuteQueryResIdl_DataRes_MuteUser>? muteUser,
    $1.Page? page,
  }) {
    final result = UserMuteQueryResIdl_DataRes._();
    if (muteUser != null) result.muteUser.addAll(muteUser);
    if (page != null) result.page = page;
    return result;
  }

  UserMuteQueryResIdl_DataRes._();

  factory UserMuteQueryResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory UserMuteQueryResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMuteQueryResIdl.DataRes',
      createEmptyInstance: UserMuteQueryResIdl_DataRes.$_createMessage)
    ..pPM<UserMuteQueryResIdl_DataRes_MuteUser>(
        1, _omitFieldNames ? '' : 'muteUser',
        subBuilder: UserMuteQueryResIdl_DataRes_MuteUser.$_createMessage)
    ..aOM<$1.Page>(2, _omitFieldNames ? '' : 'page',
        subBuilder: $1.Page.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl_DataRes copyWith(
          void Function(UserMuteQueryResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as UserMuteQueryResIdl_DataRes))
          as UserMuteQueryResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserMuteQueryResIdl_DataRes() / UserMuteQueryResIdl_DataRes.new instead')
  static UserMuteQueryResIdl_DataRes create() =>
      UserMuteQueryResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      UserMuteQueryResIdl_DataRes._();
  @$core.override
  UserMuteQueryResIdl_DataRes createEmptyInstance() =>
      UserMuteQueryResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static UserMuteQueryResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMuteQueryResIdl_DataRes>(
          UserMuteQueryResIdl_DataRes.$_createMessage);
  static UserMuteQueryResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserMuteQueryResIdl_DataRes_MuteUser> get muteUser => $_getList(0);

  @$pb.TagNumber(2)
  $1.Page get page => $_getN(1);
  @$pb.TagNumber(2)
  set page($1.Page value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Page ensurePage() => $_ensure(1);
}

class UserMuteQueryResIdl extends $pb.GeneratedMessage {
  factory UserMuteQueryResIdl({
    UserMuteQueryResIdl_DataRes? data,
    $0.Error? error,
  }) {
    final result = UserMuteQueryResIdl._();
    if (data != null) result.data = data;
    if (error != null) result.error = error;
    return result;
  }

  UserMuteQueryResIdl._();

  factory UserMuteQueryResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl()..mergeFromBuffer(data, registry);
  factory UserMuteQueryResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMuteQueryResIdl',
      createEmptyInstance: UserMuteQueryResIdl.$_createMessage)
    ..aOM<UserMuteQueryResIdl_DataRes>(1, _omitFieldNames ? '' : 'data',
        subBuilder: UserMuteQueryResIdl_DataRes.$_createMessage)
    ..aOM<$0.Error>(2, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryResIdl copyWith(void Function(UserMuteQueryResIdl) updates) =>
      super.copyWith((message) => updates(message as UserMuteQueryResIdl))
          as UserMuteQueryResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use UserMuteQueryResIdl() / UserMuteQueryResIdl.new instead')
  static UserMuteQueryResIdl create() => UserMuteQueryResIdl._();
  static $pb.GeneratedMessage $_createMessage() => UserMuteQueryResIdl._();
  @$core.override
  UserMuteQueryResIdl createEmptyInstance() => UserMuteQueryResIdl._();
  @$core.pragma('dart2js:noInline')
  static UserMuteQueryResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMuteQueryResIdl>(
          UserMuteQueryResIdl.$_createMessage);
  static UserMuteQueryResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  UserMuteQueryResIdl_DataRes get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(UserMuteQueryResIdl_DataRes value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  UserMuteQueryResIdl_DataRes ensureData() => $_ensure(0);

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
