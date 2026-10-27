/// BLCP packet model: RPC metadata, control/business bodies and LCP framing.
///
/// Ported from `aiotieba/core/blcp/packet.py` (Unlicense).
///
/// Wire format of one LCP frame:
///
/// ```text
/// "lcp" 0x01 | total_length (4B BE) | header_length (4B BE) | header | body
/// ```
///
/// `header` is a serialized `RpcMeta` protobuf. The body is a serialized
/// `RpcData` protobuf for the LCM control plane and UTF-8 JSON for every other
/// service. Both bodies may be gzip compressed, as declared by the frame header.
library;

import 'dart:convert';
import 'dart:io' show gzip;
import 'dart:math';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';

import '../../generated/generated.dart' as pb;
import 'enums.dart';
import 'exceptions.dart';

/// Frame prefix; the last byte is the protocol version.
const List<int> lcpFramePrefix = <int>[0x6C, 0x63, 0x70, 0x01];

/// Largest accepted frame payload (defensive limit for the stream parser).
const int maxLcpFrameSize = 16 * 1024 * 1024;

final Random _random = Random.secure();

/// Returns a random 63-bit correlation id, mirroring CPython's
/// `random.randint(0, LONG_MAX)`.
int randomCorrelationId() {
  final high = _random.nextInt(1 << 30);
  final low = _random.nextInt(1 << 30);
  return (high << 32) | (low << 2) | _random.nextInt(4);
}

/// A link-tracing event attached to RPC metadata.
class RpcEvent {
  const RpcEvent(this.event, this.timestampMs);

  /// Creates an event stamped with the current time.
  factory RpcEvent.now(String event) =>
      RpcEvent(event, DateTime.now().millisecondsSinceEpoch);

  final String event;
  final int timestampMs;

  pb.EventTimestamp toProto() => pb.EventTimestamp()
    ..event = event
    ..timestampMs = Int64(timestampMs);

  static RpcEvent fromProto(pb.EventTimestamp proto) =>
      RpcEvent(proto.event, proto.timestampMs.toInt());
}

/// RPC request metadata.
class RpcRequestMeta {
  const RpcRequestMeta({
    required this.serviceId,
    required this.methodId,
    this.logId = 0,
    this.needCommon = 1,
    this.events = const <RpcEvent>[],
  });

  final int serviceId;
  final int methodId;
  final int logId;
  final int needCommon;
  final List<RpcEvent> events;

  pb.RpcRequestMeta toProto() {
    final proto = pb.RpcRequestMeta()
      ..serviceId = Int64(serviceId)
      ..methodId = Int64(methodId)
      ..logId = Int64(logId)
      ..needCommon = needCommon;
    for (final event in events) {
      proto.eventList.add(event.toProto());
    }
    return proto;
  }

  static RpcRequestMeta fromProto(pb.RpcRequestMeta proto) => RpcRequestMeta(
    serviceId: proto.serviceId.toInt(),
    methodId: proto.methodId.toInt(),
    logId: proto.logId.toInt(),
    needCommon: proto.needCommon,
    events: proto.eventList.map(RpcEvent.fromProto).toList(growable: false),
  );
}

/// RPC response metadata.
class RpcResponseMeta {
  const RpcResponseMeta({
    this.serviceId = 0,
    this.methodId = 0,
    this.logId = 0,
    this.errorCode = 0,
    this.errorText = '',
    this.events = const <RpcEvent>[],
  });

  final int serviceId;
  final int methodId;
  final int logId;
  final int errorCode;
  final String errorText;
  final List<RpcEvent> events;

  pb.RpcResponseMeta toProto() {
    final proto = pb.RpcResponseMeta()
      ..serviceId = Int64(serviceId)
      ..methodId = Int64(methodId)
      ..logId = Int64(logId)
      ..errorCode = errorCode
      ..errorText = errorText;
    for (final event in events) {
      proto.eventList.add(event.toProto());
    }
    return proto;
  }

  static RpcResponseMeta fromProto(pb.RpcResponseMeta proto) => RpcResponseMeta(
    serviceId: proto.serviceId.toInt(),
    methodId: proto.methodId.toInt(),
    logId: proto.logId.toInt(),
    errorCode: proto.errorCode,
    errorText: proto.errorText,
    events: proto.eventList.map(RpcEvent.fromProto).toList(growable: false),
  );
}

/// RPC server-push metadata.
class RpcNotifyMeta {
  const RpcNotifyMeta({
    this.serviceId = 0,
    this.methodId = 0,
    this.logId = 0,
    this.events = const <RpcEvent>[],
  });

  final int serviceId;
  final int methodId;
  final int logId;
  final List<RpcEvent> events;

  pb.RpcNotifyMeta toProto() {
    final proto = pb.RpcNotifyMeta()
      ..serviceId = Int64(serviceId)
      ..methodId = Int64(methodId)
      ..logId = Int64(logId);
    for (final event in events) {
      proto.eventList.add(event.toProto());
    }
    return proto;
  }

  static RpcNotifyMeta fromProto(pb.RpcNotifyMeta proto) => RpcNotifyMeta(
    serviceId: proto.serviceId.toInt(),
    methodId: proto.methodId.toInt(),
    logId: proto.logId.toInt(),
    events: proto.eventList.map(RpcEvent.fromProto).toList(growable: false),
  );
}

/// Frame header describing one RPC exchange.
class RpcMeta {
  const RpcMeta({
    this.correlationId = 0,
    this.request,
    this.response,
    this.notify,
    this.compressType = BlcpCompressType.none,
    this.acceptCompressType = BlcpCompressType.gzip,
  });

  final int correlationId;
  final RpcRequestMeta? request;
  final RpcResponseMeta? response;
  final RpcNotifyMeta? notify;
  final BlcpCompressType compressType;
  final BlcpCompressType acceptCompressType;

  bool get isNotify => notify != null;

  int get serviceId =>
      response?.serviceId ?? notify?.serviceId ?? request?.serviceId ?? 0;

  int get methodId =>
      response?.methodId ?? notify?.methodId ?? request?.methodId ?? 0;

  int get logId => response?.logId ?? notify?.logId ?? request?.logId ?? 0;

  pb.RpcMeta toProto() {
    final proto = pb.RpcMeta()
      ..correlationId = Int64(correlationId)
      ..compressType = compressType.value
      ..acceptCompressType = acceptCompressType.value;
    if (request != null) {
      proto.request = request!.toProto();
    }
    if (response != null) {
      proto.response = response!.toProto();
    }
    if (notify != null) {
      proto.notify = notify!.toProto();
    }
    return proto;
  }

  /// Decodes a frame header.
  ///
  /// Responses and server pushes are the two shapes a client receives; a
  /// response is assumed when no oneof branch is present, mirroring aiotieba.
  static RpcMeta fromProto(pb.RpcMeta proto) {
    final compressType = BlcpCompressType.fromValue(proto.compressType);
    final acceptCompressType = proto.acceptCompressType == 0
        ? BlcpCompressType.gzip
        : BlcpCompressType.fromValue(proto.acceptCompressType);
    if (proto.hasNotify()) {
      return RpcMeta(
        correlationId: proto.correlationId.toInt(),
        notify: RpcNotifyMeta.fromProto(proto.notify),
        compressType: compressType,
        acceptCompressType: acceptCompressType,
      );
    }
    if (proto.hasResponse()) {
      return RpcMeta(
        correlationId: proto.correlationId.toInt(),
        response: RpcResponseMeta.fromProto(proto.response),
        compressType: compressType,
        acceptCompressType: acceptCompressType,
      );
    }
    if (proto.hasRequest()) {
      return RpcMeta(
        correlationId: proto.correlationId.toInt(),
        request: RpcRequestMeta.fromProto(proto.request),
        compressType: compressType,
        acceptCompressType: acceptCompressType,
      );
    }
    return RpcMeta(
      correlationId: proto.correlationId.toInt(),
      response: RpcResponseMeta(),
      compressType: compressType,
      acceptCompressType: acceptCompressType,
    );
  }

  Uint8List encode() => toProto().writeToBuffer();

  /// Decodes a frame header from serialized bytes.
  static RpcMeta decode(Uint8List data) =>
      RpcMeta.fromProto(pb.RpcMeta.fromBuffer(data));
}

/// Serialized message body of an LCP frame.
abstract class BlcpBody {
  const BlcpBody();

  /// Serializes this body.
  Uint8List encode();

  /// Picks the body implementation declared by [meta] and decodes [data].
  static BlcpBody decodeFor(RpcMeta meta, Uint8List data) {
    var payload = data;
    if (meta.compressType == BlcpCompressType.gzip) {
      payload = Uint8List.fromList(gzip.decode(payload));
    }
    if (meta.serviceId == BlcpServiceId.lcm.value) {
      return LcmBody.decode(payload);
    }
    return JsonBody.decode(payload);
  }
}

/// LCM control-plane body, encoded as a `RpcData` protobuf.
class LcmBody extends BlcpBody {
  const LcmBody(this.data);

  final pb.RpcData data;

  /// Builds an LCM login request.
  factory LcmBody.login({
    required int logId,
    required String token,
    required int timestamp,
    required String cuid,
    required int appId,
    required String appVersion,
    required String sdkVersion,
    String network = 'wifi',
    String deviceType = 'android',
    int startType = -1,
    int connType = 1,
  }) {
    final rpcData = pb.RpcData();
    final request = rpcData.ensureLcmRequest()
      ..logId = Int64(logId)
      ..token = token
      ..timestamp = Int64(timestamp)
      ..startType = startType
      ..connType = connType;
    request.ensureCommon()
      ..cuid = cuid
      ..device = deviceType
      ..appId = '$appId'
      ..appVersion = appVersion
      ..sdkVersion = sdkVersion
      ..network = network;
    return LcmBody(rpcData);
  }

  /// Builds an LCM heartbeat request.
  factory LcmBody.heartbeat({required int logId, required int timestamp}) {
    final rpcData = pb.RpcData();
    rpcData.ensureLcmRequest()
      ..logId = Int64(logId)
      ..timestamp = Int64(timestamp);
    return LcmBody(rpcData);
  }

  /// Builds an LCM logout request (identical wire shape to a heartbeat).
  factory LcmBody.logout({required int logId, required int timestamp}) =
      LcmBody.heartbeat;

  pb.LcmResponse get response => data.lcmResponse;

  /// Server-requested interval before the next heartbeat, in milliseconds.
  int get nextIntervalMs => data.lcmResponse.nextIntervalMs.toInt();

  @override
  Uint8List encode() => data.writeToBuffer();

  static LcmBody decode(Uint8List data) => LcmBody(pb.RpcData.fromBuffer(data));
}

/// Business-plane body, encoded as UTF-8 JSON.
class JsonBody extends BlcpBody {
  const JsonBody(this.data);

  final Map<String, dynamic> data;

  @override
  Uint8List encode() => Uint8List.fromList(utf8.encode(jsonEncode(data)));

  static JsonBody decode(Uint8List data) {
    final decoded = jsonDecode(utf8.decode(data, allowMalformed: true));
    if (decoded is Map<String, dynamic>) return JsonBody(decoded);
    if (decoded is Map) return JsonBody(decoded.cast<String, dynamic>());
    throw const BlcpProtocolException('expected a JSON object body');
  }
}

/// Raw byte body, used by requests that carry no content.
class BytesBody extends BlcpBody {
  const BytesBody([this.data = const <int>[]]);

  final List<int> data;

  @override
  Uint8List encode() => Uint8List.fromList(data);

  static BytesBody decode(Uint8List data) => BytesBody(data);
}

/// One LCP frame: a serialized [RpcMeta] header and a serialized body.
class LcpFrame {
  const LcpFrame(this.header, this.body);

  final Uint8List header;
  final Uint8List body;

  Uint8List encode() {
    final totalLength = header.length + body.length;
    final frame = Uint8List(12 + totalLength);
    frame.setRange(0, 4, lcpFramePrefix);
    _writeUint32(frame, 4, totalLength);
    _writeUint32(frame, 8, header.length);
    frame.setRange(12, 12 + header.length, header);
    frame.setRange(12 + header.length, frame.length, body);
    return frame;
  }

  /// Decodes a complete frame (used by tests; the stream parser decodes
  /// incrementally).
  static LcpFrame decode(Uint8List frame) {
    if (frame.length < 12) {
      throw const BlcpProtocolException('LCP frame is too short');
    }
    for (var i = 0; i < lcpFramePrefix.length; i++) {
      if (frame[i] != lcpFramePrefix[i]) {
        throw const BlcpProtocolException('missing LCP frame prefix');
      }
    }
    final totalLength = _readUint32(frame, 4);
    final headerLength = _readUint32(frame, 8);
    if (headerLength > totalLength || 12 + totalLength != frame.length) {
      throw BlcpProtocolException(
        'invalid LCP frame lengths (header=$headerLength total=$totalLength '
        'frame=${frame.length})',
      );
    }
    return LcpFrame(
      Uint8List.fromList(Uint8List.sublistView(frame, 12, 12 + headerLength)),
      Uint8List.fromList(
        Uint8List.sublistView(frame, 12 + headerLength, frame.length),
      ),
    );
  }
}

/// Incremental LCP frame parser for a streaming socket.
///
/// The parser skips leading garbage until it finds [lcpFramePrefix], exactly
/// like aiotieba's `readuntil`.
class LcpFrameParser {
  Uint8List _buffer = Uint8List(8192);
  int _start = 0;
  int _end = 0;

  int get _length => _end - _start;

  /// Feeds a chunk read from the socket and returns every complete frame.
  List<LcpFrame> feed(Uint8List chunk) {
    _append(chunk);
    final frames = <LcpFrame>[];
    while (true) {
      final prefixIndex = _indexOfPrefix();
      if (prefixIndex < 0) {
        // Keep at most three bytes, a prefix may span two chunks.
        if (_length > lcpFramePrefix.length - 1) {
          _start = _end - (lcpFramePrefix.length - 1);
        }
        break;
      }
      if (prefixIndex > _start) {
        _start = prefixIndex;
      }
      if (_length < 12) break;

      final totalLength = _readUint32(_buffer, _start + 4);
      final headerLength = _readUint32(_buffer, _start + 8);
      if (headerLength > totalLength || totalLength > maxLcpFrameSize) {
        throw BlcpProtocolException(
          'invalid LCP frame lengths (header=$headerLength '
          'total=$totalLength)',
        );
      }
      final frameLength = 12 + totalLength;
      if (_length < frameLength) break;

      final header = Uint8List.fromList(
        Uint8List.sublistView(_buffer, _start + 12, _start + 12 + headerLength),
      );
      final body = Uint8List.fromList(
        Uint8List.sublistView(
          _buffer,
          _start + 12 + headerLength,
          _start + frameLength,
        ),
      );
      frames.add(LcpFrame(header, body));
      _start += frameLength;
      if (_start == _end) {
        _start = 0;
        _end = 0;
      }
    }
    _compact();
    return frames;
  }

  int _indexOfPrefix() {
    final last = _end - lcpFramePrefix.length;
    for (var i = _start; i <= last; i++) {
      if (_buffer[i] != lcpFramePrefix[0]) continue;
      if (_buffer[i + 1] != lcpFramePrefix[1]) continue;
      if (_buffer[i + 2] != lcpFramePrefix[2]) continue;
      if (_buffer[i + 3] != lcpFramePrefix[3]) continue;
      return i;
    }
    return -1;
  }

  void _append(Uint8List chunk) {
    final required = _end + chunk.length;
    if (required > _buffer.length) {
      var capacity = _buffer.length;
      while (capacity < required) {
        capacity *= 2;
      }
      _buffer = Uint8List(capacity)..setRange(0, _end, _buffer);
    }
    _buffer.setRange(_end, required, chunk);
    _end = required;
  }

  void _compact() {
    if (_start == 0) return;
    if (_start != _end && _start < _buffer.length ~/ 2) return;
    final length = _length;
    final compacted = Uint8List(_buffer.length)
      ..setRange(0, length, _buffer, _start);
    _buffer = compacted;
    _start = 0;
    _end = length;
  }
}

/// A decoded LCP packet.
class BlcpPacket {
  const BlcpPacket(this.meta, this.body);

  final RpcMeta meta;
  final BlcpBody body;

  LcpFrame toFrame() => LcpFrame(meta.encode(), body.encode());

  Uint8List toBytes() => toFrame().encode();

  /// Decodes a frame into a request, response or notify packet.
  static BlcpPacket fromFrame(LcpFrame frame) {
    final meta = RpcMeta.decode(frame.header);
    final body = BlcpBody.decodeFor(meta, frame.body);
    if (meta.isNotify) return BlcpNotify(meta, body);
    return BlcpResponse(meta, body);
  }
}

/// An outgoing request packet.
class BlcpRequest extends BlcpPacket {
  const BlcpRequest(super.meta, super.body);

  /// Builds a request, generating a correlation id and a trace event when not
  /// provided.
  factory BlcpRequest.create(
    int serviceId,
    int methodId, {
    BlcpBody? body,
    int? correlationId,
    int needCommon = 1,
    String? event = 'CLCPReqBegin',
  }) {
    final id = correlationId ?? randomCorrelationId();
    final events = event == null
        ? const <RpcEvent>[]
        : <RpcEvent>[RpcEvent.now(event)];
    final request = RpcRequestMeta(
      serviceId: serviceId,
      methodId: methodId,
      logId: id,
      needCommon: needCommon,
      events: events,
    );
    return BlcpRequest(
      RpcMeta(correlationId: id, request: request),
      body ?? const BytesBody(),
    );
  }

  int get correlationId => meta.correlationId;

  int get serviceId => meta.request!.serviceId;

  int get methodId => meta.request!.methodId;
}

/// A response packet.
class BlcpResponse extends BlcpPacket {
  const BlcpResponse(super.meta, super.body);

  int get correlationId => meta.correlationId;

  int get serviceId => meta.response!.serviceId;

  int get methodId => meta.response!.methodId;

  int get errorCode => meta.response!.errorCode;

  String get errorText => meta.response!.errorText;

  /// Whether the RPC layer and (for LCM frames) the control plane succeeded.
  bool get ok {
    if (errorCode != 0) return false;
    final lcmResponse = lcm;
    return lcmResponse == null || lcmResponse.errorCode == 0;
  }

  /// LCM control-plane response, or `null` for business-plane frames.
  pb.LcmResponse? get lcm {
    final current = body;
    if (current is LcmBody) return current.data.lcmResponse;
    return null;
  }

  /// Business-plane payload.
  ///
  /// Throws [BlcpProtocolException] when the body is not JSON.
  Map<String, dynamic> get payload {
    final current = body;
    if (current is JsonBody) return current.data;
    throw BlcpProtocolException(
      'expected a JSON body, got ${current.runtimeType}',
    );
  }

  /// Business-plane payload, or `null` when the body is not JSON.
  Map<String, dynamic>? get payloadOrNull {
    final current = body;
    return current is JsonBody ? current.data : null;
  }

  /// Convenience helper returning the RPC error as an exception subject.
  String describeError() => 'code=$errorCode text=$errorText';
}

/// A server-pushed packet.
class BlcpNotify extends BlcpPacket {
  const BlcpNotify(super.meta, super.body);

  int get serviceId => meta.notify!.serviceId;

  int get methodId => meta.notify!.methodId;

  int get logId => meta.notify!.logId;

  /// Push payload.
  ///
  /// Throws [BlcpProtocolException] when the body is not JSON.
  Map<String, dynamic> get payload {
    final current = body;
    if (current is JsonBody) return current.data;
    throw BlcpProtocolException(
      'expected a JSON body, got ${current.runtimeType}',
    );
  }
}

int _readUint32(Uint8List data, int offset) =>
    (data[offset] << 24) |
    (data[offset + 1] << 16) |
    (data[offset + 2] << 8) |
    data[offset + 3];

void _writeUint32(Uint8List data, int offset, int value) {
  data[offset] = (value >> 24) & 0xFF;
  data[offset + 1] = (value >> 16) & 0xFF;
  data[offset + 2] = (value >> 8) & 0xFF;
  data[offset + 3] = value & 0xFF;
}
