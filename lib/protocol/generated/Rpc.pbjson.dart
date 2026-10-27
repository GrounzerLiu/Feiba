// This is a generated file - do not edit.
//
// Generated from Rpc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use chunkInfoDescriptor instead')
const ChunkInfo$json = {
  '1': 'ChunkInfo',
  '2': [
    {'1': 'stream_id', '3': 1, '4': 1, '5': 3, '10': 'streamId'},
    {'1': 'chunk_id', '3': 2, '4': 1, '5': 3, '10': 'chunkId'},
  ],
};

/// Descriptor for `ChunkInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chunkInfoDescriptor = $convert.base64Decode(
    'CglDaHVua0luZm8SGwoJc3RyZWFtX2lkGAEgASgDUghzdHJlYW1JZBIZCghjaHVua19pZBgCIA'
    'EoA1IHY2h1bmtJZA==');

@$core.Deprecated('Use eventTimestampDescriptor instead')
const EventTimestamp$json = {
  '1': 'EventTimestamp',
  '2': [
    {'1': 'event', '3': 1, '4': 1, '5': 9, '10': 'event'},
    {'1': 'timestamp_ms', '3': 2, '4': 1, '5': 3, '10': 'timestampMs'},
  ],
};

/// Descriptor for `EventTimestamp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventTimestampDescriptor = $convert.base64Decode(
    'Cg5FdmVudFRpbWVzdGFtcBIUCgVldmVudBgBIAEoCVIFZXZlbnQSIQoMdGltZXN0YW1wX21zGA'
    'IgASgDUgt0aW1lc3RhbXBNcw==');

@$core.Deprecated('Use rpcNotifyMetaDescriptor instead')
const RpcNotifyMeta$json = {
  '1': 'RpcNotifyMeta',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 3, '10': 'serviceId'},
    {'1': 'method_id', '3': 2, '4': 1, '5': 3, '10': 'methodId'},
    {'1': 'log_id', '3': 3, '4': 1, '5': 3, '10': 'logId'},
    {
      '1': 'event_list',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.EventTimestamp',
      '10': 'eventList'
    },
  ],
};

/// Descriptor for `RpcNotifyMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcNotifyMetaDescriptor = $convert.base64Decode(
    'Cg1ScGNOb3RpZnlNZXRhEh0KCnNlcnZpY2VfaWQYASABKANSCXNlcnZpY2VJZBIbCgltZXRob2'
    'RfaWQYAiABKANSCG1ldGhvZElkEhUKBmxvZ19pZBgDIAEoA1IFbG9nSWQSLgoKZXZlbnRfbGlz'
    'dBgEIAMoCzIPLkV2ZW50VGltZXN0YW1wUglldmVudExpc3Q=');

@$core.Deprecated('Use rpcRequestMetaDescriptor instead')
const RpcRequestMeta$json = {
  '1': 'RpcRequestMeta',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 3, '10': 'serviceId'},
    {'1': 'method_id', '3': 2, '4': 1, '5': 3, '10': 'methodId'},
    {'1': 'log_id', '3': 3, '4': 1, '5': 3, '10': 'logId'},
    {'1': 'need_common', '3': 4, '4': 1, '5': 5, '10': 'needCommon'},
    {
      '1': 'event_list',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.EventTimestamp',
      '10': 'eventList'
    },
  ],
};

/// Descriptor for `RpcRequestMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcRequestMetaDescriptor = $convert.base64Decode(
    'Cg5ScGNSZXF1ZXN0TWV0YRIdCgpzZXJ2aWNlX2lkGAEgASgDUglzZXJ2aWNlSWQSGwoJbWV0aG'
    '9kX2lkGAIgASgDUghtZXRob2RJZBIVCgZsb2dfaWQYAyABKANSBWxvZ0lkEh8KC25lZWRfY29t'
    'bW9uGAQgASgFUgpuZWVkQ29tbW9uEi4KCmV2ZW50X2xpc3QYBSADKAsyDy5FdmVudFRpbWVzdG'
    'FtcFIJZXZlbnRMaXN0');

@$core.Deprecated('Use rpcResponseMetaDescriptor instead')
const RpcResponseMeta$json = {
  '1': 'RpcResponseMeta',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 3, '10': 'serviceId'},
    {'1': 'method_id', '3': 2, '4': 1, '5': 3, '10': 'methodId'},
    {'1': 'log_id', '3': 3, '4': 1, '5': 3, '10': 'logId'},
    {'1': 'error_code', '3': 4, '4': 1, '5': 5, '10': 'errorCode'},
    {'1': 'error_text', '3': 5, '4': 1, '5': 9, '10': 'errorText'},
    {
      '1': 'event_list',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.EventTimestamp',
      '10': 'eventList'
    },
  ],
};

/// Descriptor for `RpcResponseMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcResponseMetaDescriptor = $convert.base64Decode(
    'Cg9ScGNSZXNwb25zZU1ldGESHQoKc2VydmljZV9pZBgBIAEoA1IJc2VydmljZUlkEhsKCW1ldG'
    'hvZF9pZBgCIAEoA1IIbWV0aG9kSWQSFQoGbG9nX2lkGAMgASgDUgVsb2dJZBIdCgplcnJvcl9j'
    'b2RlGAQgASgFUgllcnJvckNvZGUSHQoKZXJyb3JfdGV4dBgFIAEoCVIJZXJyb3JUZXh0Ei4KCm'
    'V2ZW50X2xpc3QYBiADKAsyDy5FdmVudFRpbWVzdGFtcFIJZXZlbnRMaXN0');

@$core.Deprecated('Use rpcMetaDescriptor instead')
const RpcMeta$json = {
  '1': 'RpcMeta',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.RpcRequestMeta',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.RpcResponseMeta',
      '10': 'response'
    },
    {
      '1': 'compress_type',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'compressType',
      '17': true
    },
    {'1': 'correlation_id', '3': 4, '4': 1, '5': 3, '10': 'correlationId'},
    {'1': 'attachment_size', '3': 5, '4': 1, '5': 5, '10': 'attachmentSize'},
    {
      '1': 'chunk_info',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.ChunkInfo',
      '10': 'chunkInfo'
    },
    {
      '1': 'authentication_data',
      '3': 7,
      '4': 1,
      '5': 12,
      '10': 'authenticationData'
    },
    {
      '1': 'notify',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.RpcNotifyMeta',
      '10': 'notify'
    },
    {
      '1': 'accept_compress_type',
      '3': 9,
      '4': 1,
      '5': 5,
      '10': 'acceptCompressType'
    },
  ],
  '8': [
    {'1': '_compress_type'},
  ],
};

/// Descriptor for `RpcMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcMetaDescriptor = $convert.base64Decode(
    'CgdScGNNZXRhEikKB3JlcXVlc3QYASABKAsyDy5ScGNSZXF1ZXN0TWV0YVIHcmVxdWVzdBIsCg'
    'hyZXNwb25zZRgCIAEoCzIQLlJwY1Jlc3BvbnNlTWV0YVIIcmVzcG9uc2USKAoNY29tcHJlc3Nf'
    'dHlwZRgDIAEoBUgAUgxjb21wcmVzc1R5cGWIAQESJQoOY29ycmVsYXRpb25faWQYBCABKANSDW'
    'NvcnJlbGF0aW9uSWQSJwoPYXR0YWNobWVudF9zaXplGAUgASgFUg5hdHRhY2htZW50U2l6ZRIp'
    'CgpjaHVua19pbmZvGAYgASgLMgouQ2h1bmtJbmZvUgljaHVua0luZm8SLwoTYXV0aGVudGljYX'
    'Rpb25fZGF0YRgHIAEoDFISYXV0aGVudGljYXRpb25EYXRhEiYKBm5vdGlmeRgIIAEoCzIOLlJw'
    'Y05vdGlmeU1ldGFSBm5vdGlmeRIwChRhY2NlcHRfY29tcHJlc3NfdHlwZRgJIAEoBVISYWNjZX'
    'B0Q29tcHJlc3NUeXBlQhAKDl9jb21wcmVzc190eXBl');
