// This is a generated file - do not edit.
//
// Generated from GetLevelInfoReqIdl.proto.

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

@$core.Deprecated('Use getLevelInfoReqIdlDescriptor instead')
const GetLevelInfoReqIdl$json = {
  '1': 'GetLevelInfoReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetLevelInfoReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [GetLevelInfoReqIdl_DataReq$json],
};

@$core.Deprecated('Use getLevelInfoReqIdlDescriptor instead')
const GetLevelInfoReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'common', '3': 2, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'forum_id', '3': 1, '4': 1, '5': 3, '10': 'forumId'},
  ],
};

/// Descriptor for `GetLevelInfoReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLevelInfoReqIdlDescriptor = $convert.base64Decode(
    'ChJHZXRMZXZlbEluZm9SZXFJZGwSLwoEZGF0YRgBIAEoCzIbLkdldExldmVsSW5mb1JlcUlkbC'
    '5EYXRhUmVxUgRkYXRhGkgKB0RhdGFSZXESIgoGY29tbW9uGAIgASgLMgouQ29tbW9uUmVxUgZj'
    'b21tb24SGQoIZm9ydW1faWQYASABKANSB2ZvcnVtSWQ=');
