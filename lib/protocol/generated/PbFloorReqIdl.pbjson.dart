// This is a generated file - do not edit.
//
// Generated from PbFloorReqIdl.proto.

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

@$core.Deprecated('Use pbFloorReqIdlDescriptor instead')
const PbFloorReqIdl$json = {
  '1': 'PbFloorReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.PbFloorReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [PbFloorReqIdl_DataReq$json],
};

@$core.Deprecated('Use pbFloorReqIdlDescriptor instead')
const PbFloorReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'common', '3': 9, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'kz', '3': 1, '4': 1, '5': 3, '10': 'kz'},
    {'1': 'pid', '3': 2, '4': 1, '5': 3, '10': 'pid'},
    {'1': 'spid', '3': 3, '4': 1, '5': 3, '10': 'spid'},
    {'1': 'pn', '3': 4, '4': 1, '5': 5, '10': 'pn'},
    {'1': 'sort', '3': 19, '4': 1, '5': 5, '10': 'sort'},
  ],
};

/// Descriptor for `PbFloorReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pbFloorReqIdlDescriptor = $convert.base64Decode(
    'Cg1QYkZsb29yUmVxSWRsEioKBGRhdGEYASABKAsyFi5QYkZsb29yUmVxSWRsLkRhdGFSZXFSBG'
    'RhdGEahwEKB0RhdGFSZXESIgoGY29tbW9uGAkgASgLMgouQ29tbW9uUmVxUgZjb21tb24SDgoC'
    'a3oYASABKANSAmt6EhAKA3BpZBgCIAEoA1IDcGlkEhIKBHNwaWQYAyABKANSBHNwaWQSDgoCcG'
    '4YBCABKAVSAnBuEhIKBHNvcnQYEyABKAVSBHNvcnQ=');
