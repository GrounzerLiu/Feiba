// This is a generated file - do not edit.
//
// Generated from UpdateClientInfoResIdl.proto.

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

@$core.Deprecated('Use updateClientInfoResIdlDescriptor instead')
const UpdateClientInfoResIdl$json = {
  '1': 'UpdateClientInfoResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.UpdateClientInfoResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [UpdateClientInfoResIdl_DataRes$json],
};

@$core.Deprecated('Use updateClientInfoResIdlDescriptor instead')
const UpdateClientInfoResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'groupInfo',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.UpdateClientInfoResIdl.DataRes.GroupInfo',
      '10': 'groupInfo'
    },
    {
      '1': 'userInfo',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.UpdateClientInfoResIdl.DataRes.UserInfo',
      '10': 'userInfo'
    },
    {'1': 'isUserAvailable', '3': 6, '4': 1, '5': 3, '10': 'isUserAvailable'},
  ],
  '3': [
    UpdateClientInfoResIdl_DataRes_GroupInfo$json,
    UpdateClientInfoResIdl_DataRes_UserInfo$json
  ],
};

@$core.Deprecated('Use updateClientInfoResIdlDescriptor instead')
const UpdateClientInfoResIdl_DataRes_GroupInfo$json = {
  '1': 'GroupInfo',
  '2': [
    {'1': 'groupId', '3': 1, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'groupType', '3': 20, '4': 1, '5': 5, '10': 'groupType'},
    {'1': 'lastMsgId', '3': 21, '4': 1, '5': 3, '10': 'lastMsgId'},
  ],
};

@$core.Deprecated('Use updateClientInfoResIdlDescriptor instead')
const UpdateClientInfoResIdl_DataRes_UserInfo$json = {
  '1': 'UserInfo',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'userName', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'portrait', '3': 4, '4': 1, '5': 9, '10': 'portrait'},
  ],
};

/// Descriptor for `UpdateClientInfoResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClientInfoResIdlDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVDbGllbnRJbmZvUmVzSWRsEhwKBWVycm9yGAEgASgLMgYuRXJyb3JSBWVycm9yEj'
    'MKBGRhdGEYAiABKAsyHy5VcGRhdGVDbGllbnRJbmZvUmVzSWRsLkRhdGFSZXNSBGRhdGEagQMK'
    'B0RhdGFSZXMSRwoJZ3JvdXBJbmZvGAEgAygLMikuVXBkYXRlQ2xpZW50SW5mb1Jlc0lkbC5EYX'
    'RhUmVzLkdyb3VwSW5mb1IJZ3JvdXBJbmZvEkQKCHVzZXJJbmZvGAIgASgLMiguVXBkYXRlQ2xp'
    'ZW50SW5mb1Jlc0lkbC5EYXRhUmVzLlVzZXJJbmZvUgh1c2VySW5mbxIoCg9pc1VzZXJBdmFpbG'
    'FibGUYBiABKANSD2lzVXNlckF2YWlsYWJsZRphCglHcm91cEluZm8SGAoHZ3JvdXBJZBgBIAEo'
    'A1IHZ3JvdXBJZBIcCglncm91cFR5cGUYFCABKAVSCWdyb3VwVHlwZRIcCglsYXN0TXNnSWQYFS'
    'ABKANSCWxhc3RNc2dJZBpaCghVc2VySW5mbxIWCgZ1c2VySWQYASABKANSBnVzZXJJZBIaCgh1'
    'c2VyTmFtZRgCIAEoCVIIdXNlck5hbWUSGgoIcG9ydHJhaXQYBCABKAlSCHBvcnRyYWl0');
