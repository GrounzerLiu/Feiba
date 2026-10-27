// This is a generated file - do not edit.
//
// Generated from ProfileReqIdl.proto.

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

class ProfileReqIdl_DataReq extends $pb.GeneratedMessage {
  factory ProfileReqIdl_DataReq({
    $fixnum.Int64? uid,
    $core.int? needPostCount,
    $core.int? pn,
    $0.CommonReq? common,
    $core.int? page,
    $core.String? friendUidPortrait,
  }) {
    final result = ProfileReqIdl_DataReq._();
    if (uid != null) result.uid = uid;
    if (needPostCount != null) result.needPostCount = needPostCount;
    if (pn != null) result.pn = pn;
    if (common != null) result.common = common;
    if (page != null) result.page = page;
    if (friendUidPortrait != null) result.friendUidPortrait = friendUidPortrait;
    return result;
  }

  ProfileReqIdl_DataReq._();

  factory ProfileReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory ProfileReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileReqIdl.DataReq',
      createEmptyInstance: ProfileReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'uid')
    ..aI(2, _omitFieldNames ? '' : 'needPostCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'pn', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.CommonReq>(9, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(15, _omitFieldNames ? '' : 'page')
    ..aOS(16, _omitFieldNames ? '' : 'friendUidPortrait')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReqIdl_DataReq copyWith(
          void Function(ProfileReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as ProfileReqIdl_DataReq))
          as ProfileReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ProfileReqIdl_DataReq() / ProfileReqIdl_DataReq.new instead')
  static ProfileReqIdl_DataReq create() => ProfileReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() => ProfileReqIdl_DataReq._();
  @$core.override
  ProfileReqIdl_DataReq createEmptyInstance() => ProfileReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static ProfileReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileReqIdl_DataReq>(
          ProfileReqIdl_DataReq.$_createMessage);
  static ProfileReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get uid => $_getI64(0);
  @$pb.TagNumber(1)
  set uid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get needPostCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set needPostCount($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNeedPostCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearNeedPostCount() => $_clearField(2);

  @$pb.TagNumber(6)
  $core.int get pn => $_getIZ(2);
  @$pb.TagNumber(6)
  set pn($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(6)
  $core.bool hasPn() => $_has(2);
  @$pb.TagNumber(6)
  void clearPn() => $_clearField(6);

  @$pb.TagNumber(9)
  $0.CommonReq get common => $_getN(3);
  @$pb.TagNumber(9)
  set common($0.CommonReq value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCommon() => $_has(3);
  @$pb.TagNumber(9)
  void clearCommon() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.CommonReq ensureCommon() => $_ensure(3);

  @$pb.TagNumber(15)
  $core.int get page => $_getIZ(4);
  @$pb.TagNumber(15)
  set page($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(15)
  $core.bool hasPage() => $_has(4);
  @$pb.TagNumber(15)
  void clearPage() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get friendUidPortrait => $_getSZ(5);
  @$pb.TagNumber(16)
  set friendUidPortrait($core.String value) => $_setString(5, value);
  @$pb.TagNumber(16)
  $core.bool hasFriendUidPortrait() => $_has(5);
  @$pb.TagNumber(16)
  void clearFriendUidPortrait() => $_clearField(16);
}

class ProfileReqIdl extends $pb.GeneratedMessage {
  factory ProfileReqIdl({
    ProfileReqIdl_DataReq? data,
  }) {
    final result = ProfileReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  ProfileReqIdl._();

  factory ProfileReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileReqIdl()..mergeFromBuffer(data, registry);
  factory ProfileReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ProfileReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileReqIdl',
      createEmptyInstance: ProfileReqIdl.$_createMessage)
    ..aOM<ProfileReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: ProfileReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReqIdl copyWith(void Function(ProfileReqIdl) updates) =>
      super.copyWith((message) => updates(message as ProfileReqIdl))
          as ProfileReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ProfileReqIdl() / ProfileReqIdl.new instead')
  static ProfileReqIdl create() => ProfileReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => ProfileReqIdl._();
  @$core.override
  ProfileReqIdl createEmptyInstance() => ProfileReqIdl._();
  @$core.pragma('dart2js:noInline')
  static ProfileReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProfileReqIdl>(
          ProfileReqIdl.$_createMessage);
  static ProfileReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  ProfileReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProfileReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  ProfileReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
