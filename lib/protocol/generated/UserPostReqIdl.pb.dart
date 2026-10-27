// This is a generated file - do not edit.
//
// Generated from UserPostReqIdl.proto.

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

class UserPostReqIdl_DataReq extends $pb.GeneratedMessage {
  factory UserPostReqIdl_DataReq({
    $fixnum.Int64? uid,
    $core.int? rn,
    $core.int? isThread,
    $core.int? needContent,
    $core.int? pn,
    $0.CommonReq? common,
    $core.int? isViewCard,
  }) {
    final result = UserPostReqIdl_DataReq._();
    if (uid != null) result.uid = uid;
    if (rn != null) result.rn = rn;
    if (isThread != null) result.isThread = isThread;
    if (needContent != null) result.needContent = needContent;
    if (pn != null) result.pn = pn;
    if (common != null) result.common = common;
    if (isViewCard != null) result.isViewCard = isViewCard;
    return result;
  }

  UserPostReqIdl_DataReq._();

  factory UserPostReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory UserPostReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPostReqIdl.DataReq',
      createEmptyInstance: UserPostReqIdl_DataReq.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'uid')
    ..aI(2, _omitFieldNames ? '' : 'rn', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'isThread', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'needContent',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(26, _omitFieldNames ? '' : 'pn', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.CommonReq>(27, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(33, _omitFieldNames ? '' : 'isViewCard')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostReqIdl_DataReq copyWith(
          void Function(UserPostReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as UserPostReqIdl_DataReq))
          as UserPostReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserPostReqIdl_DataReq() / UserPostReqIdl_DataReq.new instead')
  static UserPostReqIdl_DataReq create() => UserPostReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() => UserPostReqIdl_DataReq._();
  @$core.override
  UserPostReqIdl_DataReq createEmptyInstance() => UserPostReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static UserPostReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserPostReqIdl_DataReq>(
          UserPostReqIdl_DataReq.$_createMessage);
  static UserPostReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get uid => $_getI64(0);
  @$pb.TagNumber(1)
  set uid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get rn => $_getIZ(1);
  @$pb.TagNumber(2)
  set rn($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRn() => $_has(1);
  @$pb.TagNumber(2)
  void clearRn() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.int get isThread => $_getIZ(2);
  @$pb.TagNumber(4)
  set isThread($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasIsThread() => $_has(2);
  @$pb.TagNumber(4)
  void clearIsThread() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get needContent => $_getIZ(3);
  @$pb.TagNumber(5)
  set needContent($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasNeedContent() => $_has(3);
  @$pb.TagNumber(5)
  void clearNeedContent() => $_clearField(5);

  @$pb.TagNumber(26)
  $core.int get pn => $_getIZ(4);
  @$pb.TagNumber(26)
  set pn($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(26)
  $core.bool hasPn() => $_has(4);
  @$pb.TagNumber(26)
  void clearPn() => $_clearField(26);

  @$pb.TagNumber(27)
  $0.CommonReq get common => $_getN(5);
  @$pb.TagNumber(27)
  set common($0.CommonReq value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasCommon() => $_has(5);
  @$pb.TagNumber(27)
  void clearCommon() => $_clearField(27);
  @$pb.TagNumber(27)
  $0.CommonReq ensureCommon() => $_ensure(5);

  @$pb.TagNumber(33)
  $core.int get isViewCard => $_getIZ(6);
  @$pb.TagNumber(33)
  set isViewCard($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(33)
  $core.bool hasIsViewCard() => $_has(6);
  @$pb.TagNumber(33)
  void clearIsViewCard() => $_clearField(33);
}

class UserPostReqIdl extends $pb.GeneratedMessage {
  factory UserPostReqIdl({
    UserPostReqIdl_DataReq? data,
  }) {
    final result = UserPostReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  UserPostReqIdl._();

  factory UserPostReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostReqIdl()..mergeFromBuffer(data, registry);
  factory UserPostReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPostReqIdl',
      createEmptyInstance: UserPostReqIdl.$_createMessage)
    ..aOM<UserPostReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: UserPostReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostReqIdl copyWith(void Function(UserPostReqIdl) updates) =>
      super.copyWith((message) => updates(message as UserPostReqIdl))
          as UserPostReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserPostReqIdl() / UserPostReqIdl.new instead')
  static UserPostReqIdl create() => UserPostReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => UserPostReqIdl._();
  @$core.override
  UserPostReqIdl createEmptyInstance() => UserPostReqIdl._();
  @$core.pragma('dart2js:noInline')
  static UserPostReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPostReqIdl>(
          UserPostReqIdl.$_createMessage);
  static UserPostReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  UserPostReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(UserPostReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  UserPostReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
