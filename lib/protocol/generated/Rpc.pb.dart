// This is a generated file - do not edit.
//
// Generated from Rpc.proto.

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

class ChunkInfo extends $pb.GeneratedMessage {
  factory ChunkInfo({
    $fixnum.Int64? streamId,
    $fixnum.Int64? chunkId,
  }) {
    final result = ChunkInfo._();
    if (streamId != null) result.streamId = streamId;
    if (chunkId != null) result.chunkId = chunkId;
    return result;
  }

  ChunkInfo._();

  factory ChunkInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChunkInfo()..mergeFromBuffer(data, registry);
  factory ChunkInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChunkInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChunkInfo',
      createEmptyInstance: ChunkInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'streamId')
    ..aInt64(2, _omitFieldNames ? '' : 'chunkId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkInfo copyWith(void Function(ChunkInfo) updates) =>
      super.copyWith((message) => updates(message as ChunkInfo)) as ChunkInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChunkInfo() / ChunkInfo.new instead')
  static ChunkInfo create() => ChunkInfo._();
  static $pb.GeneratedMessage $_createMessage() => ChunkInfo._();
  @$core.override
  ChunkInfo createEmptyInstance() => ChunkInfo._();
  @$core.pragma('dart2js:noInline')
  static ChunkInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChunkInfo>(ChunkInfo.$_createMessage);
  static ChunkInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get streamId => $_getI64(0);
  @$pb.TagNumber(1)
  set streamId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStreamId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chunkId => $_getI64(1);
  @$pb.TagNumber(2)
  set chunkId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChunkId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunkId() => $_clearField(2);
}

class EventTimestamp extends $pb.GeneratedMessage {
  factory EventTimestamp({
    $core.String? event,
    $fixnum.Int64? timestampMs,
  }) {
    final result = EventTimestamp._();
    if (event != null) result.event = event;
    if (timestampMs != null) result.timestampMs = timestampMs;
    return result;
  }

  EventTimestamp._();

  factory EventTimestamp.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EventTimestamp()..mergeFromBuffer(data, registry);
  factory EventTimestamp.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EventTimestamp()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventTimestamp',
      createEmptyInstance: EventTimestamp.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'event')
    ..aInt64(2, _omitFieldNames ? '' : 'timestampMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTimestamp clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTimestamp copyWith(void Function(EventTimestamp) updates) =>
      super.copyWith((message) => updates(message as EventTimestamp))
          as EventTimestamp;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EventTimestamp() / EventTimestamp.new instead')
  static EventTimestamp create() => EventTimestamp._();
  static $pb.GeneratedMessage $_createMessage() => EventTimestamp._();
  @$core.override
  EventTimestamp createEmptyInstance() => EventTimestamp._();
  @$core.pragma('dart2js:noInline')
  static EventTimestamp getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventTimestamp>(
          EventTimestamp.$_createMessage);
  static EventTimestamp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get event => $_getSZ(0);
  @$pb.TagNumber(1)
  set event($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestampMs => $_getI64(1);
  @$pb.TagNumber(2)
  set timestampMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTimestampMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestampMs() => $_clearField(2);
}

class RpcNotifyMeta extends $pb.GeneratedMessage {
  factory RpcNotifyMeta({
    $fixnum.Int64? serviceId,
    $fixnum.Int64? methodId,
    $fixnum.Int64? logId,
    $core.Iterable<EventTimestamp>? eventList,
  }) {
    final result = RpcNotifyMeta._();
    if (serviceId != null) result.serviceId = serviceId;
    if (methodId != null) result.methodId = methodId;
    if (logId != null) result.logId = logId;
    if (eventList != null) result.eventList.addAll(eventList);
    return result;
  }

  RpcNotifyMeta._();

  factory RpcNotifyMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcNotifyMeta()..mergeFromBuffer(data, registry);
  factory RpcNotifyMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcNotifyMeta()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcNotifyMeta',
      createEmptyInstance: RpcNotifyMeta.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'serviceId')
    ..aInt64(2, _omitFieldNames ? '' : 'methodId')
    ..aInt64(3, _omitFieldNames ? '' : 'logId')
    ..pPM<EventTimestamp>(4, _omitFieldNames ? '' : 'eventList',
        subBuilder: EventTimestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcNotifyMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcNotifyMeta copyWith(void Function(RpcNotifyMeta) updates) =>
      super.copyWith((message) => updates(message as RpcNotifyMeta))
          as RpcNotifyMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcNotifyMeta() / RpcNotifyMeta.new instead')
  static RpcNotifyMeta create() => RpcNotifyMeta._();
  static $pb.GeneratedMessage $_createMessage() => RpcNotifyMeta._();
  @$core.override
  RpcNotifyMeta createEmptyInstance() => RpcNotifyMeta._();
  @$core.pragma('dart2js:noInline')
  static RpcNotifyMeta getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcNotifyMeta>(
          RpcNotifyMeta.$_createMessage);
  static RpcNotifyMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serviceId => $_getI64(0);
  @$pb.TagNumber(1)
  set serviceId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get methodId => $_getI64(1);
  @$pb.TagNumber(2)
  set methodId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethodId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logId => $_getI64(2);
  @$pb.TagNumber(3)
  set logId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogId() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<EventTimestamp> get eventList => $_getList(3);
}

class RpcRequestMeta extends $pb.GeneratedMessage {
  factory RpcRequestMeta({
    $fixnum.Int64? serviceId,
    $fixnum.Int64? methodId,
    $fixnum.Int64? logId,
    $core.int? needCommon,
    $core.Iterable<EventTimestamp>? eventList,
  }) {
    final result = RpcRequestMeta._();
    if (serviceId != null) result.serviceId = serviceId;
    if (methodId != null) result.methodId = methodId;
    if (logId != null) result.logId = logId;
    if (needCommon != null) result.needCommon = needCommon;
    if (eventList != null) result.eventList.addAll(eventList);
    return result;
  }

  RpcRequestMeta._();

  factory RpcRequestMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcRequestMeta()..mergeFromBuffer(data, registry);
  factory RpcRequestMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcRequestMeta()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcRequestMeta',
      createEmptyInstance: RpcRequestMeta.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'serviceId')
    ..aInt64(2, _omitFieldNames ? '' : 'methodId')
    ..aInt64(3, _omitFieldNames ? '' : 'logId')
    ..aI(4, _omitFieldNames ? '' : 'needCommon')
    ..pPM<EventTimestamp>(5, _omitFieldNames ? '' : 'eventList',
        subBuilder: EventTimestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcRequestMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcRequestMeta copyWith(void Function(RpcRequestMeta) updates) =>
      super.copyWith((message) => updates(message as RpcRequestMeta))
          as RpcRequestMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcRequestMeta() / RpcRequestMeta.new instead')
  static RpcRequestMeta create() => RpcRequestMeta._();
  static $pb.GeneratedMessage $_createMessage() => RpcRequestMeta._();
  @$core.override
  RpcRequestMeta createEmptyInstance() => RpcRequestMeta._();
  @$core.pragma('dart2js:noInline')
  static RpcRequestMeta getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcRequestMeta>(
          RpcRequestMeta.$_createMessage);
  static RpcRequestMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serviceId => $_getI64(0);
  @$pb.TagNumber(1)
  set serviceId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get methodId => $_getI64(1);
  @$pb.TagNumber(2)
  set methodId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethodId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logId => $_getI64(2);
  @$pb.TagNumber(3)
  set logId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get needCommon => $_getIZ(3);
  @$pb.TagNumber(4)
  set needCommon($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNeedCommon() => $_has(3);
  @$pb.TagNumber(4)
  void clearNeedCommon() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<EventTimestamp> get eventList => $_getList(4);
}

class RpcResponseMeta extends $pb.GeneratedMessage {
  factory RpcResponseMeta({
    $fixnum.Int64? serviceId,
    $fixnum.Int64? methodId,
    $fixnum.Int64? logId,
    $core.int? errorCode,
    $core.String? errorText,
    $core.Iterable<EventTimestamp>? eventList,
  }) {
    final result = RpcResponseMeta._();
    if (serviceId != null) result.serviceId = serviceId;
    if (methodId != null) result.methodId = methodId;
    if (logId != null) result.logId = logId;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorText != null) result.errorText = errorText;
    if (eventList != null) result.eventList.addAll(eventList);
    return result;
  }

  RpcResponseMeta._();

  factory RpcResponseMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcResponseMeta()..mergeFromBuffer(data, registry);
  factory RpcResponseMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcResponseMeta()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcResponseMeta',
      createEmptyInstance: RpcResponseMeta.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'serviceId')
    ..aInt64(2, _omitFieldNames ? '' : 'methodId')
    ..aInt64(3, _omitFieldNames ? '' : 'logId')
    ..aI(4, _omitFieldNames ? '' : 'errorCode')
    ..aOS(5, _omitFieldNames ? '' : 'errorText')
    ..pPM<EventTimestamp>(6, _omitFieldNames ? '' : 'eventList',
        subBuilder: EventTimestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcResponseMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcResponseMeta copyWith(void Function(RpcResponseMeta) updates) =>
      super.copyWith((message) => updates(message as RpcResponseMeta))
          as RpcResponseMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcResponseMeta() / RpcResponseMeta.new instead')
  static RpcResponseMeta create() => RpcResponseMeta._();
  static $pb.GeneratedMessage $_createMessage() => RpcResponseMeta._();
  @$core.override
  RpcResponseMeta createEmptyInstance() => RpcResponseMeta._();
  @$core.pragma('dart2js:noInline')
  static RpcResponseMeta getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcResponseMeta>(
          RpcResponseMeta.$_createMessage);
  static RpcResponseMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serviceId => $_getI64(0);
  @$pb.TagNumber(1)
  set serviceId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get methodId => $_getI64(1);
  @$pb.TagNumber(2)
  set methodId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethodId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logId => $_getI64(2);
  @$pb.TagNumber(3)
  set logId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get errorCode => $_getIZ(3);
  @$pb.TagNumber(4)
  set errorCode($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get errorText => $_getSZ(4);
  @$pb.TagNumber(5)
  set errorText($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasErrorText() => $_has(4);
  @$pb.TagNumber(5)
  void clearErrorText() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<EventTimestamp> get eventList => $_getList(5);
}

class RpcMeta extends $pb.GeneratedMessage {
  factory RpcMeta({
    RpcRequestMeta? request,
    RpcResponseMeta? response,
    $core.int? compressType,
    $fixnum.Int64? correlationId,
    $core.int? attachmentSize,
    ChunkInfo? chunkInfo,
    $core.List<$core.int>? authenticationData,
    RpcNotifyMeta? notify,
    $core.int? acceptCompressType,
  }) {
    final result = RpcMeta._();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    if (compressType != null) result.compressType = compressType;
    if (correlationId != null) result.correlationId = correlationId;
    if (attachmentSize != null) result.attachmentSize = attachmentSize;
    if (chunkInfo != null) result.chunkInfo = chunkInfo;
    if (authenticationData != null)
      result.authenticationData = authenticationData;
    if (notify != null) result.notify = notify;
    if (acceptCompressType != null)
      result.acceptCompressType = acceptCompressType;
    return result;
  }

  RpcMeta._();

  factory RpcMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcMeta()..mergeFromBuffer(data, registry);
  factory RpcMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcMeta()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcMeta',
      createEmptyInstance: RpcMeta.$_createMessage)
    ..aOM<RpcRequestMeta>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RpcRequestMeta.$_createMessage)
    ..aOM<RpcResponseMeta>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RpcResponseMeta.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'compressType')
    ..aInt64(4, _omitFieldNames ? '' : 'correlationId')
    ..aI(5, _omitFieldNames ? '' : 'attachmentSize')
    ..aOM<ChunkInfo>(6, _omitFieldNames ? '' : 'chunkInfo',
        subBuilder: ChunkInfo.$_createMessage)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'authenticationData', $pb.PbFieldType.OY)
    ..aOM<RpcNotifyMeta>(8, _omitFieldNames ? '' : 'notify',
        subBuilder: RpcNotifyMeta.$_createMessage)
    ..aI(9, _omitFieldNames ? '' : 'acceptCompressType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcMeta copyWith(void Function(RpcMeta) updates) =>
      super.copyWith((message) => updates(message as RpcMeta)) as RpcMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcMeta() / RpcMeta.new instead')
  static RpcMeta create() => RpcMeta._();
  static $pb.GeneratedMessage $_createMessage() => RpcMeta._();
  @$core.override
  RpcMeta createEmptyInstance() => RpcMeta._();
  @$core.pragma('dart2js:noInline')
  static RpcMeta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RpcMeta>(RpcMeta.$_createMessage);
  static RpcMeta? _defaultInstance;

  @$pb.TagNumber(1)
  RpcRequestMeta get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RpcRequestMeta value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RpcRequestMeta ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RpcResponseMeta get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RpcResponseMeta value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RpcResponseMeta ensureResponse() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get compressType => $_getIZ(2);
  @$pb.TagNumber(3)
  set compressType($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompressType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompressType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get correlationId => $_getI64(3);
  @$pb.TagNumber(4)
  set correlationId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCorrelationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCorrelationId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get attachmentSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set attachmentSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAttachmentSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearAttachmentSize() => $_clearField(5);

  @$pb.TagNumber(6)
  ChunkInfo get chunkInfo => $_getN(5);
  @$pb.TagNumber(6)
  set chunkInfo(ChunkInfo value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasChunkInfo() => $_has(5);
  @$pb.TagNumber(6)
  void clearChunkInfo() => $_clearField(6);
  @$pb.TagNumber(6)
  ChunkInfo ensureChunkInfo() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get authenticationData => $_getN(6);
  @$pb.TagNumber(7)
  set authenticationData($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAuthenticationData() => $_has(6);
  @$pb.TagNumber(7)
  void clearAuthenticationData() => $_clearField(7);

  @$pb.TagNumber(8)
  RpcNotifyMeta get notify => $_getN(7);
  @$pb.TagNumber(8)
  set notify(RpcNotifyMeta value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasNotify() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotify() => $_clearField(8);
  @$pb.TagNumber(8)
  RpcNotifyMeta ensureNotify() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.int get acceptCompressType => $_getIZ(8);
  @$pb.TagNumber(9)
  set acceptCompressType($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAcceptCompressType() => $_has(8);
  @$pb.TagNumber(9)
  void clearAcceptCompressType() => $_clearField(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
