// This is a generated file - do not edit.
//
// Generated from Personalized.proto.

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

@$core.Deprecated('Use personalizedRequestDataDescriptor instead')
const PersonalizedRequestData$json = {
  '1': 'PersonalizedRequestData',
  '2': [
    {'1': 'common', '3': 1, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'load_type', '3': 4, '4': 1, '5': 13, '10': 'loadType'},
    {'1': 'pn', '3': 6, '4': 1, '5': 13, '10': 'pn'},
    {
      '1': 'page_thread_count',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'pageThreadCount'
    },
    {'1': 'need_tags', '3': 3, '4': 1, '5': 13, '10': 'needTags'},
    {'1': 'tag_code', '3': 2, '4': 1, '5': 13, '10': 'tagCode'},
    {'1': 'q_type', '3': 11, '4': 1, '5': 5, '10': 'qType'},
    {'1': 'need_forumlist', '3': 22, '4': 1, '5': 13, '10': 'needForumlist'},
    {'1': 'new_net_type', '3': 23, '4': 1, '5': 13, '10': 'newNetType'},
    {'1': 'new_install', '3': 27, '4': 1, '5': 5, '10': 'newInstall'},
    {'1': 'request_times', '3': 28, '4': 1, '5': 5, '10': 'requestTimes'},
    {'1': 'invoke_source', '3': 29, '4': 1, '5': 9, '10': 'invokeSource'},
    {'1': 'scr_dip', '3': 10, '4': 1, '5': 1, '10': 'scrDip'},
    {'1': 'scr_h', '3': 9, '4': 1, '5': 5, '10': 'scrH'},
    {'1': 'scr_w', '3': 8, '4': 1, '5': 5, '10': 'scrW'},
    {'1': 'sug_count', '3': 7, '4': 1, '5': 13, '10': 'sugCount'},
    {
      '1': 'pre_ad_thread_count',
      '3': 26,
      '4': 1,
      '5': 5,
      '10': 'preAdThreadCount'
    },
  ],
};

/// Descriptor for `PersonalizedRequestData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personalizedRequestDataDescriptor = $convert.base64Decode(
    'ChdQZXJzb25hbGl6ZWRSZXF1ZXN0RGF0YRIiCgZjb21tb24YASABKAsyCi5Db21tb25SZXFSBm'
    'NvbW1vbhIbCglsb2FkX3R5cGUYBCABKA1SCGxvYWRUeXBlEg4KAnBuGAYgASgNUgJwbhIqChFw'
    'YWdlX3RocmVhZF9jb3VudBgFIAEoDVIPcGFnZVRocmVhZENvdW50EhsKCW5lZWRfdGFncxgDIA'
    'EoDVIIbmVlZFRhZ3MSGQoIdGFnX2NvZGUYAiABKA1SB3RhZ0NvZGUSFQoGcV90eXBlGAsgASgF'
    'UgVxVHlwZRIlCg5uZWVkX2ZvcnVtbGlzdBgWIAEoDVINbmVlZEZvcnVtbGlzdBIgCgxuZXdfbm'
    'V0X3R5cGUYFyABKA1SCm5ld05ldFR5cGUSHwoLbmV3X2luc3RhbGwYGyABKAVSCm5ld0luc3Rh'
    'bGwSIwoNcmVxdWVzdF90aW1lcxgcIAEoBVIMcmVxdWVzdFRpbWVzEiMKDWludm9rZV9zb3VyY2'
    'UYHSABKAlSDGludm9rZVNvdXJjZRIXCgdzY3JfZGlwGAogASgBUgZzY3JEaXASEwoFc2NyX2gY'
    'CSABKAVSBHNjckgSEwoFc2NyX3cYCCABKAVSBHNjclcSGwoJc3VnX2NvdW50GAcgASgNUghzdW'
    'dDb3VudBItChNwcmVfYWRfdGhyZWFkX2NvdW50GBogASgFUhBwcmVBZFRocmVhZENvdW50');

@$core.Deprecated('Use personalizedRequestDescriptor instead')
const PersonalizedRequest$json = {
  '1': 'PersonalizedRequest',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.PersonalizedRequestData',
      '10': 'data'
    },
  ],
};

/// Descriptor for `PersonalizedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personalizedRequestDescriptor = $convert.base64Decode(
    'ChNQZXJzb25hbGl6ZWRSZXF1ZXN0EiwKBGRhdGEYASABKAsyGC5QZXJzb25hbGl6ZWRSZXF1ZX'
    'N0RGF0YVIEZGF0YQ==');

@$core.Deprecated('Use personalizedResponseDataDescriptor instead')
const PersonalizedResponseData$json = {
  '1': 'PersonalizedResponseData',
  '2': [
    {
      '1': 'thread_list',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ThreadInfo',
      '10': 'threadList'
    },
  ],
};

/// Descriptor for `PersonalizedResponseData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personalizedResponseDataDescriptor =
    $convert.base64Decode(
        'ChhQZXJzb25hbGl6ZWRSZXNwb25zZURhdGESLAoLdGhyZWFkX2xpc3QYAiADKAsyCy5UaHJlYW'
        'RJbmZvUgp0aHJlYWRMaXN0');

@$core.Deprecated('Use personalizedResponseDescriptor instead')
const PersonalizedResponse$json = {
  '1': 'PersonalizedResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.PersonalizedResponseData',
      '10': 'data'
    },
  ],
};

/// Descriptor for `PersonalizedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personalizedResponseDescriptor = $convert.base64Decode(
    'ChRQZXJzb25hbGl6ZWRSZXNwb25zZRIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchItCg'
    'RkYXRhGAIgASgLMhkuUGVyc29uYWxpemVkUmVzcG9uc2VEYXRhUgRkYXRh');
