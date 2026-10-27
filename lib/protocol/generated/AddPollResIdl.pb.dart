// This is a generated file - do not edit.
//
// Generated from AddPollResIdl.proto.

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

class AddPollResIdl extends $pb.GeneratedMessage {
  factory AddPollResIdl({
    $0.Error? error,
  }) {
    final result = AddPollResIdl._();
    if (error != null) result.error = error;
    return result;
  }

  AddPollResIdl._();

  factory AddPollResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollResIdl()..mergeFromBuffer(data, registry);
  factory AddPollResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddPollResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddPollResIdl',
      createEmptyInstance: AddPollResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPollResIdl copyWith(void Function(AddPollResIdl) updates) =>
      super.copyWith((message) => updates(message as AddPollResIdl))
          as AddPollResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AddPollResIdl() / AddPollResIdl.new instead')
  static AddPollResIdl create() => AddPollResIdl._();
  static $pb.GeneratedMessage $_createMessage() => AddPollResIdl._();
  @$core.override
  AddPollResIdl createEmptyInstance() => AddPollResIdl._();
  @$core.pragma('dart2js:noInline')
  static AddPollResIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPollResIdl>(
          AddPollResIdl.$_createMessage);
  static AddPollResIdl? _defaultInstance;

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
