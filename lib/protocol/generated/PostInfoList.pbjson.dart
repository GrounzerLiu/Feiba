// This is a generated file - do not edit.
//
// Generated from PostInfoList.proto.

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

@$core.Deprecated('Use postInfoListDescriptor instead')
const PostInfoList$json = {
  '1': 'PostInfoList',
  '2': [
    {'1': 'forum_id', '3': 1, '4': 1, '5': 4, '10': 'forumId'},
    {'1': 'thread_id', '3': 2, '4': 1, '5': 4, '10': 'threadId'},
    {'1': 'post_id', '3': 3, '4': 1, '5': 4, '10': 'postId'},
    {'1': 'create_time', '3': 5, '4': 1, '5': 13, '10': 'createTime'},
    {'1': 'forum_name', '3': 6, '4': 1, '5': 9, '10': 'forumName'},
    {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'content',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.PostInfoList.PostInfoContent',
      '10': 'content'
    },
    {'1': 'user_name', '3': 10, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'media', '3': 16, '4': 3, '5': 11, '6': '.Media', '10': 'media'},
    {'1': 'reply_num', '3': 17, '4': 1, '5': 13, '10': 'replyNum'},
    {'1': 'user_id', '3': 18, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'user_portrait', '3': 19, '4': 1, '5': 9, '10': 'userPortrait'},
    {
      '1': 'voice_info',
      '3': 23,
      '4': 3,
      '5': 11,
      '6': '.Voice',
      '10': 'voiceInfo'
    },
    {'1': 'thread_type', '3': 26, '4': 1, '5': 4, '10': 'threadType'},
    {
      '1': 'poll_info',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.PollInfo',
      '10': 'pollInfo'
    },
    {
      '1': 'video_info',
      '3': 29,
      '4': 1,
      '5': 11,
      '6': '.VideoInfo',
      '10': 'videoInfo'
    },
    {'1': 'freq_num', '3': 33, '4': 1, '5': 5, '10': 'freqNum'},
    {'1': 'name_show', '3': 35, '4': 1, '5': 9, '10': 'nameShow'},
    {'1': 'share_num', '3': 39, '4': 1, '5': 5, '10': 'shareNum'},
    {'1': 'agree', '3': 40, '4': 1, '5': 11, '6': '.Agree', '10': 'agree'},
    {'1': 'is_share_thread', '3': 44, '4': 1, '5': 5, '10': 'isShareThread'},
    {
      '1': 'first_post_content',
      '3': 49,
      '4': 3,
      '5': 11,
      '6': '.PbContent',
      '10': 'firstPostContent'
    },
  ],
  '3': [PostInfoList_PostInfoContent$json],
};

@$core.Deprecated('Use postInfoListDescriptor instead')
const PostInfoList_PostInfoContent$json = {
  '1': 'PostInfoContent',
  '2': [
    {
      '1': 'post_content',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.PostInfoList.PostInfoContent.Abstract',
      '10': 'postContent'
    },
    {'1': 'create_time', '3': 2, '4': 1, '5': 4, '10': 'createTime'},
    {'1': 'post_type', '3': 3, '4': 1, '5': 4, '10': 'postType'},
    {'1': 'post_id', '3': 4, '4': 1, '5': 4, '10': 'postId'},
  ],
  '3': [PostInfoList_PostInfoContent_Abstract$json],
};

@$core.Deprecated('Use postInfoListDescriptor instead')
const PostInfoList_PostInfoContent_Abstract$json = {
  '1': 'Abstract',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 5, '10': 'type'},
    {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    {'1': 'link', '3': 3, '4': 1, '5': 9, '10': 'link'},
    {'1': 'src', '3': 4, '4': 1, '5': 9, '10': 'src'},
    {'1': 'un', '3': 5, '4': 1, '5': 9, '10': 'un'},
    {'1': 'during_time', '3': 6, '4': 1, '5': 9, '10': 'duringTime'},
    {'1': 'voice_md5', '3': 7, '4': 1, '5': 9, '10': 'voiceMd5'},
  ],
};

/// Descriptor for `PostInfoList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postInfoListDescriptor = $convert.base64Decode(
    'CgxQb3N0SW5mb0xpc3QSGQoIZm9ydW1faWQYASABKARSB2ZvcnVtSWQSGwoJdGhyZWFkX2lkGA'
    'IgASgEUgh0aHJlYWRJZBIXCgdwb3N0X2lkGAMgASgEUgZwb3N0SWQSHwoLY3JlYXRlX3RpbWUY'
    'BSABKA1SCmNyZWF0ZVRpbWUSHQoKZm9ydW1fbmFtZRgGIAEoCVIJZm9ydW1OYW1lEhQKBXRpdG'
    'xlGAcgASgJUgV0aXRsZRI3Cgdjb250ZW50GAggAygLMh0uUG9zdEluZm9MaXN0LlBvc3RJbmZv'
    'Q29udGVudFIHY29udGVudBIbCgl1c2VyX25hbWUYCiABKAlSCHVzZXJOYW1lEhwKBW1lZGlhGB'
    'AgAygLMgYuTWVkaWFSBW1lZGlhEhsKCXJlcGx5X251bRgRIAEoDVIIcmVwbHlOdW0SFwoHdXNl'
    'cl9pZBgSIAEoA1IGdXNlcklkEiMKDXVzZXJfcG9ydHJhaXQYEyABKAlSDHVzZXJQb3J0cmFpdB'
    'IlCgp2b2ljZV9pbmZvGBcgAygLMgYuVm9pY2VSCXZvaWNlSW5mbxIfCgt0aHJlYWRfdHlwZRga'
    'IAEoBFIKdGhyZWFkVHlwZRImCglwb2xsX2luZm8YHCABKAsyCS5Qb2xsSW5mb1IIcG9sbEluZm'
    '8SKQoKdmlkZW9faW5mbxgdIAEoCzIKLlZpZGVvSW5mb1IJdmlkZW9JbmZvEhkKCGZyZXFfbnVt'
    'GCEgASgFUgdmcmVxTnVtEhsKCW5hbWVfc2hvdxgjIAEoCVIIbmFtZVNob3cSGwoJc2hhcmVfbn'
    'VtGCcgASgFUghzaGFyZU51bRIcCgVhZ3JlZRgoIAEoCzIGLkFncmVlUgVhZ3JlZRImCg9pc19z'
    'aGFyZV90aHJlYWQYLCABKAVSDWlzU2hhcmVUaHJlYWQSOAoSZmlyc3RfcG9zdF9jb250ZW50GD'
    'EgAygLMgouUGJDb250ZW50UhBmaXJzdFBvc3RDb250ZW50GtwCCg9Qb3N0SW5mb0NvbnRlbnQS'
    'SQoMcG9zdF9jb250ZW50GAEgAygLMiYuUG9zdEluZm9MaXN0LlBvc3RJbmZvQ29udGVudC5BYn'
    'N0cmFjdFILcG9zdENvbnRlbnQSHwoLY3JlYXRlX3RpbWUYAiABKARSCmNyZWF0ZVRpbWUSGwoJ'
    'cG9zdF90eXBlGAMgASgEUghwb3N0VHlwZRIXCgdwb3N0X2lkGAQgASgEUgZwb3N0SWQapgEKCE'
    'Fic3RyYWN0EhIKBHR5cGUYASABKAVSBHR5cGUSEgoEdGV4dBgCIAEoCVIEdGV4dBISCgRsaW5r'
    'GAMgASgJUgRsaW5rEhAKA3NyYxgEIAEoCVIDc3JjEg4KAnVuGAUgASgJUgJ1bhIfCgtkdXJpbm'
    'dfdGltZRgGIAEoCVIKZHVyaW5nVGltZRIbCgl2b2ljZV9tZDUYByABKAlSCHZvaWNlTWQ1');
