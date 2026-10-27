// This is a generated file - do not edit.
//
// Generated from GetGroupMsgResIdl.proto.

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

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl$json = {
  '1': 'GetGroupMsgResIdl',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
    {
      '1': 'data',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GetGroupMsgResIdl.DataRes',
      '10': 'data'
    },
  ],
  '3': [GetGroupMsgResIdl_DataRes$json],
};

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'groupInfo',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.GetGroupMsgResIdl.DataRes.GroupMsg',
      '10': 'groupInfo'
    },
  ],
  '3': [GetGroupMsgResIdl_DataRes_GroupMsg$json],
};

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl_DataRes_GroupMsg$json = {
  '1': 'GroupMsg',
  '2': [
    {
      '1': 'groupInfo',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetGroupMsgResIdl.DataRes.GroupMsg.GroupInfo',
      '10': 'groupInfo'
    },
    {
      '1': 'msgList',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.GetGroupMsgResIdl.DataRes.GroupMsg.MsgInfo',
      '10': 'msgList'
    },
  ],
  '3': [
    GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo$json,
    GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo$json
  ],
};

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl_DataRes_GroupMsg_GroupInfo$json = {
  '1': 'GroupInfo',
  '2': [
    {'1': 'groupId', '3': 1, '4': 1, '5': 3, '10': 'groupId'},
    {'1': 'groupType', '3': 20, '4': 1, '5': 5, '10': 'groupType'},
  ],
};

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo$json = {
  '1': 'MsgInfo',
  '2': [
    {'1': 'msgId', '3': 1, '4': 1, '5': 3, '10': 'msgId'},
    {'1': 'msgType', '3': 3, '4': 1, '5': 5, '10': 'msgType'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'createTime', '3': 8, '4': 1, '5': 5, '10': 'createTime'},
    {
      '1': 'userInfo',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.GetGroupMsgResIdl.DataRes.GroupMsg.MsgInfo.UserInfo',
      '10': 'userInfo'
    },
  ],
  '3': [GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo$json],
};

@$core.Deprecated('Use getGroupMsgResIdlDescriptor instead')
const GetGroupMsgResIdl_DataRes_GroupMsg_MsgInfo_UserInfo$json = {
  '1': 'UserInfo',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'userName', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'portrait', '3': 4, '4': 1, '5': 9, '10': 'portrait'},
  ],
};

/// Descriptor for `GetGroupMsgResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMsgResIdlDescriptor = $convert.base64Decode(
    'ChFHZXRHcm91cE1zZ1Jlc0lkbBIcCgVlcnJvchgBIAEoCzIGLkVycm9yUgVlcnJvchIuCgRkYX'
    'RhGAIgASgLMhouR2V0R3JvdXBNc2dSZXNJZGwuRGF0YVJlc1IEZGF0YRrWBAoHRGF0YVJlcxJB'
    'Cglncm91cEluZm8YASADKAsyIy5HZXRHcm91cE1zZ1Jlc0lkbC5EYXRhUmVzLkdyb3VwTXNnUg'
    'lncm91cEluZm8ahwQKCEdyb3VwTXNnEksKCWdyb3VwSW5mbxgBIAEoCzItLkdldEdyb3VwTXNn'
    'UmVzSWRsLkRhdGFSZXMuR3JvdXBNc2cuR3JvdXBJbmZvUglncm91cEluZm8SRQoHbXNnTGlzdB'
    'gCIAMoCzIrLkdldEdyb3VwTXNnUmVzSWRsLkRhdGFSZXMuR3JvdXBNc2cuTXNnSW5mb1IHbXNn'
    'TGlzdBpDCglHcm91cEluZm8SGAoHZ3JvdXBJZBgBIAEoA1IHZ3JvdXBJZBIcCglncm91cFR5cG'
    'UYFCABKAVSCWdyb3VwVHlwZRqhAgoHTXNnSW5mbxIUCgVtc2dJZBgBIAEoA1IFbXNnSWQSGAoH'
    'bXNnVHlwZRgDIAEoBVIHbXNnVHlwZRIYCgdjb250ZW50GAUgASgJUgdjb250ZW50Eh4KCmNyZW'
    'F0ZVRpbWUYCCABKAVSCmNyZWF0ZVRpbWUSUAoIdXNlckluZm8YCiABKAsyNC5HZXRHcm91cE1z'
    'Z1Jlc0lkbC5EYXRhUmVzLkdyb3VwTXNnLk1zZ0luZm8uVXNlckluZm9SCHVzZXJJbmZvGloKCF'
    'VzZXJJbmZvEhYKBnVzZXJJZBgBIAEoA1IGdXNlcklkEhoKCHVzZXJOYW1lGAIgASgJUgh1c2Vy'
    'TmFtZRIaCghwb3J0cmFpdBgEIAEoCVIIcG9ydHJhaXQ=');
