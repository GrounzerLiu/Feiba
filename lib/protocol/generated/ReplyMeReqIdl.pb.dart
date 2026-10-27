// This is a generated file - do not edit.
//
// Generated from ReplyMeReqIdl.proto.

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

class ReplyMeReqIdl_DataReq extends $pb.GeneratedMessage {
  factory ReplyMeReqIdl_DataReq({
    $core.int? pn,
    $0.CommonReq? common,
  }) {
    final result = ReplyMeReqIdl_DataReq._();
    if (pn != null) result.pn = pn;
    if (common != null) result.common = common;
    return result;
  }

  ReplyMeReqIdl_DataReq._();

  factory ReplyMeReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory ReplyMeReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeReqIdl.DataReq',
      createEmptyInstance: ReplyMeReqIdl_DataReq.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'pn')
    ..aOM<$0.CommonReq>(3, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeReqIdl_DataReq copyWith(
          void Function(ReplyMeReqIdl_DataReq) updates) =>
      super.copyWith((message) => updates(message as ReplyMeReqIdl_DataReq))
          as ReplyMeReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReplyMeReqIdl_DataReq() / ReplyMeReqIdl_DataReq.new instead')
  static ReplyMeReqIdl_DataReq create() => ReplyMeReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() => ReplyMeReqIdl_DataReq._();
  @$core.override
  ReplyMeReqIdl_DataReq createEmptyInstance() => ReplyMeReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplyMeReqIdl_DataReq>(
          ReplyMeReqIdl_DataReq.$_createMessage);
  static ReplyMeReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pn => $_getIZ(0);
  @$pb.TagNumber(1)
  set pn($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPn() => $_has(0);
  @$pb.TagNumber(1)
  void clearPn() => $_clearField(1);

  @$pb.TagNumber(3)
  $0.CommonReq get common => $_getN(1);
  @$pb.TagNumber(3)
  set common($0.CommonReq value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCommon() => $_has(1);
  @$pb.TagNumber(3)
  void clearCommon() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.CommonReq ensureCommon() => $_ensure(1);
}

class ReplyMeReqIdl extends $pb.GeneratedMessage {
  factory ReplyMeReqIdl({
    ReplyMeReqIdl_DataReq? data,
  }) {
    final result = ReplyMeReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  ReplyMeReqIdl._();

  factory ReplyMeReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeReqIdl()..mergeFromBuffer(data, registry);
  factory ReplyMeReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplyMeReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMeReqIdl',
      createEmptyInstance: ReplyMeReqIdl.$_createMessage)
    ..aOM<ReplyMeReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: ReplyMeReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMeReqIdl copyWith(void Function(ReplyMeReqIdl) updates) =>
      super.copyWith((message) => updates(message as ReplyMeReqIdl))
          as ReplyMeReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReplyMeReqIdl() / ReplyMeReqIdl.new instead')
  static ReplyMeReqIdl create() => ReplyMeReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => ReplyMeReqIdl._();
  @$core.override
  ReplyMeReqIdl createEmptyInstance() => ReplyMeReqIdl._();
  @$core.pragma('dart2js:noInline')
  static ReplyMeReqIdl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReplyMeReqIdl>(
          ReplyMeReqIdl.$_createMessage);
  static ReplyMeReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  ReplyMeReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ReplyMeReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  ReplyMeReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
