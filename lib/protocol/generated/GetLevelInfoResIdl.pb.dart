// This is a generated file - do not edit.
//
// Generated from GetLevelInfoResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetLevelInfoResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetLevelInfoResIdl_DataRes({
    $core.int? isLike,
    $core.int? userLevel,
    $core.String? levelName,
  }) {
    final result = GetLevelInfoResIdl_DataRes._();
    if (isLike != null) result.isLike = isLike;
    if (userLevel != null) result.userLevel = userLevel;
    if (levelName != null) result.levelName = levelName;
    return result;
  }

  GetLevelInfoResIdl_DataRes._();

  factory GetLevelInfoResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetLevelInfoResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLevelInfoResIdl.DataRes',
      createEmptyInstance: GetLevelInfoResIdl_DataRes.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'isLike')
    ..aI(3, _omitFieldNames ? '' : 'userLevel')
    ..aOS(4, _omitFieldNames ? '' : 'levelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoResIdl_DataRes copyWith(
          void Function(GetLevelInfoResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as GetLevelInfoResIdl_DataRes))
          as GetLevelInfoResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetLevelInfoResIdl_DataRes() / GetLevelInfoResIdl_DataRes.new instead')
  static GetLevelInfoResIdl_DataRes create() => GetLevelInfoResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetLevelInfoResIdl_DataRes._();
  @$core.override
  GetLevelInfoResIdl_DataRes createEmptyInstance() =>
      GetLevelInfoResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetLevelInfoResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLevelInfoResIdl_DataRes>(
          GetLevelInfoResIdl_DataRes.$_createMessage);
  static GetLevelInfoResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get isLike => $_getIZ(0);
  @$pb.TagNumber(2)
  set isLike($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasIsLike() => $_has(0);
  @$pb.TagNumber(2)
  void clearIsLike() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get userLevel => $_getIZ(1);
  @$pb.TagNumber(3)
  set userLevel($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasUserLevel() => $_has(1);
  @$pb.TagNumber(3)
  void clearUserLevel() => $_clearField(3);

  /// repeated LevelInfo level_info = 1;
  @$pb.TagNumber(4)
  $core.String get levelName => $_getSZ(2);
  @$pb.TagNumber(4)
  set levelName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasLevelName() => $_has(2);
  @$pb.TagNumber(4)
  void clearLevelName() => $_clearField(4);
}

class GetLevelInfoResIdl extends $pb.GeneratedMessage {
  factory GetLevelInfoResIdl({
    GetLevelInfoResIdl_DataRes? data,
    $0.Error? error,
  }) {
    final result = GetLevelInfoResIdl._();
    if (data != null) result.data = data;
    if (error != null) result.error = error;
    return result;
  }

  GetLevelInfoResIdl._();

  factory GetLevelInfoResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoResIdl()..mergeFromBuffer(data, registry);
  factory GetLevelInfoResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetLevelInfoResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLevelInfoResIdl',
      createEmptyInstance: GetLevelInfoResIdl.$_createMessage)
    ..aOM<GetLevelInfoResIdl_DataRes>(1, _omitFieldNames ? '' : 'data',
        subBuilder: GetLevelInfoResIdl_DataRes.$_createMessage)
    ..aOM<$0.Error>(2, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLevelInfoResIdl copyWith(void Function(GetLevelInfoResIdl) updates) =>
      super.copyWith((message) => updates(message as GetLevelInfoResIdl))
          as GetLevelInfoResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetLevelInfoResIdl() / GetLevelInfoResIdl.new instead')
  static GetLevelInfoResIdl create() => GetLevelInfoResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetLevelInfoResIdl._();
  @$core.override
  GetLevelInfoResIdl createEmptyInstance() => GetLevelInfoResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetLevelInfoResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLevelInfoResIdl>(
          GetLevelInfoResIdl.$_createMessage);
  static GetLevelInfoResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  GetLevelInfoResIdl_DataRes get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(GetLevelInfoResIdl_DataRes value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  GetLevelInfoResIdl_DataRes ensureData() => $_ensure(0);

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
