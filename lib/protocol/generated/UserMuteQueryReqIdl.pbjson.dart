// This is a generated file - do not edit.
//
// Generated from UserMuteQueryReqIdl.proto.

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

@$core.Deprecated('Use userMuteQueryReqIdlDescriptor instead')
const UserMuteQueryReqIdl$json = {
  '1': 'UserMuteQueryReqIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.UserMuteQueryReqIdl.DataReq',
      '10': 'data'
    },
  ],
  '3': [UserMuteQueryReqIdl_DataReq$json],
};

@$core.Deprecated('Use userMuteQueryReqIdlDescriptor instead')
const UserMuteQueryReqIdl_DataReq$json = {
  '1': 'DataReq',
  '2': [
    {'1': 'common', '3': 2, '4': 1, '5': 11, '6': '.CommonReq', '10': 'common'},
    {'1': 'pn', '3': 4, '4': 1, '5': 13, '10': 'pn'},
    {'1': 'rn', '3': 5, '4': 1, '5': 13, '10': 'rn'},
  ],
};

/// Descriptor for `UserMuteQueryReqIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMuteQueryReqIdlDescriptor = $convert.base64Decode(
    'ChNVc2VyTXV0ZVF1ZXJ5UmVxSWRsEjAKBGRhdGEYASABKAsyHC5Vc2VyTXV0ZVF1ZXJ5UmVxSW'
    'RsLkRhdGFSZXFSBGRhdGEaTQoHRGF0YVJlcRIiCgZjb21tb24YAiABKAsyCi5Db21tb25SZXFS'
    'BmNvbW1vbhIOCgJwbhgEIAEoDVICcG4SDgoCcm4YBSABKA1SAnJu');
