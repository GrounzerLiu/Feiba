// This is a generated file - do not edit.
//
// Generated from ProfileReqIdl.proto.

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

@$core.Deprecated('Use profileReqIdlDescriptor instead')
const ProfileReqIdl$json = {
  '1': 'ProfileReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.ProfileReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [ProfileReqIdl_DataReq$json],
};

@$core.Deprecated('Use profileReqIdlDescriptor instead')
const ProfileReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 3, '10': 'uid'},
    {'1': 'need_post_count', '3': 2, '4': 1, '5': 13, '10': 'needPostCount'},
    {'1': 'pn', '3': 6, '4': 1, '5': 13, '10': 'pn'},
    {'1': 'common', '3': 9, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'page', '3': 15, '4': 1, '5': 5, '10': 'page'},
    {
      '1': 'friend_uid_portrait',
      '3': 16,
      '4': 1,
      '5': 9,
      '10': 'friendUidPortrait'
    },
  ],
};

/// Descriptor for `ProfileReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileReqIdlDescriptor = $convert.base64Decode(
    'Cg1Qcm9maWxlUmVxSWRsEioKBGRhdGEYASABKAsyFi5Qcm9maWxlUmVxSWRsLkRhdGFSZXFSBG'
    'RhdGEauwEKB0RhdGFSZXESEAoDdWlkGAEgASgDUgN1aWQSJgoPbmVlZF9wb3N0X2NvdW50GAIg'
    'ASgNUg1uZWVkUG9zdENvdW50Eg4KAnBuGAYgASgNUgJwbhIiCgZjb21tb24YCSABKAsyCi5Db2'
    '1tb25SZXFSBmNvbW1vbhISCgRwYWdlGA8gASgFUgRwYWdlEi4KE2ZyaWVuZF91aWRfcG9ydHJh'
    'aXQYECABKAlSEWZyaWVuZFVpZFBvcnRyYWl0');
