// This is a generated file - do not edit.
//
// Generated from GetUserByTiebaUidReqIdl.proto.

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

@$core.Deprecated('Use getUserByTiebaUidReqIdlDescriptor instead')
const GetUserByTiebaUidReqIdl$json = {
  '1': 'GetUserByTiebaUidReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetUserByTiebaUidReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [GetUserByTiebaUidReqIdl_DataReq$json],
};

@$core.Deprecated('Use getUserByTiebaUidReqIdlDescriptor instead')
const GetUserByTiebaUidReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'common', '3': 1, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'tieba_uid', '3': 2, '4': 1, '5': 9, '10': 'tiebaUid'},
  ],
};

/// Descriptor for `GetUserByTiebaUidReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByTiebaUidReqIdlDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyQnlUaWViYVVpZFJlcUlkbBI0CgRkYXRhGAEgASgLMiAuR2V0VXNlckJ5VGllYm'
    'FVaWRSZXFJZGwuRGF0YVJlcVIEZGF0YRpKCgdEYXRhUmVxEiIKBmNvbW1vbhgBIAEoCzIKLkNv'
    'bW1vblJlcVIGY29tbW9uEhsKCXRpZWJhX3VpZBgCIAEoCVIIdGllYmFVaWQ=');
