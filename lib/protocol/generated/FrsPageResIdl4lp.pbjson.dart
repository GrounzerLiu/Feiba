// This is a generated file - do not edit.
//
// Generated from FrsPageResIdl4lp.proto.

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

@$core.Deprecated('Use frsPageResIdl4lpDescriptor instead')
const FrsPageResIdl4lp$json = {
  '1': 'FrsPageResIdl4lp',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.FrsPageResIdl4lp.DataRes',
      '10': 'data'
    },
  ],
  '3': [FrsPageResIdl4lp_DataRes$json],
};

@$core.Deprecated('Use frsPageResIdl4lpDescriptor instead')
const FrsPageResIdl4lp_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'forum',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.FrsPageResIdl4lp.DataRes.ForumInfo',
      '10': 'forum'
    },
    {'1': 'page', '3': 4, '4': 1, '5': 11, '6': '.Page', '10': 'page'},
    {
      '1': 'thread_list',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.ThreadInfo',
      '10': 'threadList'
    },
  ],
  '3': [FrsPageResIdl4lp_DataRes_ForumInfo$json],
};

@$core.Deprecated('Use frsPageResIdl4lpDescriptor instead')
const FrsPageResIdl4lp_DataRes_ForumInfo$json = {
  '1': 'ForumInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `FrsPageResIdl4lp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frsPageResIdl4lpDescriptor = $convert.base64Decode(
    'ChBGcnNQYWdlUmVzSWRsNGxwEhwKBWVycm9yGAEgASgLMgYuRXJyb3JSBWVycm9yEi0KBGRhdG'
    'EYAiABKAsyGS5GcnNQYWdlUmVzSWRsNGxwLkRhdGFSZXNSBGRhdGEavgEKB0RhdGFSZXMSOQoF'
    'Zm9ydW0YAiABKAsyIy5GcnNQYWdlUmVzSWRsNGxwLkRhdGFSZXMuRm9ydW1JbmZvUgVmb3J1bR'
    'IZCgRwYWdlGAQgASgLMgUuUGFnZVIEcGFnZRIsCgt0aHJlYWRfbGlzdBgHIAMoCzILLlRocmVh'
    'ZEluZm9SCnRocmVhZExpc3QaLwoJRm9ydW1JbmZvEg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGA'
    'IgASgJUgRuYW1l');
