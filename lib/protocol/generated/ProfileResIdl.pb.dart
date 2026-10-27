// This is a generated file - do not edit.
//
// Generated from ProfileResIdl.proto.

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
import 'PostInfoList.pb.dart' as $2;
import 'User.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ProfileResIdl_DataRes_Anti extends $pb.GeneratedMessage {
  factory ProfileResIdl_DataRes_Anti({
    $core.int? blockStat,
    $core.int? hideStat,
    $core.int? daysTofree,
  }) {
    final result = ProfileResIdl_DataRes_Anti._();
    if (blockStat != null) result.blockStat = blockStat;
    if (hideStat != null) result.hideStat = hideStat;
    if (daysTofree != null) result.daysTofree = daysTofree;
    return result;
  }

  ProfileResIdl_DataRes_Anti._();

  factory ProfileResIdl_DataRes_Anti.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes_Anti()..mergeFromBuffer(data, registry);
  factory ProfileResIdl_DataRes_Anti.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes_Anti()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileResIdl.DataRes.Anti',
      createEmptyInstance: ProfileResIdl_DataRes_Anti.$_createMessage)
    ..aI(6, _omitFieldNames ? '' : 'blockStat')
    ..aI(7, _omitFieldNames ? '' : 'hideStat')
    ..aI(9, _omitFieldNames ? '' : 'daysTofree')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes_Anti clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes_Anti copyWith(
          void Function(ProfileResIdl_DataRes_Anti) updates) =>
      super.copyWith(
              (message) => updates(message as ProfileResIdl_DataRes_Anti))
          as ProfileResIdl_DataRes_Anti;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ProfileResIdl_DataRes_Anti() / ProfileResIdl_DataRes_Anti.new instead')
  static ProfileResIdl_DataRes_Anti create() => ProfileResIdl_DataRes_Anti._();
  static $pb.GeneratedMessage $_createMessage() =>
      ProfileResIdl_DataRes_Anti._();
  @$core.override
  ProfileResIdl_DataRes_Anti createEmptyInstance() =>
      ProfileResIdl_DataRes_Anti._();
  @$core.pragma('dart2js:noInline')
  static ProfileResIdl_DataRes_Anti getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileResIdl_DataRes_Anti>(
          ProfileResIdl_DataRes_Anti.$_createMessage);
  static ProfileResIdl_DataRes_Anti? _defaultInstance;

  @$pb.TagNumber(6)
  $core.int get blockStat => $_getIZ(0);
  @$pb.TagNumber(6)
  set blockStat($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(6)
  $core.bool hasBlockStat() => $_has(0);
  @$pb.TagNumber(6)
  void clearBlockStat() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get hideStat => $_getIZ(1);
  @$pb.TagNumber(7)
  set hideStat($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(7)
  $core.bool hasHideStat() => $_has(1);
  @$pb.TagNumber(7)
  void clearHideStat() => $_clearField(7);

  @$pb.TagNumber(9)
  $core.int get daysTofree => $_getIZ(2);
  @$pb.TagNumber(9)
  set daysTofree($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(9)
  $core.bool hasDaysTofree() => $_has(2);
  @$pb.TagNumber(9)
  void clearDaysTofree() => $_clearField(9);
}

class ProfileResIdl_DataRes_UserAgreeInfo extends $pb.GeneratedMessage {
  factory ProfileResIdl_DataRes_UserAgreeInfo({
    $fixnum.Int64? totalAgreeNum,
  }) {
    final result = ProfileResIdl_DataRes_UserAgreeInfo._();
    if (totalAgreeNum != null) result.totalAgreeNum = totalAgreeNum;
    return result;
  }

  ProfileResIdl_DataRes_UserAgreeInfo._();

  factory ProfileResIdl_DataRes_UserAgreeInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes_UserAgreeInfo()..mergeFromBuffer(data, registry);
  factory ProfileResIdl_DataRes_UserAgreeInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes_UserAgreeInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileResIdl.DataRes.UserAgreeInfo',
      createEmptyInstance: ProfileResIdl_DataRes_UserAgreeInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'totalAgreeNum')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes_UserAgreeInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes_UserAgreeInfo copyWith(
          void Function(ProfileResIdl_DataRes_UserAgreeInfo) updates) =>
      super.copyWith((message) =>
              updates(message as ProfileResIdl_DataRes_UserAgreeInfo))
          as ProfileResIdl_DataRes_UserAgreeInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ProfileResIdl_DataRes_UserAgreeInfo() / ProfileResIdl_DataRes_UserAgreeInfo.new instead')
  static ProfileResIdl_DataRes_UserAgreeInfo create() =>
      ProfileResIdl_DataRes_UserAgreeInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      ProfileResIdl_DataRes_UserAgreeInfo._();
  @$core.override
  ProfileResIdl_DataRes_UserAgreeInfo createEmptyInstance() =>
      ProfileResIdl_DataRes_UserAgreeInfo._();
  @$core.pragma('dart2js:noInline')
  static ProfileResIdl_DataRes_UserAgreeInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              ProfileResIdl_DataRes_UserAgreeInfo>(
          ProfileResIdl_DataRes_UserAgreeInfo.$_createMessage);
  static ProfileResIdl_DataRes_UserAgreeInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalAgreeNum => $_getI64(0);
  @$pb.TagNumber(1)
  set totalAgreeNum($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalAgreeNum() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAgreeNum() => $_clearField(1);
}

class ProfileResIdl_DataRes extends $pb.GeneratedMessage {
  factory ProfileResIdl_DataRes({
    $1.User? user,
    ProfileResIdl_DataRes_Anti? antiStat,
    $core.Iterable<$2.PostInfoList>? postList,
    ProfileResIdl_DataRes_UserAgreeInfo? userAgreeInfo,
  }) {
    final result = ProfileResIdl_DataRes._();
    if (user != null) result.user = user;
    if (antiStat != null) result.antiStat = antiStat;
    if (postList != null) result.postList.addAll(postList);
    if (userAgreeInfo != null) result.userAgreeInfo = userAgreeInfo;
    return result;
  }

  ProfileResIdl_DataRes._();

  factory ProfileResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory ProfileResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileResIdl.DataRes',
      createEmptyInstance: ProfileResIdl_DataRes.$_createMessage)
    ..aOM<$1.User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: $1.User.$_createMessage)
    ..aOM<ProfileResIdl_DataRes_Anti>(2, _omitFieldNames ? '' : 'antiStat',
        subBuilder: ProfileResIdl_DataRes_Anti.$_createMessage)
    ..pPM<$2.PostInfoList>(4, _omitFieldNames ? '' : 'postList',
        subBuilder: $2.PostInfoList.$_createMessage)
    ..aOM<ProfileResIdl_DataRes_UserAgreeInfo>(
        14, _omitFieldNames ? '' : 'userAgreeInfo',
        subBuilder: ProfileResIdl_DataRes_UserAgreeInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl_DataRes copyWith(
          void Function(ProfileResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as ProfileResIdl_DataRes))
          as ProfileResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ProfileResIdl_DataRes() / ProfileResIdl_DataRes.new instead')
  static ProfileResIdl_DataRes create() => ProfileResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() => ProfileResIdl_DataRes._();
  @$core.override
  ProfileResIdl_DataRes createEmptyInstance() => ProfileResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static ProfileResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileResIdl_DataRes>(
          ProfileResIdl_DataRes.$_createMessage);
  static ProfileResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($1.User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  ProfileResIdl_DataRes_Anti get antiStat => $_getN(1);
  @$pb.TagNumber(2)
  set antiStat(ProfileResIdl_DataRes_Anti value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAntiStat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAntiStat() => $_clearField(2);
  @$pb.TagNumber(2)
  ProfileResIdl_DataRes_Anti ensureAntiStat() => $_ensure(1);

  @$pb.TagNumber(4)
  $pb.PbList<$2.PostInfoList> get postList => $_getList(2);

  @$pb.TagNumber(14)
  ProfileResIdl_DataRes_UserAgreeInfo get userAgreeInfo => $_getN(3);
  @$pb.TagNumber(14)
  set userAgreeInfo(ProfileResIdl_DataRes_UserAgreeInfo value) =>
      $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasUserAgreeInfo() => $_has(3);
  @$pb.TagNumber(14)
  void clearUserAgreeInfo() => $_clearField(14);
  @$pb.TagNumber(14)
  ProfileResIdl_DataRes_UserAgreeInfo ensureUserAgreeInfo() => $_ensure(3);
}

class ProfileResIdl extends $pb.GeneratedMessage {
  factory ProfileResIdl({
    $0.Error? error,
    ProfileResIdl_DataRes? data,
  }) {
    final result = ProfileResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  ProfileResIdl._();

  factory ProfileResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl()..mergeFromBuffer(data, registry);
  factory ProfileResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileResIdl',
      createEmptyInstance: ProfileResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<ProfileResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: ProfileResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileResIdl copyWith(void Function(ProfileResIdl) updates) =>
      super.copyWith((message) => updates(message as ProfileResIdl))
          as ProfileResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ProfileResIdl() / ProfileResIdl.new instead')
  static ProfileResIdl create() => ProfileResIdl._();
  static $pb.GeneratedMessage $_createMessage() => ProfileResIdl._();
  @$core.override
  ProfileResIdl createEmptyInstance() => ProfileResIdl._();
  @$core.pragma('dart2js:noInline')
  static ProfileResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProfileResIdl>(
          ProfileResIdl.$_createMessage);
  static ProfileResIdl? _defaultInstance;

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
  ProfileResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(ProfileResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  ProfileResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
