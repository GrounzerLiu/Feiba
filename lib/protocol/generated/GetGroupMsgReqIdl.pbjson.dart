// This is a generated file - do not edit.
//
// Generated from GetGroupMsgReqIdl.proto.

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

@$core.Deprecated('Use getGroupMsgReqIdlDescriptor instead')
const GetGroupMsgReqIdl$json = {
  '1': 'GetGroupMsgReqIdl',
  '2': [
    {'1': 'cuid', '3': 1, '4': 1, '5': 9, '10': 'cuid'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GetGroupMsgReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [GetGroupMsgReqIdl_DataReq$json],
};

@$core.Deprecated('Use getGroupMsgReqIdlDescriptor instead')
const GetGroupMsgReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {
      '1': 'groupMids',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.GetGroupMsgReqIdl.DataReq.GroupLastId',
      '10': 'groupMids'
    },
    {'1': 'gettype', '3': 7, '4': 1, '5': 9, '10': 'gettype'},
  ],
  '3': [GetGroupMsgReqIdl_DataReq_GroupLastId$json],
};

@$core.Deprecated('Use getGroupMsgReqIdlDescriptor instead')
const GetGroupMsgReqIdl_DataReq_GroupLastId$json = {
  '1': 'GroupLastId',
  '2': [
    {'1': 'groupId', '3': 1, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'lastMsgId', '3': 2, '4': 1, '5': 3, '10': 'lastMsgId'},
  ],
};

/// Descriptor for `GetGroupMsgReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMsgReqIdlDescriptor = $convert.base64Decode(
    'ChFHZXRHcm91cE1zZ1JlcUlkbBISCgRjdWlkGAEgASgJUgRjdWlkEi4KBGRhdGEYAiABKAsyGi'
    '5HZXRHcm91cE1zZ1JlcUlkbC5EYXRhUmVxUgRkYXRhGrABCgdEYXRhUmVxEkQKCWdyb3VwTWlk'
    'cxgGIAMoCzImLkdldEdyb3VwTXNnUmVxSWRsLkRhdGFSZXEuR3JvdXBMYXN0SWRSCWdyb3VwTW'
    'lkcxIYCgdnZXR0eXBlGAcgASgJUgdnZXR0eXBlGkUKC0dyb3VwTGFzdElkEhgKB2dyb3VwSWQY'
    'ASABKANSB2dyb3VwSWQSHAoJbGFzdE1zZ0lkGAIgASgDUglsYXN0TXNnSWQ=');
