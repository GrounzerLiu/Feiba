// This is a generated file - do not edit.
//
// Generated from CommitReceivedPmsgResIdl.proto.

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

@$core.Deprecated('Use commitReceivedPmsgResIdlDescriptor instead')
const CommitReceivedPmsgResIdl$json = {
  '1': 'CommitReceivedPmsgResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.CommitReceivedPmsgResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [CommitReceivedPmsgResIdl_DataRes$json],
};

@$core.Deprecated('Use commitReceivedPmsgResIdlDescriptor instead')
const CommitReceivedPmsgResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {'1': 'readMsgId', '3': 1, '4': 1, '5': 3, '10': 'readMsgId'},
    {'1': 'groupId', '3': 2, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'toUid', '3': 3, '4': 1, '5': 3, '10': 'toUid'},
    {'1': 'toUserType', '3': 4, '4': 1, '5': 5, '10': 'toUserType'},
  ],
};

/// Descriptor for `CommitReceivedPmsgResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitReceivedPmsgResIdlDescriptor = $convert.base64Decode(
    'ChhDb21taXRSZWNlaXZlZFBtc2dSZXNJZGwSHAoFZXJyb3IYASABKAsyBi5FcnJvclIFZXJyb3'
    'ISNQoEZGF0YRgCIAEoCzIhLkNvbW1pdFJlY2VpdmVkUG1zZ1Jlc0lkbC5EYXRhUmVzUgRkYXRh'
    'GncKB0RhdGFSZXMSHAoJcmVhZE1zZ0lkGAEgASgDUglyZWFkTXNnSWQSGAoHZ3JvdXBJZBgCIA'
    'EoA1IHZ3JvdXBJZBIUCgV0b1VpZBgDIAEoA1IFdG9VaWQSHgoKdG9Vc2VyVHlwZRgEIAEoBVIK'
    'dG9Vc2VyVHlwZQ==');
