// This is a generated file - do not edit.
//
// Generated from GetForumSquareResIdl.proto.

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

@$core.Deprecated('Use getForumSquareResIdlDescriptor instead')
const GetForumSquareResIdl$json = {
  '1': 'GetForumSquareResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GetForumSquareResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [GetForumSquareResIdl_DataRes$json],
};

@$core.Deprecated('Use getForumSquareResIdlDescriptor instead')
const GetForumSquareResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'forum_info',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.GetForumSquareResIdl.DataRes.RecommendForumInfo',
      '10': 'forumInfo'
    },
    {'1': 'page', '3': 3, '4': 1, '5': 11, '6': '.Page', '10': 'page'},
  ],
  '3': [GetForumSquareResIdl_DataRes_RecommendForumInfo$json],
};

@$core.Deprecated('Use getForumSquareResIdlDescriptor instead')
const GetForumSquareResIdl_DataRes_RecommendForumInfo$json = {
  '1': 'RecommendForumInfo',
  '2': [
    {'1': 'forum_id', '3': 2, '4': 1, '5': 4, '10': 'forumId'},
    {'1': 'forum_name', '3': 3, '4': 1, '5': 9, '10': 'forumName'},
    {'1': 'is_like', '3': 4, '4': 1, '5': 13, '10': 'isLike'},
    {'1': 'member_count', '3': 5, '4': 1, '5': 13, '10': 'memberCount'},
    {'1': 'thread_count', '3': 6, '4': 1, '5': 13, '10': 'threadCount'},
  ],
};

/// Descriptor for `GetForumSquareResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getForumSquareResIdlDescriptor = $convert.base64Decode(
    'ChRHZXRGb3J1bVNxdWFyZVJlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchIxCg'
    'RkYXRhGAIgASgLMh0uR2V0Rm9ydW1TcXVhcmVSZXNJZGwuRGF0YVJlc1IEZGF0YRqlAgoHRGF0'
    'YVJlcxJPCgpmb3J1bV9pbmZvGAIgAygLMjAuR2V0Rm9ydW1TcXVhcmVSZXNJZGwuRGF0YVJlcy'
    '5SZWNvbW1lbmRGb3J1bUluZm9SCWZvcnVtSW5mbxIZCgRwYWdlGAMgASgLMgUuUGFnZVIEcGFn'
    'ZRqtAQoSUmVjb21tZW5kRm9ydW1JbmZvEhkKCGZvcnVtX2lkGAIgASgEUgdmb3J1bUlkEh0KCm'
    'ZvcnVtX25hbWUYAyABKAlSCWZvcnVtTmFtZRIXCgdpc19saWtlGAQgASgNUgZpc0xpa2USIQoM'
    'bWVtYmVyX2NvdW50GAUgASgNUgttZW1iZXJDb3VudBIhCgx0aHJlYWRfY291bnQYBiABKA1SC3'
    'RocmVhZENvdW50');
