// This is a generated file - do not edit.
//
// Generated from UserMuteQueryResIdl.proto.

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

@$core.Deprecated('Use userMuteQueryResIdlDescriptor instead')
const UserMuteQueryResIdl$json = {
  '1': 'UserMuteQueryResIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.UserMuteQueryResIdl.DataRes',
      '10': 'data'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
  ],
  '3': [UserMuteQueryResIdl_DataRes$json],
};

@$core.Deprecated('Use userMuteQueryResIdlDescriptor instead')
const UserMuteQueryResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'mute_user',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.UserMuteQueryResIdl.DataRes.MuteUser',
      '10': 'muteUser'
    },
    {'1': 'page', '3': 2, '4': 1, '5': 11, '6': '.Page', '10': 'page'},
  ],
  '3': [UserMuteQueryResIdl_DataRes_MuteUser$json],
};

@$core.Deprecated('Use userMuteQueryResIdlDescriptor instead')
const UserMuteQueryResIdl_DataRes_MuteUser$json = {
  '1': 'MuteUser',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'mute_time', '3': 3, '4': 1, '5': 5, '10': 'muteTime'},
    {'1': 'portrait', '3': 4, '4': 1, '5': 9, '10': 'portrait'},
    {'1': 'name_show', '3': 5, '4': 1, '5': 9, '10': 'nameShow'},
  ],
};

/// Descriptor for `UserMuteQueryResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMuteQueryResIdlDescriptor = $convert.base64Decode(
    'ChNVc2VyTXV0ZVF1ZXJ5UmVzSWRsEjAKBGRhdGEYASABKAsyHC5Vc2VyTXV0ZVF1ZXJ5UmVzSW'
    'RsLkRhdGFSZXNSBGRhdGESHAoFZXJyb3IYAiABKAsyBi5FcnJvclIFZXJyb3IagQIKB0RhdGFS'
    'ZXMSQgoJbXV0ZV91c2VyGAEgAygLMiUuVXNlck11dGVRdWVyeVJlc0lkbC5EYXRhUmVzLk11dG'
    'VVc2VyUghtdXRlVXNlchIZCgRwYWdlGAIgASgLMgUuUGFnZVIEcGFnZRqWAQoITXV0ZVVzZXIS'
    'FwoHdXNlcl9pZBgBIAEoA1IGdXNlcklkEhsKCXVzZXJfbmFtZRgCIAEoCVIIdXNlck5hbWUSGw'
    'oJbXV0ZV90aW1lGAMgASgFUghtdXRlVGltZRIaCghwb3J0cmFpdBgEIAEoCVIIcG9ydHJhaXQS'
    'GwoJbmFtZV9zaG93GAUgASgJUghuYW1lU2hvdw==');
