// This is a generated file - do not edit.
//
// Generated from AddPollReqIdl.proto.

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

@$core.Deprecated('Use addPollReqIdlDescriptor instead')
const AddPollReqIdl$json = {
  '1': 'AddPollReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.AddPollReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [AddPollReqIdl_DataReq$json],
};

@$core.Deprecated('Use addPollReqIdlDescriptor instead')
const AddPollReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 4, '10': 'threadId'},
    {'1': 'options', '3': 2, '4': 1, '5': 9, '10': 'options'},
    {'1': 'common', '3': 3, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'forum_id', '3': 4, '4': 1, '5': 4, '10': 'forumId'},
  ],
};

/// Descriptor for `AddPollReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPollReqIdlDescriptor = $convert.base64Decode(
    'Cg1BZGRQb2xsUmVxSWRsEioKBGRhdGEYASABKAsyFi5BZGRQb2xsUmVxSWRsLkRhdGFSZXFSBG'
    'RhdGEafwoHRGF0YVJlcRIbCgl0aHJlYWRfaWQYASABKARSCHRocmVhZElkEhgKB29wdGlvbnMY'
    'AiABKAlSB29wdGlvbnMSIgoGY29tbW9uGAMgASgLMgouQ29tbW9uUmVxUgZjb21tb24SGQoIZm'
    '9ydW1faWQYBCABKARSB2ZvcnVtSWQ=');
