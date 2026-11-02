// This is a generated file - do not edit.
//
// Generated from HotThreadList.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'CommonReq.pb.dart' as $0;
import 'Error.pb.dart' as $4;
import 'FrsTabInfo.pb.dart' as $3;
import 'RecommendTopicList.pb.dart' as $1;
import 'ThreadInfo.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HotThreadListRequestData extends $pb.GeneratedMessage {
  factory HotThreadListRequestData({
    $0.CommonReq? common,
    $core.String? tabId,
    $core.String? tabCode,
  }) {
    final result = HotThreadListRequestData._();
    if (common != null) result.common = common;
    if (tabId != null) result.tabId = tabId;
    if (tabCode != null) result.tabCode = tabCode;
    return result;
  }

  HotThreadListRequestData._();

  factory HotThreadListRequestData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListRequestData()..mergeFromBuffer(data, registry);
  factory HotThreadListRequestData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListRequestData()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HotThreadListRequestData',
      createEmptyInstance: HotThreadListRequestData.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'tabId', protoName: 'tabId')
    ..aOS(3, _omitFieldNames ? '' : 'tabCode', protoName: 'tabCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListRequestData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListRequestData copyWith(
          void Function(HotThreadListRequestData) updates) =>
      super.copyWith((message) => updates(message as HotThreadListRequestData))
          as HotThreadListRequestData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use HotThreadListRequestData() / HotThreadListRequestData.new instead')
  static HotThreadListRequestData create() => HotThreadListRequestData._();
  static $pb.GeneratedMessage $_createMessage() => HotThreadListRequestData._();
  @$core.override
  HotThreadListRequestData createEmptyInstance() =>
      HotThreadListRequestData._();
  @$core.pragma('dart2js:noInline')
  static HotThreadListRequestData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HotThreadListRequestData>(
          HotThreadListRequestData.$_createMessage);
  static HotThreadListRequestData? _defaultInstance;

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
  $core.String get tabId => $_getSZ(1);
  @$pb.TagNumber(2)
  set tabId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTabId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTabId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get tabCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set tabCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTabCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearTabCode() => $_clearField(3);
}

class HotThreadListRequest extends $pb.GeneratedMessage {
  factory HotThreadListRequest({
    HotThreadListRequestData? data,
  }) {
    final result = HotThreadListRequest._();
    if (data != null) result.data = data;
    return result;
  }

  HotThreadListRequest._();

  factory HotThreadListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListRequest()..mergeFromBuffer(data, registry);
  factory HotThreadListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HotThreadListRequest',
      createEmptyInstance: HotThreadListRequest.$_createMessage)
    ..aOM<HotThreadListRequestData>(1, _omitFieldNames ? '' : 'data',
        subBuilder: HotThreadListRequestData.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListRequest copyWith(void Function(HotThreadListRequest) updates) =>
      super.copyWith((message) => updates(message as HotThreadListRequest))
          as HotThreadListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use HotThreadListRequest() / HotThreadListRequest.new instead')
  static HotThreadListRequest create() => HotThreadListRequest._();
  static $pb.GeneratedMessage $_createMessage() => HotThreadListRequest._();
  @$core.override
  HotThreadListRequest createEmptyInstance() => HotThreadListRequest._();
  @$core.pragma('dart2js:noInline')
  static HotThreadListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HotThreadListRequest>(
          HotThreadListRequest.$_createMessage);
  static HotThreadListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  HotThreadListRequestData get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(HotThreadListRequestData value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  HotThreadListRequestData ensureData() => $_ensure(0);
}

class HotThreadListResponseData extends $pb.GeneratedMessage {
  factory HotThreadListResponseData({
    $core.Iterable<$1.RecommendTopicList>? topicList,
    $core.Iterable<$2.ThreadInfo>? threadInfo,
    $core.Iterable<$3.FrsTabInfo>? hotThreadTabInfo,
  }) {
    final result = HotThreadListResponseData._();
    if (topicList != null) result.topicList.addAll(topicList);
    if (threadInfo != null) result.threadInfo.addAll(threadInfo);
    if (hotThreadTabInfo != null)
      result.hotThreadTabInfo.addAll(hotThreadTabInfo);
    return result;
  }

  HotThreadListResponseData._();

  factory HotThreadListResponseData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListResponseData()..mergeFromBuffer(data, registry);
  factory HotThreadListResponseData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListResponseData()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HotThreadListResponseData',
      createEmptyInstance: HotThreadListResponseData.$_createMessage)
    ..pPM<$1.RecommendTopicList>(1, _omitFieldNames ? '' : 'topicList',
        protoName: 'topicList',
        subBuilder: $1.RecommendTopicList.$_createMessage)
    ..pPM<$2.ThreadInfo>(2, _omitFieldNames ? '' : 'threadInfo',
        protoName: 'threadInfo', subBuilder: $2.ThreadInfo.$_createMessage)
    ..pPM<$3.FrsTabInfo>(3, _omitFieldNames ? '' : 'hotThreadTabInfo',
        protoName: 'hotThreadTabInfo',
        subBuilder: $3.FrsTabInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListResponseData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListResponseData copyWith(
          void Function(HotThreadListResponseData) updates) =>
      super.copyWith((message) => updates(message as HotThreadListResponseData))
          as HotThreadListResponseData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use HotThreadListResponseData() / HotThreadListResponseData.new instead')
  static HotThreadListResponseData create() => HotThreadListResponseData._();
  static $pb.GeneratedMessage $_createMessage() =>
      HotThreadListResponseData._();
  @$core.override
  HotThreadListResponseData createEmptyInstance() =>
      HotThreadListResponseData._();
  @$core.pragma('dart2js:noInline')
  static HotThreadListResponseData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HotThreadListResponseData>(
          HotThreadListResponseData.$_createMessage);
  static HotThreadListResponseData? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.RecommendTopicList> get topicList => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$2.ThreadInfo> get threadInfo => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$3.FrsTabInfo> get hotThreadTabInfo => $_getList(2);
}

class HotThreadListResponse extends $pb.GeneratedMessage {
  factory HotThreadListResponse({
    $4.Error? error,
    HotThreadListResponseData? data,
  }) {
    final result = HotThreadListResponse._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  HotThreadListResponse._();

  factory HotThreadListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListResponse()..mergeFromBuffer(data, registry);
  factory HotThreadListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HotThreadListResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HotThreadListResponse',
      createEmptyInstance: HotThreadListResponse.$_createMessage)
    ..aOM<$4.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $4.Error.$_createMessage)
    ..aOM<HotThreadListResponseData>(2, _omitFieldNames ? '' : 'data',
        subBuilder: HotThreadListResponseData.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HotThreadListResponse copyWith(
          void Function(HotThreadListResponse) updates) =>
      super.copyWith((message) => updates(message as HotThreadListResponse))
          as HotThreadListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use HotThreadListResponse() / HotThreadListResponse.new instead')
  static HotThreadListResponse create() => HotThreadListResponse._();
  static $pb.GeneratedMessage $_createMessage() => HotThreadListResponse._();
  @$core.override
  HotThreadListResponse createEmptyInstance() => HotThreadListResponse._();
  @$core.pragma('dart2js:noInline')
  static HotThreadListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HotThreadListResponse>(
          HotThreadListResponse.$_createMessage);
  static HotThreadListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $4.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($4.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  HotThreadListResponseData get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(HotThreadListResponseData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  HotThreadListResponseData ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
