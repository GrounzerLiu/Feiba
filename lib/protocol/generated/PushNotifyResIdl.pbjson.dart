// This is a generated file - do not edit.
//
// Generated from PushNotifyResIdl.proto.

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

@$core.Deprecated('Use pushNotifyResIdlDescriptor instead')
const PushNotifyResIdl$json = {
  '1': 'PushNotifyResIdl',
  '2': [
    {
      '1': 'multiMsg',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.PushNotifyResIdl.PusherMsg',
      '10': 'multiMsg'
    },
  ],
  '3': [PushNotifyResIdl_PusherMsg$json],
};

@$core.Deprecated('Use pushNotifyResIdlDescriptor instead')
const PushNotifyResIdl_PusherMsg$json = {
  '1': 'PusherMsg',
  '2': [
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.PushNotifyResIdl.PusherMsg.PusherMsgInfo',
      '10': 'data'
    },
  ],
  '3': [PushNotifyResIdl_PusherMsg_PusherMsgInfo$json],
};

@$core.Deprecated('Use pushNotifyResIdlDescriptor instead')
const PushNotifyResIdl_PusherMsg_PusherMsgInfo$json = {
  '1': 'PusherMsgInfo',
  '2': [
    {'1': 'groupId', '3': 1, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'msgId', '3': 2, '4': 1, '5': 3, '10': 'msgId'},
    {'1': 'type', '3': 4, '4': 1, '5': 5, '10': 'type'},
    {'1': 'et', '3': 6, '4': 1, '5': 9, '10': 'et'},
    {'1': 'groupType', '3': 7, '4': 1, '5': 5, '10': 'groupType'},
  ],
};

/// Descriptor for `PushNotifyResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushNotifyResIdlDescriptor = $convert.base64Decode(
    'ChBQdXNoTm90aWZ5UmVzSWRsEjcKCG11bHRpTXNnGAIgAygLMhsuUHVzaE5vdGlmeVJlc0lkbC'
    '5QdXNoZXJNc2dSCG11bHRpTXNnGs4BCglQdXNoZXJNc2cSPQoEZGF0YRgCIAEoCzIpLlB1c2hO'
    'b3RpZnlSZXNJZGwuUHVzaGVyTXNnLlB1c2hlck1zZ0luZm9SBGRhdGEagQEKDVB1c2hlck1zZ0'
    'luZm8SGAoHZ3JvdXBJZBgBIAEoA1IHZ3JvdXBJZBIUCgVtc2dJZBgCIAEoA1IFbXNnSWQSEgoE'
    'dHlwZRgEIAEoBVIEdHlwZRIOCgJldBgGIAEoCVICZXQSHAoJZ3JvdXBUeXBlGAcgASgFUglncm'
    '91cFR5cGU=');
