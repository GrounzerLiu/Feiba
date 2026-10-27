// This is a generated file - do not edit.
//
// Generated from CommitPersonalMsgResIdl.proto.

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

@$core.Deprecated('Use commitPersonalMsgResIdlDescriptor instead')
const CommitPersonalMsgResIdl$json = {
  '1': 'CommitPersonalMsgResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.CommitPersonalMsgResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [CommitPersonalMsgResIdl_DataRes$json],
};

@$core.Deprecated('Use commitPersonalMsgResIdlDescriptor instead')
const CommitPersonalMsgResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {'1': 'msgId', '3': 1, '4': 1, '5': 3, '10': 'msgId'},
    {'1': 'groupId', '3': 2, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'recordId', '3': 3, '4': 1, '5': 3, '10': 'recordId'},
    {'1': 'toUid', '3': 4, '4': 1, '5': 3, '10': 'toUid'},
    {'1': 'toUserType', '3': 5, '4': 1, '5': 5, '10': 'toUserType'},
    {
      '1': 'blockInfo',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.CommitPersonalMsgResIdl.DataRes.BlockInfo',
      '10': 'blockInfo'
    },
  ],
  '3': [CommitPersonalMsgResIdl_DataRes_BlockInfo$json],
};

@$core.Deprecated('Use commitPersonalMsgResIdlDescriptor instead')
const CommitPersonalMsgResIdl_DataRes_BlockInfo$json = {
  '1': 'BlockInfo',
  '2': [
    {'1': 'blockErrno', '3': 1, '4': 1, '5': 5, '10': 'blockErrno'},
    {'1': 'blockErrmsg', '3': 2, '4': 1, '5': 9, '10': 'blockErrmsg'},
  ],
};

/// Descriptor for `CommitPersonalMsgResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitPersonalMsgResIdlDescriptor = $convert.base64Decode(
    'ChdDb21taXRQZXJzb25hbE1zZ1Jlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvch'
    'I0CgRkYXRhGAIgASgLMiAuQ29tbWl0UGVyc29uYWxNc2dSZXNJZGwuRGF0YVJlc1IEZGF0YRqk'
    'AgoHRGF0YVJlcxIUCgVtc2dJZBgBIAEoA1IFbXNnSWQSGAoHZ3JvdXBJZBgCIAEoA1IHZ3JvdX'
    'BJZBIaCghyZWNvcmRJZBgDIAEoA1IIcmVjb3JkSWQSFAoFdG9VaWQYBCABKANSBXRvVWlkEh4K'
    'CnRvVXNlclR5cGUYBSABKAVSCnRvVXNlclR5cGUSSAoJYmxvY2tJbmZvGAYgASgLMiouQ29tbW'
    'l0UGVyc29uYWxNc2dSZXNJZGwuRGF0YVJlcy5CbG9ja0luZm9SCWJsb2NrSW5mbxpNCglCbG9j'
    'a0luZm8SHgoKYmxvY2tFcnJubxgBIAEoBVIKYmxvY2tFcnJubxIgCgtibG9ja0Vycm1zZxgCIA'
    'EoCVILYmxvY2tFcnJtc2c=');
