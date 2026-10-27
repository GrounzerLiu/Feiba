// This is a generated file - do not edit.
//
// Generated from ReplyMeReqIdl.proto.

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

@$core.Deprecated('Use replyMeReqIdlDescriptor instead')
const ReplyMeReqIdl$json = {
  '1': 'ReplyMeReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.ReplyMeReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [ReplyMeReqIdl_DataReq$json],
};

@$core.Deprecated('Use replyMeReqIdlDescriptor instead')
const ReplyMeReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'pn', '3': 1, '4': 1, '5': 5, '10': 'pn'},
    {'1': 'common', '3': 3, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
  ],
};

/// Descriptor for `ReplyMeReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyMeReqIdlDescriptor = $convert.base64Decode(
    'Cg1SZXBseU1lUmVxSWRsEioKBGRhdGEYASABKAsyFi5SZXBseU1lUmVxSWRsLkRhdGFSZXFSBG'
    'RhdGEaPQoHRGF0YVJlcRIOCgJwbhgBIAEoBVICcG4SIgoGY29tbW9uGAMgASgLMgouQ29tbW9u'
    'UmVxUgZjb21tb24=');
