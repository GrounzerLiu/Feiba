// This is a generated file - do not edit.
//
// Generated from Lcm.proto.

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

@$core.Deprecated('Use commonDescriptor instead')
const Common$json = {
  '1': 'Common',
  '2': [
    {'1': 'cuid', '3': 1, '4': 1, '5': 9, '10': 'cuid'},
    {'1': 'device', '3': 2, '4': 1, '5': 9, '10': 'device'},
    {'1': 'os_version', '3': 3, '4': 1, '5': 9, '10': 'osVersion'},
    {'1': 'manufacture', '3': 4, '4': 1, '5': 9, '10': 'manufacture'},
    {'1': 'model_type', '3': 5, '4': 1, '5': 9, '10': 'modelType'},
    {'1': 'app_id', '3': 6, '4': 1, '5': 9, '10': 'appId'},
    {'1': 'app_version', '3': 7, '4': 1, '5': 9, '10': 'appVersion'},
    {'1': 'sdk_version', '3': 8, '4': 1, '5': 9, '10': 'sdkVersion'},
    {'1': 'network', '3': 9, '4': 1, '5': 9, '10': 'network'},
    {'1': 'rom_version', '3': 10, '4': 1, '5': 9, '10': 'romVersion'},
    {'1': 'user_key', '3': 11, '4': 1, '5': 9, '10': 'userKey'},
  ],
};

/// Descriptor for `Common`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonDescriptor = $convert.base64Decode(
    'CgZDb21tb24SEgoEY3VpZBgBIAEoCVIEY3VpZBIWCgZkZXZpY2UYAiABKAlSBmRldmljZRIdCg'
    'pvc192ZXJzaW9uGAMgASgJUglvc1ZlcnNpb24SIAoLbWFudWZhY3R1cmUYBCABKAlSC21hbnVm'
    'YWN0dXJlEh0KCm1vZGVsX3R5cGUYBSABKAlSCW1vZGVsVHlwZRIVCgZhcHBfaWQYBiABKAlSBW'
    'FwcElkEh8KC2FwcF92ZXJzaW9uGAcgASgJUgphcHBWZXJzaW9uEh8KC3Nka192ZXJzaW9uGAgg'
    'ASgJUgpzZGtWZXJzaW9uEhgKB25ldHdvcmsYCSABKAlSB25ldHdvcmsSHwoLcm9tX3ZlcnNpb2'
    '4YCiABKAlSCnJvbVZlcnNpb24SGQoIdXNlcl9rZXkYCyABKAlSB3VzZXJLZXk=');

@$core.Deprecated('Use lcmNotifyDescriptor instead')
const LcmNotify$json = {
  '1': 'LcmNotify',
  '2': [
    {'1': 'log_id', '3': 1, '4': 1, '5': 3, '10': 'logId'},
    {'1': 'action', '3': 2, '4': 1, '5': 5, '10': 'action'},
  ],
};

/// Descriptor for `LcmNotify`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lcmNotifyDescriptor = $convert.base64Decode(
    'CglMY21Ob3RpZnkSFQoGbG9nX2lkGAEgASgDUgVsb2dJZBIWCgZhY3Rpb24YAiABKAVSBmFjdG'
    'lvbg==');

@$core.Deprecated('Use lcmRequestDescriptor instead')
const LcmRequest$json = {
  '1': 'LcmRequest',
  '2': [
    {'1': 'log_id', '3': 1, '4': 1, '5': 3, '10': 'logId'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
    {'1': 'common', '3': 3, '4': 1, '5': 11, '6': '.Common', '10': 'common'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'action', '3': 5, '4': 1, '5': 5, '10': 'action'},
    {'1': 'start_type', '3': 6, '4': 1, '5': 5, '10': 'startType'},
    {'1': 'conn_type', '3': 7, '4': 1, '5': 5, '10': 'connType'},
  ],
};

/// Descriptor for `LcmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lcmRequestDescriptor = $convert.base64Decode(
    'CgpMY21SZXF1ZXN0EhUKBmxvZ19pZBgBIAEoA1IFbG9nSWQSFAoFdG9rZW4YAiABKAlSBXRva2'
    'VuEh8KBmNvbW1vbhgDIAEoCzIHLkNvbW1vblIGY29tbW9uEhwKCXRpbWVzdGFtcBgEIAEoA1IJ'
    'dGltZXN0YW1wEhYKBmFjdGlvbhgFIAEoBVIGYWN0aW9uEh0KCnN0YXJ0X3R5cGUYBiABKAVSCX'
    'N0YXJ0VHlwZRIbCgljb25uX3R5cGUYByABKAVSCGNvbm5UeXBl');

@$core.Deprecated('Use lcmResponseDescriptor instead')
const LcmResponse$json = {
  '1': 'LcmResponse',
  '2': [
    {'1': 'log_id', '3': 1, '4': 1, '5': 3, '10': 'logId'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 5, '10': 'errorCode'},
    {'1': 'error_msg', '3': 3, '4': 1, '5': 9, '10': 'errorMsg'},
    {'1': 'next_interval_ms', '3': 4, '4': 1, '5': 3, '10': 'nextIntervalMs'},
    {'1': 'server_info', '3': 5, '4': 1, '5': 9, '10': 'serverInfo'},
  ],
};

/// Descriptor for `LcmResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lcmResponseDescriptor = $convert.base64Decode(
    'CgtMY21SZXNwb25zZRIVCgZsb2dfaWQYASABKANSBWxvZ0lkEh0KCmVycm9yX2NvZGUYAiABKA'
    'VSCWVycm9yQ29kZRIbCgllcnJvcl9tc2cYAyABKAlSCGVycm9yTXNnEigKEG5leHRfaW50ZXJ2'
    'YWxfbXMYBCABKANSDm5leHRJbnRlcnZhbE1zEh8KC3NlcnZlcl9pbmZvGAUgASgJUgpzZXJ2ZX'
    'JJbmZv');

@$core.Deprecated('Use rpcDataDescriptor instead')
const RpcData$json = {
  '1': 'RpcData',
  '2': [
    {
      '1': 'lcm_request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.LcmRequest',
      '10': 'lcmRequest'
    },
    {
      '1': 'lcm_response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.LcmResponse',
      '10': 'lcmResponse'
    },
    {
      '1': 'lcm_notify',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.LcmNotify',
      '10': 'lcmNotify'
    },
  ],
};

/// Descriptor for `RpcData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcDataDescriptor = $convert.base64Decode(
    'CgdScGNEYXRhEiwKC2xjbV9yZXF1ZXN0GAEgASgLMgsuTGNtUmVxdWVzdFIKbGNtUmVxdWVzdB'
    'IvCgxsY21fcmVzcG9uc2UYAiABKAsyDC5MY21SZXNwb25zZVILbGNtUmVzcG9uc2USKQoKbGNt'
    'X25vdGlmeRgDIAEoCzIKLkxjbU5vdGlmeVIJbGNtTm90aWZ5');
