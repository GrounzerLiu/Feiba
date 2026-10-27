// This is a generated file - do not edit.
//
// Generated from PbFloorResIdl.proto.

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

@$core.Deprecated('Use pbFloorResIdlDescriptor instead')
const PbFloorResIdl$json = {
  '1': 'PbFloorResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.PbFloorResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [PbFloorResIdl_DataRes$json],
};

@$core.Deprecated('Use pbFloorResIdlDescriptor instead')
const PbFloorResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.Page', '10': 'page'},
    {'1': 'post', '3': 3, '4': 1, '5': 11, '6': '.Post', '10': 'post'},
    {
      '1': 'subpost_list',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.SubPostList',
      '10': 'subpostList'
    },
    {
      '1': 'thread',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.ThreadInfo',
      '10': 'thread'
    },
    {'1': 'forum', '3': 6, '4': 1, '5': 11, '6': '.SimpleForum', '10': 'forum'},
  ],
};

/// Descriptor for `PbFloorResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pbFloorResIdlDescriptor = $convert.base64Decode(
    'Cg1QYkZsb29yUmVzSWRsEhwKBWVycm9yGAEgASgLMgYuRXJyb3JSBWVycm9yEioKBGRhdGEYAi'
    'ABKAsyFi5QYkZsb29yUmVzSWRsLkRhdGFSZXNSBGRhdGEauQEKB0RhdGFSZXMSGQoEcGFnZRgB'
    'IAEoCzIFLlBhZ2VSBHBhZ2USGQoEcG9zdBgDIAEoCzIFLlBvc3RSBHBvc3QSLwoMc3VicG9zdF'
    '9saXN0GAQgAygLMgwuU3ViUG9zdExpc3RSC3N1YnBvc3RMaXN0EiMKBnRocmVhZBgFIAEoCzIL'
    'LlRocmVhZEluZm9SBnRocmVhZBIiCgVmb3J1bRgGIAEoCzIMLlNpbXBsZUZvcnVtUgVmb3J1bQ'
    '==');
