// This is a generated file - do not edit.
//
// Generated from UserMuteQueryReqIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'CommonReq.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserMuteQueryReqIdl_DataReq extends $pb.GeneratedMessage {
  factory UserMuteQueryReqIdl_DataReq({
    $0.CommonReq? common,
    $core.int? pn,
    $core.int? rn,
  }) {
    final result = UserMuteQueryReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (pn != null) result.pn = pn;
    if (rn != null) result.rn = rn;
    return result;
  }

  UserMuteQueryReqIdl_DataReq._();

  factory UserMuteQueryReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory UserMuteQueryReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMuteQueryReqIdl.DataReq',
      createEmptyInstance: UserMuteQueryReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(2, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(4, _omitFieldNames ? '' : 'pn', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'rn', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryReqIdl_DataReq copyWith(
          void Function(UserMuteQueryReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as UserMuteQueryReqIdl_DataReq))
          as UserMuteQueryReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserMuteQueryReqIdl_DataReq() / UserMuteQueryReqIdl_DataReq.new instead')
  static UserMuteQueryReqIdl_DataReq create() =>
      UserMuteQueryReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      UserMuteQueryReqIdl_DataReq._();
  @$core.override
  UserMuteQueryReqIdl_DataReq createEmptyInstance() =>
      UserMuteQueryReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static UserMuteQueryReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMuteQueryReqIdl_DataReq>(
          UserMuteQueryReqIdl_DataReq.$_createMessage);
  static UserMuteQueryReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(2)
  $0.CommonReq get common => $_getN(0);
  @$pb.TagNumber(2)
  set common($0.CommonReq value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(2)
  void clearCommon() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.CommonReq ensureCommon() => $_ensure(0);

  @$pb.TagNumber(4)
  $core.int get pn => $_getIZ(1);
  @$pb.TagNumber(4)
  set pn($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(4)
  $core.bool hasPn() => $_has(1);
  @$pb.TagNumber(4)
  void clearPn() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get rn => $_getIZ(2);
  @$pb.TagNumber(5)
  set rn($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(5)
  $core.bool hasRn() => $_has(2);
  @$pb.TagNumber(5)
  void clearRn() => $_clearField(5);
}

class UserMuteQueryReqIdl extends $pb.GeneratedMessage {
  factory UserMuteQueryReqIdl({
    UserMuteQueryReqIdl_DataReq? data,
  }) {
    final result = UserMuteQueryReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  UserMuteQueryReqIdl._();

  factory UserMuteQueryReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryReqIdl()..mergeFromBuffer(data, registry);
  factory UserMuteQueryReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserMuteQueryReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMuteQueryReqIdl',
      createEmptyInstance: UserMuteQueryReqIdl.$_createMessage)
    ..aOM<UserMuteQueryReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: UserMuteQueryReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMuteQueryReqIdl copyWith(void Function(UserMuteQueryReqIdl) updates) =>
      super.copyWith((message) => updates(message as UserMuteQueryReqIdl))
          as UserMuteQueryReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use UserMuteQueryReqIdl() / UserMuteQueryReqIdl.new instead')
  static UserMuteQueryReqIdl create() => UserMuteQueryReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => UserMuteQueryReqIdl._();
  @$core.override
  UserMuteQueryReqIdl createEmptyInstance() => UserMuteQueryReqIdl._();
  @$core.pragma('dart2js:noInline')
  static UserMuteQueryReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMuteQueryReqIdl>(
          UserMuteQueryReqIdl.$_createMessage);
  static UserMuteQueryReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  UserMuteQueryReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(UserMuteQueryReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  UserMuteQueryReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
