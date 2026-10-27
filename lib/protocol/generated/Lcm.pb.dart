// This is a generated file - do not edit.
//
// Generated from Lcm.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Common extends $pb.GeneratedMessage {
  factory Common({
    $core.String? cuid,
    $core.String? device,
    $core.String? osVersion,
    $core.String? manufacture,
    $core.String? modelType,
    $core.String? appId,
    $core.String? appVersion,
    $core.String? sdkVersion,
    $core.String? network,
    $core.String? romVersion,
    $core.String? userKey,
  }) {
    final result = Common._();
    if (cuid != null) result.cuid = cuid;
    if (device != null) result.device = device;
    if (osVersion != null) result.osVersion = osVersion;
    if (manufacture != null) result.manufacture = manufacture;
    if (modelType != null) result.modelType = modelType;
    if (appId != null) result.appId = appId;
    if (appVersion != null) result.appVersion = appVersion;
    if (sdkVersion != null) result.sdkVersion = sdkVersion;
    if (network != null) result.network = network;
    if (romVersion != null) result.romVersion = romVersion;
    if (userKey != null) result.userKey = userKey;
    return result;
  }

  Common._();

  factory Common.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Common()..mergeFromBuffer(data, registry);
  factory Common.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Common()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Common',
      createEmptyInstance: Common.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'cuid')
    ..aOS(2, _omitFieldNames ? '' : 'device')
    ..aOS(3, _omitFieldNames ? '' : 'osVersion')
    ..aOS(4, _omitFieldNames ? '' : 'manufacture')
    ..aOS(5, _omitFieldNames ? '' : 'modelType')
    ..aOS(6, _omitFieldNames ? '' : 'appId')
    ..aOS(7, _omitFieldNames ? '' : 'appVersion')
    ..aOS(8, _omitFieldNames ? '' : 'sdkVersion')
    ..aOS(9, _omitFieldNames ? '' : 'network')
    ..aOS(10, _omitFieldNames ? '' : 'romVersion')
    ..aOS(11, _omitFieldNames ? '' : 'userKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Common clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Common copyWith(void Function(Common) updates) =>
      super.copyWith((message) => updates(message as Common)) as Common;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Common() / Common.new instead')
  static Common create() => Common._();
  static $pb.GeneratedMessage $_createMessage() => Common._();
  @$core.override
  Common createEmptyInstance() => Common._();
  @$core.pragma('dart2js:noInline')
  static Common getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Common>(Common.$_createMessage);
  static Common? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get device => $_getSZ(1);
  @$pb.TagNumber(2)
  set device($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDevice() => $_has(1);
  @$pb.TagNumber(2)
  void clearDevice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get osVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set osVersion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOsVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearOsVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get manufacture => $_getSZ(3);
  @$pb.TagNumber(4)
  set manufacture($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasManufacture() => $_has(3);
  @$pb.TagNumber(4)
  void clearManufacture() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get modelType => $_getSZ(4);
  @$pb.TagNumber(5)
  set modelType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasModelType() => $_has(4);
  @$pb.TagNumber(5)
  void clearModelType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get appId => $_getSZ(5);
  @$pb.TagNumber(6)
  set appId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAppId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAppId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get appVersion => $_getSZ(6);
  @$pb.TagNumber(7)
  set appVersion($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAppVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearAppVersion() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sdkVersion => $_getSZ(7);
  @$pb.TagNumber(8)
  set sdkVersion($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSdkVersion() => $_has(7);
  @$pb.TagNumber(8)
  void clearSdkVersion() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get network => $_getSZ(8);
  @$pb.TagNumber(9)
  set network($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNetwork() => $_has(8);
  @$pb.TagNumber(9)
  void clearNetwork() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get romVersion => $_getSZ(9);
  @$pb.TagNumber(10)
  set romVersion($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRomVersion() => $_has(9);
  @$pb.TagNumber(10)
  void clearRomVersion() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get userKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set userKey($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUserKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearUserKey() => $_clearField(11);
}

class LcmNotify extends $pb.GeneratedMessage {
  factory LcmNotify({
    $fixnum.Int64? logId,
    $core.int? action,
  }) {
    final result = LcmNotify._();
    if (logId != null) result.logId = logId;
    if (action != null) result.action = action;
    return result;
  }

  LcmNotify._();

  factory LcmNotify.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmNotify()..mergeFromBuffer(data, registry);
  factory LcmNotify.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmNotify()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LcmNotify',
      createEmptyInstance: LcmNotify.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'logId')
    ..aI(2, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmNotify clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmNotify copyWith(void Function(LcmNotify) updates) =>
      super.copyWith((message) => updates(message as LcmNotify)) as LcmNotify;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LcmNotify() / LcmNotify.new instead')
  static LcmNotify create() => LcmNotify._();
  static $pb.GeneratedMessage $_createMessage() => LcmNotify._();
  @$core.override
  LcmNotify createEmptyInstance() => LcmNotify._();
  @$core.pragma('dart2js:noInline')
  static LcmNotify getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LcmNotify>(LcmNotify.$_createMessage);
  static LcmNotify? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get logId => $_getI64(0);
  @$pb.TagNumber(1)
  set logId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLogId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get action => $_getIZ(1);
  @$pb.TagNumber(2)
  set action($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

class LcmRequest extends $pb.GeneratedMessage {
  factory LcmRequest({
    $fixnum.Int64? logId,
    $core.String? token,
    Common? common,
    $fixnum.Int64? timestamp,
    $core.int? action,
    $core.int? startType,
    $core.int? connType,
  }) {
    final result = LcmRequest._();
    if (logId != null) result.logId = logId;
    if (token != null) result.token = token;
    if (common != null) result.common = common;
    if (timestamp != null) result.timestamp = timestamp;
    if (action != null) result.action = action;
    if (startType != null) result.startType = startType;
    if (connType != null) result.connType = connType;
    return result;
  }

  LcmRequest._();

  factory LcmRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmRequest()..mergeFromBuffer(data, registry);
  factory LcmRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LcmRequest',
      createEmptyInstance: LcmRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'logId')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..aOM<Common>(3, _omitFieldNames ? '' : 'common',
        subBuilder: Common.$_createMessage)
    ..aInt64(4, _omitFieldNames ? '' : 'timestamp')
    ..aI(5, _omitFieldNames ? '' : 'action')
    ..aI(6, _omitFieldNames ? '' : 'startType')
    ..aI(7, _omitFieldNames ? '' : 'connType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmRequest copyWith(void Function(LcmRequest) updates) =>
      super.copyWith((message) => updates(message as LcmRequest)) as LcmRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LcmRequest() / LcmRequest.new instead')
  static LcmRequest create() => LcmRequest._();
  static $pb.GeneratedMessage $_createMessage() => LcmRequest._();
  @$core.override
  LcmRequest createEmptyInstance() => LcmRequest._();
  @$core.pragma('dart2js:noInline')
  static LcmRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LcmRequest>(LcmRequest.$_createMessage);
  static LcmRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get logId => $_getI64(0);
  @$pb.TagNumber(1)
  set logId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLogId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);

  @$pb.TagNumber(3)
  Common get common => $_getN(2);
  @$pb.TagNumber(3)
  set common(Common value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCommon() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommon() => $_clearField(3);
  @$pb.TagNumber(3)
  Common ensureCommon() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get action => $_getIZ(4);
  @$pb.TagNumber(5)
  set action($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAction() => $_has(4);
  @$pb.TagNumber(5)
  void clearAction() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get startType => $_getIZ(5);
  @$pb.TagNumber(6)
  set startType($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStartType() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get connType => $_getIZ(6);
  @$pb.TagNumber(7)
  set connType($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasConnType() => $_has(6);
  @$pb.TagNumber(7)
  void clearConnType() => $_clearField(7);
}

class LcmResponse extends $pb.GeneratedMessage {
  factory LcmResponse({
    $fixnum.Int64? logId,
    $core.int? errorCode,
    $core.String? errorMsg,
    $fixnum.Int64? nextIntervalMs,
    $core.String? serverInfo,
  }) {
    final result = LcmResponse._();
    if (logId != null) result.logId = logId;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMsg != null) result.errorMsg = errorMsg;
    if (nextIntervalMs != null) result.nextIntervalMs = nextIntervalMs;
    if (serverInfo != null) result.serverInfo = serverInfo;
    return result;
  }

  LcmResponse._();

  factory LcmResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmResponse()..mergeFromBuffer(data, registry);
  factory LcmResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LcmResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LcmResponse',
      createEmptyInstance: LcmResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'logId')
    ..aI(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMsg')
    ..aInt64(4, _omitFieldNames ? '' : 'nextIntervalMs')
    ..aOS(5, _omitFieldNames ? '' : 'serverInfo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LcmResponse copyWith(void Function(LcmResponse) updates) =>
      super.copyWith((message) => updates(message as LcmResponse))
          as LcmResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LcmResponse() / LcmResponse.new instead')
  static LcmResponse create() => LcmResponse._();
  static $pb.GeneratedMessage $_createMessage() => LcmResponse._();
  @$core.override
  LcmResponse createEmptyInstance() => LcmResponse._();
  @$core.pragma('dart2js:noInline')
  static LcmResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LcmResponse>(
          LcmResponse.$_createMessage);
  static LcmResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get logId => $_getI64(0);
  @$pb.TagNumber(1)
  set logId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLogId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get errorCode => $_getIZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMsg => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMsg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMsg() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get nextIntervalMs => $_getI64(3);
  @$pb.TagNumber(4)
  set nextIntervalMs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextIntervalMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextIntervalMs() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get serverInfo => $_getSZ(4);
  @$pb.TagNumber(5)
  set serverInfo($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasServerInfo() => $_has(4);
  @$pb.TagNumber(5)
  void clearServerInfo() => $_clearField(5);
}

class RpcData extends $pb.GeneratedMessage {
  factory RpcData({
    LcmRequest? lcmRequest,
    LcmResponse? lcmResponse,
    LcmNotify? lcmNotify,
  }) {
    final result = RpcData._();
    if (lcmRequest != null) result.lcmRequest = lcmRequest;
    if (lcmResponse != null) result.lcmResponse = lcmResponse;
    if (lcmNotify != null) result.lcmNotify = lcmNotify;
    return result;
  }

  RpcData._();

  factory RpcData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcData()..mergeFromBuffer(data, registry);
  factory RpcData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcData()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcData',
      createEmptyInstance: RpcData.$_createMessage)
    ..aOM<LcmRequest>(1, _omitFieldNames ? '' : 'lcmRequest',
        subBuilder: LcmRequest.$_createMessage)
    ..aOM<LcmResponse>(2, _omitFieldNames ? '' : 'lcmResponse',
        subBuilder: LcmResponse.$_createMessage)
    ..aOM<LcmNotify>(3, _omitFieldNames ? '' : 'lcmNotify',
        subBuilder: LcmNotify.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcData copyWith(void Function(RpcData) updates) =>
      super.copyWith((message) => updates(message as RpcData)) as RpcData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcData() / RpcData.new instead')
  static RpcData create() => RpcData._();
  static $pb.GeneratedMessage $_createMessage() => RpcData._();
  @$core.override
  RpcData createEmptyInstance() => RpcData._();
  @$core.pragma('dart2js:noInline')
  static RpcData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RpcData>(RpcData.$_createMessage);
  static RpcData? _defaultInstance;

  @$pb.TagNumber(1)
  LcmRequest get lcmRequest => $_getN(0);
  @$pb.TagNumber(1)
  set lcmRequest(LcmRequest value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLcmRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearLcmRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  LcmRequest ensureLcmRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  LcmResponse get lcmResponse => $_getN(1);
  @$pb.TagNumber(2)
  set lcmResponse(LcmResponse value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLcmResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearLcmResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  LcmResponse ensureLcmResponse() => $_ensure(1);

  @$pb.TagNumber(3)
  LcmNotify get lcmNotify => $_getN(2);
  @$pb.TagNumber(3)
  set lcmNotify(LcmNotify value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLcmNotify() => $_has(2);
  @$pb.TagNumber(3)
  void clearLcmNotify() => $_clearField(3);
  @$pb.TagNumber(3)
  LcmNotify ensureLcmNotify() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
