// This is a generated file - do not edit.
//
// Generated from GetBawuInfoResIdl.proto.

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

@$core.Deprecated('Use getBawuInfoResIdlDescriptor instead')
const GetBawuInfoResIdl$json = {
  '1': 'GetBawuInfoResIdl',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetBawuInfoResIdl.DataRes',
      '10': 'data'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.Error', '10': 'error'},
  ],
  '3': [GetBawuInfoResIdl_DataRes$json],
};

@$core.Deprecated('Use getBawuInfoResIdlDescriptor instead')
const GetBawuInfoResIdl_DataRes$json = {
  '1': 'DataRes',
  '2': [
    {
      '1': 'bawu_team_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GetBawuInfoResIdl.DataRes.BawuTeam',
      '10': 'bawuTeamInfo'
    },
  ],
  '3': [GetBawuInfoResIdl_DataRes_BawuTeam$json],
};

@$core.Deprecated('Use getBawuInfoResIdlDescriptor instead')
const GetBawuInfoResIdl_DataRes_BawuTeam$json = {
  '1': 'BawuTeam',
  '2': [
    {'1': 'total_num', '3': 1, '4': 1, '5': 5, '10': 'totalNum'},
    {
      '1': 'bawu_team_list',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.GetBawuInfoResIdl.DataRes.BawuTeam.BawuRoleDes',
      '10': 'bawuTeamList'
    },
  ],
  '3': [GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes$json],
};

@$core.Deprecated('Use getBawuInfoResIdlDescriptor instead')
const GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes$json = {
  '1': 'BawuRoleDes',
  '2': [
    {'1': 'role_name', '3': 1, '4': 1, '5': 9, '10': 'roleName'},
    {
      '1': 'role_info',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.GetBawuInfoResIdl.DataRes.BawuTeam.BawuRoleDes.BawuRoleInfoPub',
      '10': 'roleInfo'
    },
  ],
  '3': [GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub$json],
};

@$core.Deprecated('Use getBawuInfoResIdlDescriptor instead')
const GetBawuInfoResIdl_DataRes_BawuTeam_BawuRoleDes_BawuRoleInfoPub$json = {
  '1': 'BawuRoleInfoPub',
  '2': [
    {'1': 'user_id', '3': 2, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'role_name', '3': 4, '4': 1, '5': 9, '10': 'roleName'},
    {'1': 'portrait', '3': 5, '4': 1, '5': 9, '10': 'portrait'},
    {'1': 'user_level', '3': 6, '4': 1, '5': 5, '10': 'userLevel'},
    {'1': 'user_name', '3': 8, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'name_show', '3': 9, '4': 1, '5': 9, '10': 'nameShow'},
  ],
};

/// Descriptor for `GetBawuInfoResIdl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBawuInfoResIdlDescriptor = $convert.base64Decode(
    'ChFHZXRCYXd1SW5mb1Jlc0lkbBIuCgRkYXRhGAEgASgLMhouR2V0QmF3dUluZm9SZXNJZGwuRG'
    'F0YVJlc1IEZGF0YRIcCgVlcnJvchgCIAEoCzIGLkVycm9yUgVlcnJvchqfBAoHRGF0YVJlcxJJ'
    'Cg5iYXd1X3RlYW1faW5mbxgBIAEoCzIjLkdldEJhd3VJbmZvUmVzSWRsLkRhdGFSZXMuQmF3dV'
    'RlYW1SDGJhd3VUZWFtSW5mbxrIAwoIQmF3dVRlYW0SGwoJdG90YWxfbnVtGAEgASgFUgh0b3Rh'
    'bE51bRJVCg5iYXd1X3RlYW1fbGlzdBgCIAMoCzIvLkdldEJhd3VJbmZvUmVzSWRsLkRhdGFSZX'
    'MuQmF3dVRlYW0uQmF3dVJvbGVEZXNSDGJhd3VUZWFtTGlzdBrHAgoLQmF3dVJvbGVEZXMSGwoJ'
    'cm9sZV9uYW1lGAEgASgJUghyb2xlTmFtZRJcCglyb2xlX2luZm8YAiADKAsyPy5HZXRCYXd1SW'
    '5mb1Jlc0lkbC5EYXRhUmVzLkJhd3VUZWFtLkJhd3VSb2xlRGVzLkJhd3VSb2xlSW5mb1B1YlII'
    'cm9sZUluZm8avAEKD0Jhd3VSb2xlSW5mb1B1YhIXCgd1c2VyX2lkGAIgASgDUgZ1c2VySWQSGw'
    'oJcm9sZV9uYW1lGAQgASgJUghyb2xlTmFtZRIaCghwb3J0cmFpdBgFIAEoCVIIcG9ydHJhaXQS'
    'HQoKdXNlcl9sZXZlbBgGIAEoBVIJdXNlckxldmVsEhsKCXVzZXJfbmFtZRgIIAEoCVIIdXNlck'
    '5hbWUSGwoJbmFtZV9zaG93GAkgASgJUghuYW1lU2hvdw==');
