// This is a generated file - do not edit.
//
// Generated from Personalized.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'CommonReq.pb.dart' as $0;
import 'Error.pb.dart' as $2;
import 'ThreadInfo.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PersonalizedRequestData extends $pb.GeneratedMessage {
  factory PersonalizedRequestData({
    $0.CommonReq? common,
    $core.int? tagCode,
    $core.int? needTags,
    $core.int? loadType,
    $core.int? pageThreadCount,
    $core.int? pn,
    $core.int? sugCount,
    $core.int? scrW,
    $core.int? scrH,
    $core.double? scrDip,
    $core.int? qType,
    $core.int? needForumlist,
    $core.int? newNetType,
    $core.int? preAdThreadCount,
    $core.int? newInstall,
    $core.int? requestTimes,
    $core.String? invokeSource,
  }) {
    final result = PersonalizedRequestData._();
    if (common != null) result.common = common;
    if (tagCode != null) result.tagCode = tagCode;
    if (needTags != null) result.needTags = needTags;
    if (loadType != null) result.loadType = loadType;
    if (pageThreadCount != null) result.pageThreadCount = pageThreadCount;
    if (pn != null) result.pn = pn;
    if (sugCount != null) result.sugCount = sugCount;
    if (scrW != null) result.scrW = scrW;
    if (scrH != null) result.scrH = scrH;
    if (scrDip != null) result.scrDip = scrDip;
    if (qType != null) result.qType = qType;
    if (needForumlist != null) result.needForumlist = needForumlist;
    if (newNetType != null) result.newNetType = newNetType;
    if (preAdThreadCount != null) result.preAdThreadCount = preAdThreadCount;
    if (newInstall != null) result.newInstall = newInstall;
    if (requestTimes != null) result.requestTimes = requestTimes;
    if (invokeSource != null) result.invokeSource = invokeSource;
    return result;
  }

  PersonalizedRequestData._();

  factory PersonalizedRequestData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedRequestData()..mergeFromBuffer(data, registry);
  factory PersonalizedRequestData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedRequestData()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PersonalizedRequestData',
      createEmptyInstance: PersonalizedRequestData.$_createMessage)
    ..aOM<$0.CommonReq>(1, _omitFieldNames ? '' : 'common',
        subBuilder: $0.CommonReq.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'tagCode', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'needTags', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'loadType', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'pageThreadCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'pn', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'sugCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(8, _omitFieldNames ? '' : 'scrW')
    ..aI(9, _omitFieldNames ? '' : 'scrH')
    ..aD(10, _omitFieldNames ? '' : 'scrDip')
    ..aI(11, _omitFieldNames ? '' : 'qType')
    ..aI(22, _omitFieldNames ? '' : 'needForumlist',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(23, _omitFieldNames ? '' : 'newNetType',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(26, _omitFieldNames ? '' : 'preAdThreadCount')
    ..aI(27, _omitFieldNames ? '' : 'newInstall')
    ..aI(28, _omitFieldNames ? '' : 'requestTimes')
    ..aOS(29, _omitFieldNames ? '' : 'invokeSource')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedRequestData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedRequestData copyWith(
          void Function(PersonalizedRequestData) updates) =>
      super.copyWith((message) => updates(message as PersonalizedRequestData))
          as PersonalizedRequestData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PersonalizedRequestData() / PersonalizedRequestData.new instead')
  static PersonalizedRequestData create() => PersonalizedRequestData._();
  static $pb.GeneratedMessage $_createMessage() => PersonalizedRequestData._();
  @$core.override
  PersonalizedRequestData createEmptyInstance() => PersonalizedRequestData._();
  @$core.pragma('dart2js:noInline')
  static PersonalizedRequestData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PersonalizedRequestData>(
          PersonalizedRequestData.$_createMessage);
  static PersonalizedRequestData? _defaultInstance;

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
  $core.int get tagCode => $_getIZ(1);
  @$pb.TagNumber(2)
  set tagCode($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTagCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearTagCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get needTags => $_getIZ(2);
  @$pb.TagNumber(3)
  set needTags($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNeedTags() => $_has(2);
  @$pb.TagNumber(3)
  void clearNeedTags() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get loadType => $_getIZ(3);
  @$pb.TagNumber(4)
  set loadType($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLoadType() => $_has(3);
  @$pb.TagNumber(4)
  void clearLoadType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageThreadCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageThreadCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageThreadCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageThreadCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get pn => $_getIZ(5);
  @$pb.TagNumber(6)
  set pn($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPn() => $_has(5);
  @$pb.TagNumber(6)
  void clearPn() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get sugCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set sugCount($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSugCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearSugCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get scrW => $_getIZ(7);
  @$pb.TagNumber(8)
  set scrW($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasScrW() => $_has(7);
  @$pb.TagNumber(8)
  void clearScrW() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get scrH => $_getIZ(8);
  @$pb.TagNumber(9)
  set scrH($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasScrH() => $_has(8);
  @$pb.TagNumber(9)
  void clearScrH() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get scrDip => $_getN(9);
  @$pb.TagNumber(10)
  set scrDip($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasScrDip() => $_has(9);
  @$pb.TagNumber(10)
  void clearScrDip() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get qType => $_getIZ(10);
  @$pb.TagNumber(11)
  set qType($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasQType() => $_has(10);
  @$pb.TagNumber(11)
  void clearQType() => $_clearField(11);

  @$pb.TagNumber(22)
  $core.int get needForumlist => $_getIZ(11);
  @$pb.TagNumber(22)
  set needForumlist($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(22)
  $core.bool hasNeedForumlist() => $_has(11);
  @$pb.TagNumber(22)
  void clearNeedForumlist() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.int get newNetType => $_getIZ(12);
  @$pb.TagNumber(23)
  set newNetType($core.int value) => $_setUnsignedInt32(12, value);
  @$pb.TagNumber(23)
  $core.bool hasNewNetType() => $_has(12);
  @$pb.TagNumber(23)
  void clearNewNetType() => $_clearField(23);

  @$pb.TagNumber(26)
  $core.int get preAdThreadCount => $_getIZ(13);
  @$pb.TagNumber(26)
  set preAdThreadCount($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(26)
  $core.bool hasPreAdThreadCount() => $_has(13);
  @$pb.TagNumber(26)
  void clearPreAdThreadCount() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.int get newInstall => $_getIZ(14);
  @$pb.TagNumber(27)
  set newInstall($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(27)
  $core.bool hasNewInstall() => $_has(14);
  @$pb.TagNumber(27)
  void clearNewInstall() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.int get requestTimes => $_getIZ(15);
  @$pb.TagNumber(28)
  set requestTimes($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(28)
  $core.bool hasRequestTimes() => $_has(15);
  @$pb.TagNumber(28)
  void clearRequestTimes() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get invokeSource => $_getSZ(16);
  @$pb.TagNumber(29)
  set invokeSource($core.String value) => $_setString(16, value);
  @$pb.TagNumber(29)
  $core.bool hasInvokeSource() => $_has(16);
  @$pb.TagNumber(29)
  void clearInvokeSource() => $_clearField(29);
}

class PersonalizedRequest extends $pb.GeneratedMessage {
  factory PersonalizedRequest({
    PersonalizedRequestData? data,
  }) {
    final result = PersonalizedRequest._();
    if (data != null) result.data = data;
    return result;
  }

  PersonalizedRequest._();

  factory PersonalizedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedRequest()..mergeFromBuffer(data, registry);
  factory PersonalizedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PersonalizedRequest',
      createEmptyInstance: PersonalizedRequest.$_createMessage)
    ..aOM<PersonalizedRequestData>(1, _omitFieldNames ? '' : 'data',
        subBuilder: PersonalizedRequestData.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedRequest copyWith(void Function(PersonalizedRequest) updates) =>
      super.copyWith((message) => updates(message as PersonalizedRequest))
          as PersonalizedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use PersonalizedRequest() / PersonalizedRequest.new instead')
  static PersonalizedRequest create() => PersonalizedRequest._();
  static $pb.GeneratedMessage $_createMessage() => PersonalizedRequest._();
  @$core.override
  PersonalizedRequest createEmptyInstance() => PersonalizedRequest._();
  @$core.pragma('dart2js:noInline')
  static PersonalizedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PersonalizedRequest>(
          PersonalizedRequest.$_createMessage);
  static PersonalizedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PersonalizedRequestData get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(PersonalizedRequestData value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  PersonalizedRequestData ensureData() => $_ensure(0);
}

class PersonalizedResponseData extends $pb.GeneratedMessage {
  factory PersonalizedResponseData({
    $core.Iterable<$1.ThreadInfo>? threadList,
  }) {
    final result = PersonalizedResponseData._();
    if (threadList != null) result.threadList.addAll(threadList);
    return result;
  }

  PersonalizedResponseData._();

  factory PersonalizedResponseData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedResponseData()..mergeFromBuffer(data, registry);
  factory PersonalizedResponseData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedResponseData()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PersonalizedResponseData',
      createEmptyInstance: PersonalizedResponseData.$_createMessage)
    ..pPM<$1.ThreadInfo>(2, _omitFieldNames ? '' : 'threadList',
        subBuilder: $1.ThreadInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedResponseData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedResponseData copyWith(
          void Function(PersonalizedResponseData) updates) =>
      super.copyWith((message) => updates(message as PersonalizedResponseData))
          as PersonalizedResponseData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PersonalizedResponseData() / PersonalizedResponseData.new instead')
  static PersonalizedResponseData create() => PersonalizedResponseData._();
  static $pb.GeneratedMessage $_createMessage() => PersonalizedResponseData._();
  @$core.override
  PersonalizedResponseData createEmptyInstance() =>
      PersonalizedResponseData._();
  @$core.pragma('dart2js:noInline')
  static PersonalizedResponseData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PersonalizedResponseData>(
          PersonalizedResponseData.$_createMessage);
  static PersonalizedResponseData? _defaultInstance;

  @$pb.TagNumber(2)
  $pb.PbList<$1.ThreadInfo> get threadList => $_getList(0);
}

class PersonalizedResponse extends $pb.GeneratedMessage {
  factory PersonalizedResponse({
    $2.Error? error,
    PersonalizedResponseData? data,
  }) {
    final result = PersonalizedResponse._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  PersonalizedResponse._();

  factory PersonalizedResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedResponse()..mergeFromBuffer(data, registry);
  factory PersonalizedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalizedResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PersonalizedResponse',
      createEmptyInstance: PersonalizedResponse.$_createMessage)
    ..aOM<$2.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $2.Error.$_createMessage)
    ..aOM<PersonalizedResponseData>(2, _omitFieldNames ? '' : 'data',
        subBuilder: PersonalizedResponseData.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalizedResponse copyWith(void Function(PersonalizedResponse) updates) =>
      super.copyWith((message) => updates(message as PersonalizedResponse))
          as PersonalizedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PersonalizedResponse() / PersonalizedResponse.new instead')
  static PersonalizedResponse create() => PersonalizedResponse._();
  static $pb.GeneratedMessage $_createMessage() => PersonalizedResponse._();
  @$core.override
  PersonalizedResponse createEmptyInstance() => PersonalizedResponse._();
  @$core.pragma('dart2js:noInline')
  static PersonalizedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PersonalizedResponse>(
          PersonalizedResponse.$_createMessage);
  static PersonalizedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($2.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  PersonalizedResponseData get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(PersonalizedResponseData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  PersonalizedResponseData ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
