// This is a generated file - do not edit.
//
// Generated from GetUserInfoResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;
import 'User.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetUserInfoResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetUserInfoResIdl_DataRes({
    $1.User? user,
  }) {
    final result = GetUserInfoResIdl_DataRes._();
    if (user != null) result.user = user;
    return result;
  }

  GetUserInfoResIdl_DataRes._();

  factory GetUserInfoResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetUserInfoResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInfoResIdl.DataRes',
      createEmptyInstance: GetUserInfoResIdl_DataRes.$_createMessage)
    ..aOM<$1.User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: $1.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoResIdl_DataRes copyWith(
          void Function(GetUserInfoResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as GetUserInfoResIdl_DataRes))
          as GetUserInfoResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserInfoResIdl_DataRes() / GetUserInfoResIdl_DataRes.new instead')
  static GetUserInfoResIdl_DataRes create() => GetUserInfoResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetUserInfoResIdl_DataRes._();
  @$core.override
  GetUserInfoResIdl_DataRes createEmptyInstance() =>
      GetUserInfoResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetUserInfoResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInfoResIdl_DataRes>(
          GetUserInfoResIdl_DataRes.$_createMessage);
  static GetUserInfoResIdl_DataRes? _defaultInstance;

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
}

class GetUserInfoResIdl extends $pb.GeneratedMessage {
  factory GetUserInfoResIdl({
    $0.Error? error,
    GetUserInfoResIdl_DataRes? data,
  }) {
    final result = GetUserInfoResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetUserInfoResIdl._();

  factory GetUserInfoResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoResIdl()..mergeFromBuffer(data, registry);
  factory GetUserInfoResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserInfoResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInfoResIdl',
      createEmptyInstance: GetUserInfoResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetUserInfoResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetUserInfoResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInfoResIdl copyWith(void Function(GetUserInfoResIdl) updates) =>
      super.copyWith((message) => updates(message as GetUserInfoResIdl))
          as GetUserInfoResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUserInfoResIdl() / GetUserInfoResIdl.new instead')
  static GetUserInfoResIdl create() => GetUserInfoResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetUserInfoResIdl._();
  @$core.override
  GetUserInfoResIdl createEmptyInstance() => GetUserInfoResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetUserInfoResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInfoResIdl>(
          GetUserInfoResIdl.$_createMessage);
  static GetUserInfoResIdl? _defaultInstance;

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
  GetUserInfoResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetUserInfoResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetUserInfoResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
