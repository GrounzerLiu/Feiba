// This is a generated file - do not edit.
//
// Generated from GetForumDetailResIdl.proto.

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

@$core.Deprecated('Use getForumDetailResIdlDescriptor instead')
const GetForumDetailResIdl$json = {
  '1': 'GetForumDetailResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GetForumDetailResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [GetForumDetailResIdl_DataRes$json],
};

@$core.Deprecated('Use getForumDetailResIdlDescriptor instead')
const GetForumDetailResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'forum_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetForumDetailResIdl.DataRes.RecommendForumInfo',
      '10': 'forumInfo'
    },
    {
      '1': 'election_tab',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.GetForumDetailResIdl.DataRes.ManagerElectionTab',
      '10': 'electionTab'
    },
  ],
  '3': [
    GetForumDetailResIdl_DataRes_RecommendForumInfo$json,
    GetForumDetailResIdl_DataRes_ManagerElectionTab$json
  ],
};

@$core.Deprecated('Use getForumDetailResIdlDescriptor instead')
const GetForumDetailResIdl_DataRes_RecommendForumInfo$json = {
  '1': 'RecommendForumInfo',
  '2': [
    {'1': 'avatar', '3': 1, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'forum_id', '3': 2, '4': 1, '5': 4, '10': 'forumId'},
    {'1': 'forum_name', '3': 3, '4': 1, '5': 9, '10': 'forumName'},
    {'1': 'member_count', '3': 5, '4': 1, '5': 13, '10': 'memberCount'},
    {'1': 'thread_count', '3': 6, '4': 1, '5': 13, '10': 'threadCount'},
    {'1': 'slogan', '3': 7, '4': 1, '5': 9, '10': 'slogan'},
    {'1': 'lv1_name', '3': 18, '4': 1, '5': 9, '10': 'lv1Name'},
    {'1': 'avatar_origin', '3': 20, '4': 1, '5': 9, '10': 'avatarOrigin'},
  ],
};

@$core.Deprecated('Use getForumDetailResIdlDescriptor instead')
const GetForumDetailResIdl_DataRes_ManagerElectionTab$json = {
  '1': 'ManagerElectionTab',
  '2': [
    {'1': 'new_strategy_text', '3': 5, '4': 1, '5': 9, '10': 'newStrategyText'},
  ],
};

/// Descriptor for `GetForumDetailResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getForumDetailResIdlDescriptor = $convert.base64Decode(
    'ChRHZXRGb3J1bURldGFpbFJlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchIxCg'
    'RkYXRhGAIgASgLMh0uR2V0Rm9ydW1EZXRhaWxSZXNJZGwuRGF0YVJlc1IEZGF0YRr4AwoHRGF0'
    'YVJlcxJPCgpmb3J1bV9pbmZvGAEgASgLMjAuR2V0Rm9ydW1EZXRhaWxSZXNJZGwuRGF0YVJlcy'
    '5SZWNvbW1lbmRGb3J1bUluZm9SCWZvcnVtSW5mbxJTCgxlbGVjdGlvbl90YWIYCCABKAsyMC5H'
    'ZXRGb3J1bURldGFpbFJlc0lkbC5EYXRhUmVzLk1hbmFnZXJFbGVjdGlvblRhYlILZWxlY3Rpb2'
    '5UYWIahAIKElJlY29tbWVuZEZvcnVtSW5mbxIWCgZhdmF0YXIYASABKAlSBmF2YXRhchIZCghm'
    'b3J1bV9pZBgCIAEoBFIHZm9ydW1JZBIdCgpmb3J1bV9uYW1lGAMgASgJUglmb3J1bU5hbWUSIQ'
    'oMbWVtYmVyX2NvdW50GAUgASgNUgttZW1iZXJDb3VudBIhCgx0aHJlYWRfY291bnQYBiABKA1S'
    'C3RocmVhZENvdW50EhYKBnNsb2dhbhgHIAEoCVIGc2xvZ2FuEhkKCGx2MV9uYW1lGBIgASgJUg'
    'dsdjFOYW1lEiMKDWF2YXRhcl9vcmlnaW4YFCABKAlSDGF2YXRhck9yaWdpbhpAChJNYW5hZ2Vy'
    'RWxlY3Rpb25UYWISKgoRbmV3X3N0cmF0ZWd5X3RleHQYBSABKAlSD25ld1N0cmF0ZWd5VGV4dA'
    '==');
