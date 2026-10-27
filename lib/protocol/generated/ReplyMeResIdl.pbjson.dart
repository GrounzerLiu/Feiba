// This is a generated file - do not edit.
//
// Generated from ReplyMeResIdl.proto.

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

@$core.Deprecated('Use replyMeResIdlDescriptor instead')
const ReplyMeResIdl$json = {
  '1': 'ReplyMeResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.ReplyMeResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [ReplyMeResIdl_DataRes$json],
};

@$core.Deprecated('Use replyMeResIdlDescriptor instead')
const ReplyMeResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.Page', '10': 'page'},
    {
      '1': 'reply_list',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ReplyMeResIdl.DataRes.ReplyList',
      '10': 'replyList'
    },
  ],
  '3': [ReplyMeResIdl_DataRes_ReplyList$json],
};

@$core.Deprecated('Use replyMeResIdlDescriptor instead')
const ReplyMeResIdl_DataRes_ReplyList$json = {
  '1': 'ReplyList',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 4, '10': 'threadId'},
    {'1': 'post_id', '3': 2, '4': 1, '5': 4, '10': 'postId'},
    {'1': 'time', '3': 3, '4': 1, '5': 13, '10': 'time'},
    {'1': 'fname', '3': 5, '4': 1, '5': 9, '10': 'fname'},
    {'1': 'content', '3': 6, '4': 1, '5': 9, '10': 'content'},
    {'1': 'is_floor', '3': 7, '4': 1, '5': 13, '10': 'isFloor'},
    {'1': 'quote_content', '3': 8, '4': 1, '5': 9, '10': 'quoteContent'},
    {'1': 'replyer', '3': 9, '4': 1, '5': 11, '6': '.User', '10': 'replyer'},
    {'1': 'quote_pid', '3': 14, '4': 1, '5': 4, '10': 'quotePid'},
    {
      '1': 'quote_user',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.User',
      '10': 'quoteUser'
    },
    {
      '1': 'thread_author_user',
      '3': 25,
      '4': 1,
      '5': 11,
      '6': '.User',
      '10': 'threadAuthorUser'
    },
    {
      '1': 'new_floor_info',
      '3': 28,
      '4': 3,
      '5': 11,
      '6': '.ReplyMeResIdl.DataRes.ReplyList.NewFloorInfo',
      '10': 'newFloorInfo'
    },
  ],
  '3': [ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo$json],
};

@$core.Deprecated('Use replyMeResIdlDescriptor instead')
const ReplyMeResIdl_DataRes_ReplyList_NewFloorInfo$json = {
  '1': 'NewFloorInfo',
  '2': [
    {
      '1': 'content',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.PbContent',
      '10': 'content'
    },
  ],
};

/// Descriptor for `ReplyMeResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyMeResIdlDescriptor = $convert.base64Decode(
    'Cg1SZXBseU1lUmVzSWRsEhwKBWVycm9yGAEgASgLMgYuRXJyb3JSBWVycm9yEioKBGRhdGEYAi'
    'ABKAsyFi5SZXBseU1lUmVzSWRsLkRhdGFSZXNSBGRhdGEa0QQKB0RhdGFSZXMSGQoEcGFnZRgB'
    'IAEoCzIFLlBhZ2VSBHBhZ2USPwoKcmVwbHlfbGlzdBgCIAMoCzIgLlJlcGx5TWVSZXNJZGwuRG'
    'F0YVJlcy5SZXBseUxpc3RSCXJlcGx5TGlzdBrpAwoJUmVwbHlMaXN0EhsKCXRocmVhZF9pZBgB'
    'IAEoBFIIdGhyZWFkSWQSFwoHcG9zdF9pZBgCIAEoBFIGcG9zdElkEhIKBHRpbWUYAyABKA1SBH'
    'RpbWUSFAoFZm5hbWUYBSABKAlSBWZuYW1lEhgKB2NvbnRlbnQYBiABKAlSB2NvbnRlbnQSGQoI'
    'aXNfZmxvb3IYByABKA1SB2lzRmxvb3ISIwoNcXVvdGVfY29udGVudBgIIAEoCVIMcXVvdGVDb2'
    '50ZW50Eh8KB3JlcGx5ZXIYCSABKAsyBS5Vc2VyUgdyZXBseWVyEhsKCXF1b3RlX3BpZBgOIAEo'
    'BFIIcXVvdGVQaWQSJAoKcXVvdGVfdXNlchgPIAEoCzIFLlVzZXJSCXF1b3RlVXNlchIzChJ0aH'
    'JlYWRfYXV0aG9yX3VzZXIYGSABKAsyBS5Vc2VyUhB0aHJlYWRBdXRob3JVc2VyElMKDm5ld19m'
    'bG9vcl9pbmZvGBwgAygLMi0uUmVwbHlNZVJlc0lkbC5EYXRhUmVzLlJlcGx5TGlzdC5OZXdGbG'
    '9vckluZm9SDG5ld0Zsb29ySW5mbxo0CgxOZXdGbG9vckluZm8SJAoHY29udGVudBgBIAMoCzIK'
    'LlBiQ29udGVudFIHY29udGVudA==');
