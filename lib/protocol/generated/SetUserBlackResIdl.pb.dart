// This is a generated file - do not edit.
//
// Generated from SetUserBlackResIdl.proto.

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

class SetUserBlackResIdl extends $pb.GeneratedMessage {
  factory SetUserBlackResIdl({
    $0.Error? error,
  }) {
    final result = SetUserBlackResIdl._();
    if (error != null) result.error = error;
    return result;
  }

  SetUserBlackResIdl._();

  factory SetUserBlackResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackResIdl()..mergeFromBuffer(data, registry);
  factory SetUserBlackResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUserBlackResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserBlackResIdl',
      createEmptyInstance: SetUserBlackResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserBlackResIdl copyWith(void Function(SetUserBlackResIdl) updates) =>
      super.copyWith((message) => updates(message as SetUserBlackResIdl))
          as SetUserBlackResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetUserBlackResIdl() / SetUserBlackResIdl.new instead')
  static SetUserBlackResIdl create() => SetUserBlackResIdl._();
  static $pb.GeneratedMessage $_createMessage() => SetUserBlackResIdl._();
  @$core.override
  SetUserBlackResIdl createEmptyInstance() => SetUserBlackResIdl._();
  @$core.pragma('dart2js:noInline')
  static SetUserBlackResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUserBlackResIdl>(
          SetUserBlackResIdl.$_createMessage);
  static SetUserBlackResIdl? _defaultInstance;

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
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
