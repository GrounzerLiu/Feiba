// This is a generated file - do not edit.
//
// Generated from ForumList.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ForumList extends $pb.GeneratedMessage {
  factory ForumList({
    $fixnum.Int64? forumId,
    $core.String? forumName,
    $core.int? memberCount,
    $fixnum.Int64? postNum,
    $fixnum.Int64? threadNum,
  }) {
    final result = ForumList._();
    if (forumId != null) result.forumId = forumId;
    if (forumName != null) result.forumName = forumName;
    if (memberCount != null) result.memberCount = memberCount;
    if (postNum != null) result.postNum = postNum;
    if (threadNum != null) result.threadNum = threadNum;
    return result;
  }

  ForumList._();

  factory ForumList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForumList()..mergeFromBuffer(data, registry);
  factory ForumList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForumList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForumList',
      createEmptyInstance: ForumList.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'forumId')
    ..aOS(2, _omitFieldNames ? '' : 'forumName')
    ..aI(4, _omitFieldNames ? '' : 'memberCount')
    ..aInt64(7, _omitFieldNames ? '' : 'postNum')
    ..aInt64(8, _omitFieldNames ? '' : 'threadNum')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForumList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForumList copyWith(void Function(ForumList) updates) =>
      super.copyWith((message) => updates(message as ForumList)) as ForumList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ForumList() / ForumList.new instead')
  static ForumList create() => ForumList._();
  static $pb.GeneratedMessage $_createMessage() => ForumList._();
  @$core.override
  ForumList createEmptyInstance() => ForumList._();
  @$core.pragma('dart2js:noInline')
  static ForumList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForumList>(ForumList.$_createMessage);
  static ForumList? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get forumId => $_getI64(0);
  @$pb.TagNumber(1)
  set forumId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasForumId() => $_has(0);
  @$pb.TagNumber(1)
  void clearForumId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get forumName => $_getSZ(1);
  @$pb.TagNumber(2)
  set forumName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForumName() => $_has(1);
  @$pb.TagNumber(2)
  void clearForumName() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.int get memberCount => $_getIZ(2);
  @$pb.TagNumber(4)
  set memberCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasMemberCount() => $_has(2);
  @$pb.TagNumber(4)
  void clearMemberCount() => $_clearField(4);

  @$pb.TagNumber(7)
  $fixnum.Int64 get postNum => $_getI64(3);
  @$pb.TagNumber(7)
  set postNum($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(7)
  $core.bool hasPostNum() => $_has(3);
  @$pb.TagNumber(7)
  void clearPostNum() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get threadNum => $_getI64(4);
  @$pb.TagNumber(8)
  set threadNum($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(8)
  $core.bool hasThreadNum() => $_has(4);
  @$pb.TagNumber(8)
  void clearThreadNum() => $_clearField(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
