// This is a generated file - do not edit.
//
// Generated from SearchPostForumResIdl.proto.

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

@$core.Deprecated('Use searchPostForumResIdlDescriptor instead')
const SearchPostForumResIdl$json = {
  '1': 'SearchPostForumResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.SearchPostForumResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [SearchPostForumResIdl_DataRes$json],
};

@$core.Deprecated('Use searchPostForumResIdlDescriptor instead')
const SearchPostForumResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'exact_match',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.SearchPostForumResIdl.DataRes.SearchForum',
      '10': 'exactMatch'
    },
  ],
  '3': [SearchPostForumResIdl_DataRes_SearchForum$json],
};

@$core.Deprecated('Use searchPostForumResIdlDescriptor instead')
const SearchPostForumResIdl_DataRes_SearchForum$json = {
  '1': 'SearchForum',
  '2': [
    {'1': 'forum_id', '3': 1, '4': 1, '5': 3, '10': 'forumId'},
    {'1': 'forum_name', '3': 2, '4': 1, '5': 9, '10': 'forumName'},
    {
      '1': 'tab_info',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.FrsTabInfo',
      '10': 'tabInfo'
    },
  ],
};

/// Descriptor for `SearchPostForumResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchPostForumResIdlDescriptor = $convert.base64Decode(
    'ChVTZWFyY2hQb3N0Rm9ydW1SZXNJZGwSHAoFZXJyb3IYASABKAsyBi5FcnJvclIFZXJyb3ISMg'
    'oEZGF0YRgCIAEoCzIeLlNlYXJjaFBvc3RGb3J1bVJlc0lkbC5EYXRhUmVzUgRkYXRhGscBCgdE'
    'YXRhUmVzEksKC2V4YWN0X21hdGNoGAEgASgLMiouU2VhcmNoUG9zdEZvcnVtUmVzSWRsLkRhdG'
    'FSZXMuU2VhcmNoRm9ydW1SCmV4YWN0TWF0Y2gabwoLU2VhcmNoRm9ydW0SGQoIZm9ydW1faWQY'
    'ASABKANSB2ZvcnVtSWQSHQoKZm9ydW1fbmFtZRgCIAEoCVIJZm9ydW1OYW1lEiYKCHRhYl9pbm'
    'ZvGAkgAygLMgsuRnJzVGFiSW5mb1IHdGFiSW5mbw==');
