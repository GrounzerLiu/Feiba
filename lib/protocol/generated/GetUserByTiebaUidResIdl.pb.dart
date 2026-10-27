// This is a generated file - do not edit.
//
// Generated from GetUserByTiebaUidResIdl.proto.

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

class GetUserByTiebaUidResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetUserByTiebaUidResIdl_DataRes({
    $1.User? user,
  }) {
    final result = GetUserByTiebaUidResIdl_DataRes._();
    if (user != null) result.user = user;
    return result;
  }

  GetUserByTiebaUidResIdl_DataRes._();

  factory GetUserByTiebaUidResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetUserByTiebaUidResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserByTiebaUidResIdl.DataRes',
      createEmptyInstance: GetUserByTiebaUidResIdl_DataRes.$_createMessage)
    ..aOM<$1.User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: $1.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidResIdl_DataRes copyWith(
          void Function(GetUserByTiebaUidResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserByTiebaUidResIdl_DataRes))
          as GetUserByTiebaUidResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserByTiebaUidResIdl_DataRes() / GetUserByTiebaUidResIdl_DataRes.new instead')
  static GetUserByTiebaUidResIdl_DataRes create() =>
      GetUserByTiebaUidResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetUserByTiebaUidResIdl_DataRes._();
  @$core.override
  GetUserByTiebaUidResIdl_DataRes createEmptyInstance() =>
      GetUserByTiebaUidResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetUserByTiebaUidResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserByTiebaUidResIdl_DataRes>(
          GetUserByTiebaUidResIdl_DataRes.$_createMessage);
  static GetUserByTiebaUidResIdl_DataRes? _defaultInstance;

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

class GetUserByTiebaUidResIdl extends $pb.GeneratedMessage {
  factory GetUserByTiebaUidResIdl({
    $0.Error? error,
    GetUserByTiebaUidResIdl_DataRes? data,
  }) {
    final result = GetUserByTiebaUidResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetUserByTiebaUidResIdl._();

  factory GetUserByTiebaUidResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidResIdl()..mergeFromBuffer(data, registry);
  factory GetUserByTiebaUidResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserByTiebaUidResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserByTiebaUidResIdl',
      createEmptyInstance: GetUserByTiebaUidResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetUserByTiebaUidResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetUserByTiebaUidResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByTiebaUidResIdl copyWith(
          void Function(GetUserByTiebaUidResIdl) updates) =>
      super.copyWith((message) => updates(message as GetUserByTiebaUidResIdl))
          as GetUserByTiebaUidResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUserByTiebaUidResIdl() / GetUserByTiebaUidResIdl.new instead')
  static GetUserByTiebaUidResIdl create() => GetUserByTiebaUidResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetUserByTiebaUidResIdl._();
  @$core.override
  GetUserByTiebaUidResIdl createEmptyInstance() => GetUserByTiebaUidResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetUserByTiebaUidResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserByTiebaUidResIdl>(
          GetUserByTiebaUidResIdl.$_createMessage);
  static GetUserByTiebaUidResIdl? _defaultInstance;

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
  GetUserByTiebaUidResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetUserByTiebaUidResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetUserByTiebaUidResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
