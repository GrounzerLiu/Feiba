// This is a generated file - do not edit.
//
// Generated from FrsPageReqIdl4lp.proto.

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

@$core.Deprecated('Use frsPageReqIdl4lpDescriptor instead')
const FrsPageReqIdl4lp$json = {
  '1': 'FrsPageReqIdl4lp',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.FrsPageReqIdl4lp.DataReq',
      '10': 'data'
    },
  ],
  '3': [FrsPageReqIdl4lp_DataReq$json],
};

@$core.Deprecated('Use frsPageReqIdl4lpDescriptor instead')
const FrsPageReqIdl4lp_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {
      '1': 'common',
      '3': 39,
      '4': 1,
      '5': 11,
      '6': '.CommonReq',
      '10': 'common'
    },
    {'1': 'kw', '3': 1, '4': 1, '5': 9, '10': 'kw'},
    {'1': 'rn', '3': 2, '4': 1, '5': 5, '10': 'rn'},
    {'1': 'rn_need', '3': 3, '4': 1, '5': 5, '10': 'rnNeed'},
    {'1': 'is_good', '3': 4, '4': 1, '5': 5, '10': 'isGood'},
    {'1': 'cid', '3': 5, '4': 1, '5': 5, '10': 'cid'},
    {'1': 'pn', '3': 15, '4': 1, '5': 5, '10': 'pn'},
    {'1': 'sort_type', '3': 47, '4': 1, '5': 5, '10': 'sortType'},
  ],
};

/// Descriptor for `FrsPageReqIdl4lp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frsPageReqIdl4lpDescriptor = $convert.base64Decode(
    'ChBGcnNQYWdlUmVxSWRsNGxwEi0KBGRhdGEYASABKAsyGS5GcnNQYWdlUmVxSWRsNGxwLkRhdG'
    'FSZXFSBGRhdGEavgEKB0RhdGFSZXESIgoGY29tbW9uGCcgASgLMgouQ29tbW9uUmVxUgZjb21t'
    'b24SDgoCa3cYASABKAlSAmt3Eg4KAnJuGAIgASgFUgJybhIXCgdybl9uZWVkGAMgASgFUgZybk'
    '5lZWQSFwoHaXNfZ29vZBgEIAEoBVIGaXNHb29kEhAKA2NpZBgFIAEoBVIDY2lkEg4KAnBuGA8g'
    'ASgFUgJwbhIbCglzb3J0X3R5cGUYLyABKAVSCHNvcnRUeXBl');
