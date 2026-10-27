// This is a generated file - do not edit.
//
// Generated from UserPostReqIdl.proto.

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

@$core.Deprecated('Use userPostReqIdlDescriptor instead')
const UserPostReqIdl$json = {
  '1': 'UserPostReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.UserPostReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [UserPostReqIdl_DataReq$json],
};

@$core.Deprecated('Use userPostReqIdlDescriptor instead')
const UserPostReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 3, '10': 'uid'},
    {'1': 'rn', '3': 2, '4': 1, '5': 13, '10': 'rn'},
    {'1': 'is_thread', '3': 4, '4': 1, '5': 13, '10': 'isThread'},
    {'1': 'need_content', '3': 5, '4': 1, '5': 13, '10': 'needContent'},
    {'1': 'pn', '3': 26, '4': 1, '5': 13, '10': 'pn'},
    {'1': 'is_view_card', '3': 33, '4': 1, '5': 5, '10': 'isViewCard'},
    {
      '1': 'common',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.CommonReq',
      '10': 'common'
    },
  ],
};

/// Descriptor for `UserPostReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPostReqIdlDescriptor = $convert.base64Decode(
    'Cg5Vc2VyUG9zdFJlcUlkbBIrCgRkYXRhGAEgASgLMhcuVXNlclBvc3RSZXFJZGwuRGF0YVJlcV'
    'IEZGF0YRrBAQoHRGF0YVJlcRIQCgN1aWQYASABKANSA3VpZBIOCgJybhgCIAEoDVICcm4SGwoJ'
    'aXNfdGhyZWFkGAQgASgNUghpc1RocmVhZBIhCgxuZWVkX2NvbnRlbnQYBSABKA1SC25lZWRDb2'
    '50ZW50Eg4KAnBuGBogASgNUgJwbhIgCgxpc192aWV3X2NhcmQYISABKAVSCmlzVmlld0NhcmQS'
    'IgoGY29tbW9uGBsgASgLMgouQ29tbW9uUmVxUgZjb21tb24=');
