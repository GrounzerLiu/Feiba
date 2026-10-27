// This is a generated file - do not edit.
//
// Generated from GetForumDetailResIdl.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Error.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetForumDetailResIdl_DataRes_RecommendForumInfo
    extends $pb.GeneratedMessage {
  factory GetForumDetailResIdl_DataRes_RecommendForumInfo({
    $core.String? avatar,
    $fixnum.Int64? forumId,
    $core.String? forumName,
    $core.int? memberCount,
    $core.int? threadCount,
    $core.String? slogan,
    $core.String? lv1Name,
    $core.String? avatarOrigin,
  }) {
    final result = GetForumDetailResIdl_DataRes_RecommendForumInfo._();
    if (avatar != null) result.avatar = avatar;
    if (forumId != null) result.forumId = forumId;
    if (forumName != null) result.forumName = forumName;
    if (memberCount != null) result.memberCount = memberCount;
    if (threadCount != null) result.threadCount = threadCount;
    if (slogan != null) result.slogan = slogan;
    if (lv1Name != null) result.lv1Name = lv1Name;
    if (avatarOrigin != null) result.avatarOrigin = avatarOrigin;
    return result;
  }

  GetForumDetailResIdl_DataRes_RecommendForumInfo._();

  factory GetForumDetailResIdl_DataRes_RecommendForumInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes_RecommendForumInfo()
        ..mergeFromBuffer(data, registry);
  factory GetForumDetailResIdl_DataRes_RecommendForumInfo.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes_RecommendForumInfo()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetForumDetailResIdl.DataRes.RecommendForumInfo',
      createEmptyInstance:
          GetForumDetailResIdl_DataRes_RecommendForumInfo.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'avatar')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'forumId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'forumName')
    ..aI(5, _omitFieldNames ? '' : 'memberCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'threadCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(7, _omitFieldNames ? '' : 'slogan')
    ..aOS(18, _omitFieldNames ? '' : 'lv1Name')
    ..aOS(20, _omitFieldNames ? '' : 'avatarOrigin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes_RecommendForumInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes_RecommendForumInfo copyWith(
          void Function(GetForumDetailResIdl_DataRes_RecommendForumInfo)
              updates) =>
      super.copyWith((message) => updates(
              message as GetForumDetailResIdl_DataRes_RecommendForumInfo))
          as GetForumDetailResIdl_DataRes_RecommendForumInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailResIdl_DataRes_RecommendForumInfo() / GetForumDetailResIdl_DataRes_RecommendForumInfo.new instead')
  static GetForumDetailResIdl_DataRes_RecommendForumInfo create() =>
      GetForumDetailResIdl_DataRes_RecommendForumInfo._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumDetailResIdl_DataRes_RecommendForumInfo._();
  @$core.override
  GetForumDetailResIdl_DataRes_RecommendForumInfo createEmptyInstance() =>
      GetForumDetailResIdl_DataRes_RecommendForumInfo._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailResIdl_DataRes_RecommendForumInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetForumDetailResIdl_DataRes_RecommendForumInfo>(
          GetForumDetailResIdl_DataRes_RecommendForumInfo.$_createMessage);
  static GetForumDetailResIdl_DataRes_RecommendForumInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get avatar => $_getSZ(0);
  @$pb.TagNumber(1)
  set avatar($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAvatar() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvatar() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get forumId => $_getI64(1);
  @$pb.TagNumber(2)
  set forumId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForumId() => $_has(1);
  @$pb.TagNumber(2)
  void clearForumId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get forumName => $_getSZ(2);
  @$pb.TagNumber(3)
  set forumName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasForumName() => $_has(2);
  @$pb.TagNumber(3)
  void clearForumName() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.int get memberCount => $_getIZ(3);
  @$pb.TagNumber(5)
  set memberCount($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasMemberCount() => $_has(3);
  @$pb.TagNumber(5)
  void clearMemberCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get threadCount => $_getIZ(4);
  @$pb.TagNumber(6)
  set threadCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(6)
  $core.bool hasThreadCount() => $_has(4);
  @$pb.TagNumber(6)
  void clearThreadCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get slogan => $_getSZ(5);
  @$pb.TagNumber(7)
  set slogan($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasSlogan() => $_has(5);
  @$pb.TagNumber(7)
  void clearSlogan() => $_clearField(7);

  @$pb.TagNumber(18)
  $core.String get lv1Name => $_getSZ(6);
  @$pb.TagNumber(18)
  set lv1Name($core.String value) => $_setString(6, value);
  @$pb.TagNumber(18)
  $core.bool hasLv1Name() => $_has(6);
  @$pb.TagNumber(18)
  void clearLv1Name() => $_clearField(18);

  @$pb.TagNumber(20)
  $core.String get avatarOrigin => $_getSZ(7);
  @$pb.TagNumber(20)
  set avatarOrigin($core.String value) => $_setString(7, value);
  @$pb.TagNumber(20)
  $core.bool hasAvatarOrigin() => $_has(7);
  @$pb.TagNumber(20)
  void clearAvatarOrigin() => $_clearField(20);
}

class GetForumDetailResIdl_DataRes_ManagerElectionTab
    extends $pb.GeneratedMessage {
  factory GetForumDetailResIdl_DataRes_ManagerElectionTab({
    $core.String? newStrategyText,
  }) {
    final result = GetForumDetailResIdl_DataRes_ManagerElectionTab._();
    if (newStrategyText != null) result.newStrategyText = newStrategyText;
    return result;
  }

  GetForumDetailResIdl_DataRes_ManagerElectionTab._();

  factory GetForumDetailResIdl_DataRes_ManagerElectionTab.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes_ManagerElectionTab()
        ..mergeFromBuffer(data, registry);
  factory GetForumDetailResIdl_DataRes_ManagerElectionTab.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes_ManagerElectionTab()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetForumDetailResIdl.DataRes.ManagerElectionTab',
      createEmptyInstance:
          GetForumDetailResIdl_DataRes_ManagerElectionTab.$_createMessage)
    ..aOS(5, _omitFieldNames ? '' : 'newStrategyText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes_ManagerElectionTab clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes_ManagerElectionTab copyWith(
          void Function(GetForumDetailResIdl_DataRes_ManagerElectionTab)
              updates) =>
      super.copyWith((message) => updates(
              message as GetForumDetailResIdl_DataRes_ManagerElectionTab))
          as GetForumDetailResIdl_DataRes_ManagerElectionTab;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailResIdl_DataRes_ManagerElectionTab() / GetForumDetailResIdl_DataRes_ManagerElectionTab.new instead')
  static GetForumDetailResIdl_DataRes_ManagerElectionTab create() =>
      GetForumDetailResIdl_DataRes_ManagerElectionTab._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumDetailResIdl_DataRes_ManagerElectionTab._();
  @$core.override
  GetForumDetailResIdl_DataRes_ManagerElectionTab createEmptyInstance() =>
      GetForumDetailResIdl_DataRes_ManagerElectionTab._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailResIdl_DataRes_ManagerElectionTab getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetForumDetailResIdl_DataRes_ManagerElectionTab>(
          GetForumDetailResIdl_DataRes_ManagerElectionTab.$_createMessage);
  static GetForumDetailResIdl_DataRes_ManagerElectionTab? _defaultInstance;

  @$pb.TagNumber(5)
  $core.String get newStrategyText => $_getSZ(0);
  @$pb.TagNumber(5)
  set newStrategyText($core.String value) => $_setString(0, value);
  @$pb.TagNumber(5)
  $core.bool hasNewStrategyText() => $_has(0);
  @$pb.TagNumber(5)
  void clearNewStrategyText() => $_clearField(5);
}

class GetForumDetailResIdl_DataRes extends $pb.GeneratedMessage {
  factory GetForumDetailResIdl_DataRes({
    GetForumDetailResIdl_DataRes_RecommendForumInfo? forumInfo,
    GetForumDetailResIdl_DataRes_ManagerElectionTab? electionTab,
  }) {
    final result = GetForumDetailResIdl_DataRes._();
    if (forumInfo != null) result.forumInfo = forumInfo;
    if (electionTab != null) result.electionTab = electionTab;
    return result;
  }

  GetForumDetailResIdl_DataRes._();

  factory GetForumDetailResIdl_DataRes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes()..mergeFromBuffer(data, registry);
  factory GetForumDetailResIdl_DataRes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl_DataRes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumDetailResIdl.DataRes',
      createEmptyInstance: GetForumDetailResIdl_DataRes.$_createMessage)
    ..aOM<GetForumDetailResIdl_DataRes_RecommendForumInfo>(
        1, _omitFieldNames ? '' : 'forumInfo',
        subBuilder:
            GetForumDetailResIdl_DataRes_RecommendForumInfo.$_createMessage)
    ..aOM<GetForumDetailResIdl_DataRes_ManagerElectionTab>(
        8, _omitFieldNames ? '' : 'electionTab',
        subBuilder:
            GetForumDetailResIdl_DataRes_ManagerElectionTab.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl_DataRes copyWith(
          void Function(GetForumDetailResIdl_DataRes) updates) =>
      super.copyWith(
              (message) => updates(message as GetForumDetailResIdl_DataRes))
          as GetForumDetailResIdl_DataRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailResIdl_DataRes() / GetForumDetailResIdl_DataRes.new instead')
  static GetForumDetailResIdl_DataRes create() =>
      GetForumDetailResIdl_DataRes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetForumDetailResIdl_DataRes._();
  @$core.override
  GetForumDetailResIdl_DataRes createEmptyInstance() =>
      GetForumDetailResIdl_DataRes._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailResIdl_DataRes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumDetailResIdl_DataRes>(
          GetForumDetailResIdl_DataRes.$_createMessage);
  static GetForumDetailResIdl_DataRes? _defaultInstance;

  @$pb.TagNumber(1)
  GetForumDetailResIdl_DataRes_RecommendForumInfo get forumInfo => $_getN(0);
  @$pb.TagNumber(1)
  set forumInfo(GetForumDetailResIdl_DataRes_RecommendForumInfo value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasForumInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearForumInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  GetForumDetailResIdl_DataRes_RecommendForumInfo ensureForumInfo() =>
      $_ensure(0);

  @$pb.TagNumber(8)
  GetForumDetailResIdl_DataRes_ManagerElectionTab get electionTab => $_getN(1);
  @$pb.TagNumber(8)
  set electionTab(GetForumDetailResIdl_DataRes_ManagerElectionTab value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasElectionTab() => $_has(1);
  @$pb.TagNumber(8)
  void clearElectionTab() => $_clearField(8);
  @$pb.TagNumber(8)
  GetForumDetailResIdl_DataRes_ManagerElectionTab ensureElectionTab() =>
      $_ensure(1);
}

class GetForumDetailResIdl extends $pb.GeneratedMessage {
  factory GetForumDetailResIdl({
    $0.Error? error,
    GetForumDetailResIdl_DataRes? data,
  }) {
    final result = GetForumDetailResIdl._();
    if (error != null) result.error = error;
    if (data != null) result.data = data;
    return result;
  }

  GetForumDetailResIdl._();

  factory GetForumDetailResIdl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl()..mergeFromBuffer(data, registry);
  factory GetForumDetailResIdl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetForumDetailResIdl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetForumDetailResIdl',
      createEmptyInstance: GetForumDetailResIdl.$_createMessage)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.$_createMessage)
    ..aOM<GetForumDetailResIdl_DataRes>(2, _omitFieldNames ? '' : 'data',
        subBuilder: GetForumDetailResIdl_DataRes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetForumDetailResIdl copyWith(void Function(GetForumDetailResIdl) updates) =>
      super.copyWith((message) => updates(message as GetForumDetailResIdl))
          as GetForumDetailResIdl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetForumDetailResIdl() / GetForumDetailResIdl.new instead')
  static GetForumDetailResIdl create() => GetForumDetailResIdl._();
  static $pb.GeneratedMessage $_createMessage() => GetForumDetailResIdl._();
  @$core.override
  GetForumDetailResIdl createEmptyInstance() => GetForumDetailResIdl._();
  @$core.pragma('dart2js:noInline')
  static GetForumDetailResIdl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetForumDetailResIdl>(
          GetForumDetailResIdl.$_createMessage);
  static GetForumDetailResIdl? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($0.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  GetForumDetailResIdl_DataRes get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(GetForumDetailResIdl_DataRes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
  @$pb.TagNumber(2)
  GetForumDetailResIdl_DataRes ensureData() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
