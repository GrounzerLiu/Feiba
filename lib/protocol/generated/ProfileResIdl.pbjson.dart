// This is a generated file - do not edit.
//
// Generated from ProfileResIdl.proto.

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

@$core.Deprecated('Use profileResIdlDescriptor instead')
const ProfileResIdl$json = {
  '1': 'ProfileResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.ProfileResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [ProfileResIdl_DataRes$json],
};

@$core.Deprecated('Use profileResIdlDescriptor instead')
const ProfileResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
    {
      '1': 'anti_stat',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.ProfileResIdl.DataRes.Anti',
      '10': 'antiStat'
    },
    {
      '1': 'post_list',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.PostInfoList',
      '10': 'postList'
    },
    {
      '1': 'user_agree_info',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.ProfileResIdl.DataRes.UserAgreeInfo',
      '10': 'userAgreeInfo'
    },
  ],
  '3': [
    ProfileResIdl_DataRes_Anti$json,
    ProfileResIdl_DataRes_UserAgreeInfo$json
  ],
};

@$core.Deprecated('Use profileResIdlDescriptor instead')
const ProfileResIdl_DataRes_Anti$json = {
  '1': 'Anti',
  '2': [
    {'1': 'block_stat', '3': 6, '4': 1, '5': 5, '10': 'blockStat'},
    {'1': 'hide_stat', '3': 7, '4': 1, '5': 5, '10': 'hideStat'},
    {'1': 'days_tofree', '3': 9, '4': 1, '5': 5, '10': 'daysTofree'},
  ],
};

@$core.Deprecated('Use profileResIdlDescriptor instead')
const ProfileResIdl_DataRes_UserAgreeInfo$json = {
  '1': 'UserAgreeInfo',
  '2': [
    {'1': 'total_agree_num', '3': 1, '4': 1, '5': 3, '10': 'totalAgreeNum'},
  ],
};

/// Descriptor for `ProfileResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileResIdlDescriptor = $convert.base64Decode(
    'Cg1Qcm9maWxlUmVzSWRsEhwKBWVycm9yGAEgASgLMgYuRXJyb3JSBWVycm9yEioKBGRhdGEYAi'
    'ABKAsyFi5Qcm9maWxlUmVzSWRsLkRhdGFSZXNSBGRhdGEa9gIKB0RhdGFSZXMSGQoEdXNlchgB'
    'IAEoCzIFLlVzZXJSBHVzZXISOAoJYW50aV9zdGF0GAIgASgLMhsuUHJvZmlsZVJlc0lkbC5EYX'
    'RhUmVzLkFudGlSCGFudGlTdGF0EioKCXBvc3RfbGlzdBgEIAMoCzINLlBvc3RJbmZvTGlzdFII'
    'cG9zdExpc3QSTAoPdXNlcl9hZ3JlZV9pbmZvGA4gASgLMiQuUHJvZmlsZVJlc0lkbC5EYXRhUm'
    'VzLlVzZXJBZ3JlZUluZm9SDXVzZXJBZ3JlZUluZm8aYwoEQW50aRIdCgpibG9ja19zdGF0GAYg'
    'ASgFUglibG9ja1N0YXQSGwoJaGlkZV9zdGF0GAcgASgFUghoaWRlU3RhdBIfCgtkYXlzX3RvZn'
    'JlZRgJIAEoBVIKZGF5c1RvZnJlZRo3Cg1Vc2VyQWdyZWVJbmZvEiYKD3RvdGFsX2FncmVlX251'
    'bRgBIAEoA1INdG90YWxBZ3JlZU51bQ==');
