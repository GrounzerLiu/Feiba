// This is a generated file - do not edit.
//
// Generated from UpdateClientInfoReqIdl.proto.

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

@$core.Deprecated('Use updateClientInfoReqIdlDescriptor instead')
const UpdateClientInfoReqIdl$json = {
  '1': 'UpdateClientInfoReqIdl',
  '2': [
    {'1': 'cuid', '3': 1, '4': 1, '5': 9, '10': 'cuid'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.UpdateClientInfoReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [UpdateClientInfoReqIdl_DataReq$json],
};

@$core.Deprecated('Use updateClientInfoReqIdlDescriptor instead')
const UpdateClientInfoReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'bduss', '3': 1, '4': 1, '5': 9, '10': 'bduss'},
    {'1': 'device', '3': 2, '4': 1, '5': 9, '10': 'device'},
    {'1': 'secretKey', '3': 3, '4': 1, '5': 12, '10': 'secretKey'},
    {'1': 'stoken', '3': 12, '4': 1, '5': 9, '10': 'stoken'},
  ],
};

/// Descriptor for `UpdateClientInfoReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClientInfoReqIdlDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVDbGllbnRJbmZvUmVxSWRsEhIKBGN1aWQYASABKAlSBGN1aWQSMwoEZGF0YRgCIA'
    'EoCzIfLlVwZGF0ZUNsaWVudEluZm9SZXFJZGwuRGF0YVJlcVIEZGF0YRptCgdEYXRhUmVxEhQK'
    'BWJkdXNzGAEgASgJUgViZHVzcxIWCgZkZXZpY2UYAiABKAlSBmRldmljZRIcCglzZWNyZXRLZX'
    'kYAyABKAxSCXNlY3JldEtleRIWCgZzdG9rZW4YDCABKAlSBnN0b2tlbg==');
