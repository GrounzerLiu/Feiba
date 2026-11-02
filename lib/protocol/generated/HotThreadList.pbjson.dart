// This is a generated file - do not edit.
//
// Generated from HotThreadList.proto.

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

@$core.Deprecated('Use hotThreadListRequestDataDescriptor instead')
const HotThreadListRequestData$json = {
  '1': 'HotThreadListRequestData',
  '2': [
    {'1': 'common', '3': 1, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'tabId', '3': 2, '4': 1, '5': 9, '10': 'tabId'},
    {'1': 'tabCode', '3': 3, '4': 1, '5': 9, '10': 'tabCode'},
  ],
};

/// Descriptor for `HotThreadListRequestData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotThreadListRequestDataDescriptor = $convert.base64Decode(
    'ChhIb3RUaHJlYWRMaXN0UmVxdWVzdERhdGESIgoGY29tbW9uGAEgASgLMgouQ29tbW9uUmVxUg'
    'Zjb21tb24SFAoFdGFiSWQYAiABKAlSBXRhYklkEhgKB3RhYkNvZGUYAyABKAlSB3RhYkNvZGU=');

@$core.Deprecated('Use hotThreadListRequestDescriptor instead')
const HotThreadListRequest$json = {
  '1': 'HotThreadListRequest',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.HotThreadListRequestData',
      '10': 'data'
    },
  ],
};

/// Descriptor for `HotThreadListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotThreadListRequestDescriptor = $convert.base64Decode(
    'ChRIb3RUaHJlYWRMaXN0UmVxdWVzdBItCgRkYXRhGAEgASgLMhkuSG90VGhyZWFkTGlzdFJlcX'
    'Vlc3REYXRhUgRkYXRh');

@$core.Deprecated('Use hotThreadListResponseDataDescriptor instead')
const HotThreadListResponseData$json = {
  '1': 'HotThreadListResponseData',
  '2': [
    {
      '1': 'topicList',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.RecommendTopicList',
      '10': 'topicList'
    },
    {
      '1': 'threadInfo',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ThreadInfo',
      '10': 'threadInfo'
    },
    {
      '1': 'hotThreadTabInfo',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.FrsTabInfo',
      '10': 'hotThreadTabInfo'
    },
  ],
};

/// Descriptor for `HotThreadListResponseData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotThreadListResponseDataDescriptor = $convert.base64Decode(
    'ChlIb3RUaHJlYWRMaXN0UmVzcG9uc2VEYXRhEjEKCXRvcGljTGlzdBgBIAMoCzITLlJlY29tbW'
    'VuZFRvcGljTGlzdFIJdG9waWNMaXN0EisKCnRocmVhZEluZm8YAiADKAsyCy5UaHJlYWRJbmZv'
    'Ugp0aHJlYWRJbmZvEjcKEGhvdFRocmVhZFRhYkluZm8YAyADKAsyCy5GcnNUYWJJbmZvUhBob3'
    'RUaHJlYWRUYWJJbmZv');

@$core.Deprecated('Use hotThreadListResponseDescriptor instead')
const HotThreadListResponse$json = {
  '1': 'HotThreadListResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.HotThreadListResponseData',
      '10': 'data'
    },
  ],
};

/// Descriptor for `HotThreadListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotThreadListResponseDescriptor = $convert.base64Decode(
    'ChVIb3RUaHJlYWRMaXN0UmVzcG9uc2USHAoFZXJyb3IYASABKAsyBi5FcnJvclIFZXJyb3ISLg'
    'oEZGF0YRgCIAEoCzIaLkhvdFRocmVhZExpc3RSZXNwb25zZURhdGFSBGRhdGE=');
