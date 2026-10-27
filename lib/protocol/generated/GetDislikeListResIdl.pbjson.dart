// This is a generated file - do not edit.
//
// Generated from GetDislikeListResIdl.proto.

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

@$core.Deprecated('Use getDislikeListResIdlDescriptor instead')
const GetDislikeListResIdl$json = {
  '1': 'GetDislikeListResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GetDislikeListResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [GetDislikeListResIdl_DataRes$json],
};

@$core.Deprecated('Use getDislikeListResIdlDescriptor instead')
const GetDislikeListResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'forum_list',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.ForumList',
      '10': 'forumList'
    },
    {'1': 'has_more', '3': 2, '4': 1, '5': 5, '10': 'hasMore'},
    {'1': 'cur_page', '3': 3, '4': 1, '5': 5, '10': 'curPage'},
  ],
};

/// Descriptor for `GetDislikeListResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDislikeListResIdlDescriptor = $convert.base64Decode(
    'ChRHZXREaXNsaWtlTGlzdFJlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchIxCg'
    'RkYXRhGAIgASgLMh0uR2V0RGlzbGlrZUxpc3RSZXNJZGwuRGF0YVJlc1IEZGF0YRpqCgdEYXRh'
    'UmVzEikKCmZvcnVtX2xpc3QYASADKAsyCi5Gb3J1bUxpc3RSCWZvcnVtTGlzdBIZCghoYXNfbW'
    '9yZRgCIAEoBVIHaGFzTW9yZRIZCghjdXJfcGFnZRgDIAEoBVIHY3VyUGFnZQ==');
