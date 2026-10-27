// This is a generated file - do not edit.
//
// Generated from UserPostResIdl.proto.

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

@$core.Deprecated('Use userPostResIdlDescriptor instead')
const UserPostResIdl$json = {
  '1': 'UserPostResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.UserPostResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [UserPostResIdl_DataRes$json],
};

@$core.Deprecated('Use userPostResIdlDescriptor instead')
const UserPostResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'post_list',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.PostInfoList',
      '10': 'postList'
    },
  ],
};

/// Descriptor for `UserPostResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPostResIdlDescriptor = $convert.base64Decode(
    'Cg5Vc2VyUG9zdFJlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchIrCgRkYXRhGA'
    'IgASgLMhcuVXNlclBvc3RSZXNJZGwuRGF0YVJlc1IEZGF0YRo1CgdEYXRhUmVzEioKCXBvc3Rf'
    'bGlzdBgBIAMoCzINLlBvc3RJbmZvTGlzdFIIcG9zdExpc3Q=');
