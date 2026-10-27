// This is a generated file - do not edit.
//
// Generated from CommitPersonalMsgReqIdl.proto.

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

@$core.Deprecated('Use commitPersonalMsgReqIdlDescriptor instead')
const CommitPersonalMsgReqIdl$json = {
  '1': 'CommitPersonalMsgReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.CommitPersonalMsgReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [CommitPersonalMsgReqIdl_DataReq$json],
};

@$core.Deprecated('Use commitPersonalMsgReqIdlDescriptor instead')
const CommitPersonalMsgReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'toUid', '3': 2, '4': 1, '5': 3, '10': 'toUid'},
    {'1': 'msgType', '3': 3, '4': 1, '5': 5, '10': 'msgType'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'recordId', '3': 6, '4': 1, '5': 3, '10': 'recordId'},
  ],
};

/// Descriptor for `CommitPersonalMsgReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitPersonalMsgReqIdlDescriptor = $convert.base64Decode(
    'ChdDb21taXRQZXJzb25hbE1zZ1JlcUlkbBI0CgRkYXRhGAEgASgLMiAuQ29tbWl0UGVyc29uYW'
    'xNc2dSZXFJZGwuRGF0YVJlcVIEZGF0YRpvCgdEYXRhUmVxEhQKBXRvVWlkGAIgASgDUgV0b1Vp'
    'ZBIYCgdtc2dUeXBlGAMgASgFUgdtc2dUeXBlEhgKB2NvbnRlbnQYBCABKAlSB2NvbnRlbnQSGg'
    'oIcmVjb3JkSWQYBiABKANSCHJlY29yZElk');
