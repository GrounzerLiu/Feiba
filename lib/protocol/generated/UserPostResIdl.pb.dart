// This is a generated file - do not edit.
//
// Generated from UserPostResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;
import 'PostInfoList.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserPostResIdl_DataRes extends $pb.GeneratedMessage {
  factory UserPostResIdl_DataRes({
    $core.Iterable<$1.PostInfoList>? postList,
  }) {
    final result = UserPostResIdl_DataRes._();
    if (postList != null) result.postList.addAll(postList);
    return result;
  }

  UserPostResIdl_DataRes._();

  factory UserPostResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory UserPostResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPostResIdl.DataRes',
      createEmptyInstance: UserPostResIdl_DataRes.$_createMessage)
    ..pPM<$1.PostInfoList>(1, _omitFieldNames ? '' : 'postList',
        subBuilder: $1.PostInfoList.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostResIdl_DataRes copyWith(
          void Function(UserPostResIdl_DataRes) updates) =>
      super.copyWith((message) => updates(message as UserPostResIdl_DataRes))
          as UserPostResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UserPostResIdl_DataRes() / UserPostResIdl_DataRes.new instead')
  static UserPostResIdl_DataRes create() => UserPostResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() => UserPostResIdl_DataRes._();
  @$core.override
  UserPostResIdl_DataRes createEmptyInstance() => UserPostResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static UserPostResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserPostResIdl_DataRes>(
          UserPostResIdl_DataRes.$_createMessage);
  static UserPostResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.PostInfoList> get postList => $_getList(0);
}

class UserPostResIdl extends $pb.GeneratedMessage {
  factory UserPostResIdl({
    $0.Error? error,
    UserPostResIdl_DataRes? data,
  }) {
    final result = UserPostResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  UserPostResIdl._();

  factory UserPostResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostResIdl()..mergeFromBuffer(data, registry);
  factory UserPostResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserPostResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPostResIdl',
      createEmptyInstance: UserPostResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<UserPostResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: UserPostResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPostResIdl copyWith(void Function(UserPostResIdl) updates) =>
      super.copyWith((message) => updates(message as UserPostResIdl))
          as UserPostResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserPostResIdl() / UserPostResIdl.new instead')
  static UserPostResIdl create() => UserPostResIdl._();
  static $pb.GeneratedMessage $_createMessage() => UserPostResIdl._();
  @$core.override
  UserPostResIdl createEmptyInstance() => UserPostResIdl._();
  @$core.pragma('dart2js:noInline')
  static UserPostResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPostResIdl>(
          UserPostResIdl.$_createMessage);
  static UserPostResIdl? _defaultInstance;

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
  UserPostResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(UserPostResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  UserPostResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
