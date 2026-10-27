// This is a generated file - do not edit.
//
// Generated from SearchPostForumReqIdl.proto.

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

class SearchPostForumReqIdl_DataReq extends $pb.GeneratedMessage {
  factory SearchPostForumReqIdl_DataReq({
    $0.CommonReq? common,
    $core.String? fname,
  }) {
    final result = SearchPostForumReqIdl_DataReq._();
    if (common != null) result.common = common;
    if (fname != null) result.fname = fname;
    return result;
  }

  SearchPostForumReqIdl_DataReq._();

  factory SearchPostForumReqIdl_DataReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumReqIdl_DataReq()..mergeFromBuffer(data, registry);
  factory SearchPostForumReqIdl_DataReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumReqIdl_DataReq()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchPostForumReqIdl.DataReq',
      createEmptyInstance: SearchPostForumReqIdl_DataReq.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'fname')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumReqIdl_DataReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumReqIdl_DataReq copyWith(
          void Function(SearchPostForumReqIdl_DataReq) updates) =>
      super.copyWith(
              (message) => updates(message as SearchPostForumReqIdl_DataReq))
          as SearchPostForumReqIdl_DataReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SearchPostForumReqIdl_DataReq() / SearchPostForumReqIdl_DataReq.new instead')
  static SearchPostForumReqIdl_DataReq create() =>
      SearchPostForumReqIdl_DataReq._();
  static $pb.GeneratedMessage $_createMessage() =>
      SearchPostForumReqIdl_DataReq._();
  @$core.override
  SearchPostForumReqIdl_DataReq createEmptyInstance() =>
      SearchPostForumReqIdl_DataReq._();
  @$core.pragma('dart2js:noInline')
  static SearchPostForumReqIdl_DataReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchPostForumReqIdl_DataReq>(
          SearchPostForumReqIdl_DataReq.$_createMessage);
  static SearchPostForumReqIdl_DataReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.CommonReq get common => $_getN(0);
  @$pb.TagNumber(1)
  set common($0.CommonReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.CommonReq ensureCommon() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get fname => $_getSZ(1);
  @$pb.TagNumber(2)
  set fname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFname() => $_has(1);
  @$pb.TagNumber(2)
  void clearFname() => $_clearField(2);
}

class SearchPostForumReqIdl extends $pb.GeneratedMessage {
  factory SearchPostForumReqIdl({
    SearchPostForumReqIdl_DataReq? data,
  }) {
    final result = SearchPostForumReqIdl._();
    if (data != null) result.data = data;
    return result;
  }

  SearchPostForumReqIdl._();

  factory SearchPostForumReqIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumReqIdl()..mergeFromBuffer(data, registry);
  factory SearchPostForumReqIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchPostForumReqIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchPostForumReqIdl',
      createEmptyInstance: SearchPostForumReqIdl.$_createMessage)
    ..aOM<SearchPostForumReqIdl_DataReq>(1, _omitFieldNames ? '' : 'data',
        subBuilder: SearchPostForumReqIdl_DataReq.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumReqIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchPostForumReqIdl copyWith(
          void Function(SearchPostForumReqIdl) updates) =>
      super.copyWith((message) => updates(message as SearchPostForumReqIdl))
          as SearchPostForumReqIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SearchPostForumReqIdl() / SearchPostForumReqIdl.new instead')
  static SearchPostForumReqIdl create() => SearchPostForumReqIdl._();
  static $pb.GeneratedMessage $_createMessage() => SearchPostForumReqIdl._();
  @$core.override
  SearchPostForumReqIdl createEmptyInstance() => SearchPostForumReqIdl._();
  @$core.pragma('dart2js:noInline')
  static SearchPostForumReqIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchPostForumReqIdl>(
          SearchPostForumReqIdl.$_createMessage);
  static SearchPostForumReqIdl? _defaultInstance;

  @$pb.TagNumber(1)
  SearchPostForumReqIdl_DataReq get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(SearchPostForumReqIdl_DataReq value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchPostForumReqIdl_DataReq ensureData() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
