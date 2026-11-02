// This is a generated file - do not edit.
//
// Generated from RecommendTopicList.proto.

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

class RecommendTopicList extends $pb.GeneratedMessage {
  factory RecommendTopicList({
    $fixnum.Int64? topicId,
    $core.String? topicName,
    $core.int? type,
    $fixnum.Int64? discussNum,
    $core.int? tag,
    $core.String? topicDesc,
    $core.String? topicPic,
  }) {
    final result = RecommendTopicList._();
    if (topicId != null) result.topicId = topicId;
    if (topicName != null) result.topicName = topicName;
    if (type != null) result.type = type;
    if (discussNum != null) result.discussNum = discussNum;
    if (tag != null) result.tag = tag;
    if (topicDesc != null) result.topicDesc = topicDesc;
    if (topicPic != null) result.topicPic = topicPic;
    return result;
  }

  RecommendTopicList._();

  factory RecommendTopicList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecommendTopicList()..mergeFromBuffer(data, registry);
  factory RecommendTopicList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecommendTopicList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecommendTopicList',
      createEmptyInstance: RecommendTopicList.$_createMessage)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'topicId', $pb.PbFieldType.OU6,
        protoName: 'topicId', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'topicName', protoName: 'topicName')
    ..aI(3, _omitFieldNames ? '' : 'type', fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'discussNum', $pb.PbFieldType.OU6,
        protoName: 'discussNum', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(5, _omitFieldNames ? '' : 'tag', fieldType: $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'topicDesc', protoName: 'topicDesc')
    ..aOS(7, _omitFieldNames ? '' : 'topicPic', protoName: 'topicPic')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendTopicList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendTopicList copyWith(void Function(RecommendTopicList) updates) =>
      super.copyWith((message) => updates(message as RecommendTopicList))
          as RecommendTopicList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecommendTopicList() / RecommendTopicList.new instead')
  static RecommendTopicList create() => RecommendTopicList._();
  static $pb.GeneratedMessage $_createMessage() => RecommendTopicList._();
  @$core.override
  RecommendTopicList createEmptyInstance() => RecommendTopicList._();
  @$core.pragma('dart2js:noInline')
  static RecommendTopicList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecommendTopicList>(
          RecommendTopicList.$_createMessage);
  static RecommendTopicList? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get topicId => $_getI64(0);
  @$pb.TagNumber(1)
  set topicId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTopicId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopicId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get topicName => $_getSZ(1);
  @$pb.TagNumber(2)
  set topicName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTopicName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopicName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get type => $_getIZ(2);
  @$pb.TagNumber(3)
  set type($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get discussNum => $_getI64(3);
  @$pb.TagNumber(4)
  set discussNum($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDiscussNum() => $_has(3);
  @$pb.TagNumber(4)
  void clearDiscussNum() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get tag => $_getIZ(4);
  @$pb.TagNumber(5)
  set tag($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTag() => $_has(4);
  @$pb.TagNumber(5)
  void clearTag() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get topicDesc => $_getSZ(5);
  @$pb.TagNumber(6)
  set topicDesc($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTopicDesc() => $_has(5);
  @$pb.TagNumber(6)
  void clearTopicDesc() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get topicPic => $_getSZ(6);
  @$pb.TagNumber(7)
  set topicPic($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTopicPic() => $_has(6);
  @$pb.TagNumber(7)
  void clearTopicPic() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
