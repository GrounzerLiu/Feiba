// This is a generated file - do not edit.
//
// Generated from GetForumDetailReqIdl.proto.

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

@$core.Deprecated('Use getForumDetailReqIdlDescriptor instead')
const GetForumDetailReqIdl$json = {
  '1': 'GetForumDetailReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetForumDetailReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [GetForumDetailReqIdl_DataReq$json],
};

@$core.Deprecated('Use getForumDetailReqIdlDescriptor instead')
const GetForumDetailReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'forum_id', '3': 1, '4': 1, '5': 3, '10': 'forumId'},
    {'1': 'common', '3': 2, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
  ],
};

/// Descriptor for `GetForumDetailReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getForumDetailReqIdlDescriptor = $convert.base64Decode(
    'ChRHZXRGb3J1bURldGFpbFJlcUlkbBIxCgRkYXRhGAEgASgLMh0uR2V0Rm9ydW1EZXRhaWxSZX'
    'FJZGwuRGF0YVJlcVIEZGF0YRpICgdEYXRhUmVxEhkKCGZvcnVtX2lkGAEgASgDUgdmb3J1bUlk'
    'EiIKBmNvbW1vbhgCIAEoCzIKLkNvbW1vblJlcVIGY29tbW9u');
