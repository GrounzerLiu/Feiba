// This is a generated file - do not edit.
//
// Generated from CommitReceivedPmsgReqIdl.proto.

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

@$core.Deprecated('Use commitReceivedPmsgReqIdlDescriptor instead')
const CommitReceivedPmsgReqIdl$json = {
  '1': 'CommitReceivedPmsgReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.CommitReceivedPmsgReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [CommitReceivedPmsgReqIdl_DataReq$json],
};

@$core.Deprecated('Use commitReceivedPmsgReqIdlDescriptor instead')
const CommitReceivedPmsgReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'groupId', '3': 1, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'toUid', '3': 2, '4': 1, '5': 3, '10': 'toUid'},
    {'1': 'msgType', '3': 3, '4': 1, '5': 5, '10': 'msgType'},
    {'1': 'msgId', '3': 4, '4': 1, '5': 3, '10': 'msgId'},
  ],
};

/// Descriptor for `CommitReceivedPmsgReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitReceivedPmsgReqIdlDescriptor = $convert.base64Decode(
    'ChhDb21taXRSZWNlaXZlZFBtc2dSZXFJZGwSNQoEZGF0YRgBIAEoCzIhLkNvbW1pdFJlY2Vpdm'
    'VkUG1zZ1JlcUlkbC5EYXRhUmVxUgRkYXRhGmkKB0RhdGFSZXESGAoHZ3JvdXBJZBgBIAEoA1IH'
    'Z3JvdXBJZBIUCgV0b1VpZBgCIAEoA1IFdG9VaWQSGAoHbXNnVHlwZRgDIAEoBVIHbXNnVHlwZR'
    'IUCgVtc2dJZBgEIAEoA1IFbXNnSWQ=');
