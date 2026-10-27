// This is a generated file - do not edit.
//
// Generated from SetUserBlackReqIdl.proto.

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

@$core.Deprecated('Use setUserBlackReqIdlDescriptor instead')
const SetUserBlackReqIdl$json = {
  '1': 'SetUserBlackReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.SetUserBlackReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [SetUserBlackReqIdl_DataReq$json],
};

@$core.Deprecated('Use setUserBlackReqIdlDescriptor instead')
const SetUserBlackReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'common', '3': 1, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'black_uid', '3': 2, '4': 1, '5': 3, '10': 'blackUid'},
    {
      '1': 'perm_list',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.SetUserBlackReqIdl.DataReq.PermissionList',
      '10': 'permList'
    },
  ],
  '3': [SetUserBlackReqIdl_DataReq_PermissionList$json],
};

@$core.Deprecated('Use setUserBlackReqIdlDescriptor instead')
const SetUserBlackReqIdl_DataReq_PermissionList$json = {
  '1': 'PermissionList',
  '2': [
    {'1': 'follow', '3': 1, '4': 1, '5': 5, '10': 'follow'},
    {'1': 'interact', '3': 2, '4': 1, '5': 5, '10': 'interact'},
    {'1': 'chat', '3': 3, '4': 1, '5': 5, '10': 'chat'},
  ],
};

/// Descriptor for `SetUserBlackReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserBlackReqIdlDescriptor = $convert.base64Decode(
    'ChJTZXRVc2VyQmxhY2tSZXFJZGwSLwoEZGF0YRgBIAEoCzIbLlNldFVzZXJCbGFja1JlcUlkbC'
    '5EYXRhUmVxUgRkYXRhGu0BCgdEYXRhUmVxEiIKBmNvbW1vbhgBIAEoCzIKLkNvbW1vblJlcVIG'
    'Y29tbW9uEhsKCWJsYWNrX3VpZBgCIAEoA1IIYmxhY2tVaWQSRwoJcGVybV9saXN0GAMgASgLMi'
    'ouU2V0VXNlckJsYWNrUmVxSWRsLkRhdGFSZXEuUGVybWlzc2lvbkxpc3RSCHBlcm1MaXN0GlgK'
    'DlBlcm1pc3Npb25MaXN0EhYKBmZvbGxvdxgBIAEoBVIGZm9sbG93EhoKCGludGVyYWN0GAIgAS'
    'gFUghpbnRlcmFjdBISCgRjaGF0GAMgASgFUgRjaGF0');
