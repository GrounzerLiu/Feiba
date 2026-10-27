import 'dart:convert';

import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/bawu_enums.dart';
import '../models/bawu_info.dart';
import '../models/bawu_member.dart';
import '_common.dart';
import 'bawu_common.dart';

/// Adds a moderator to a forum.
///
/// [userName] must be the user name, not the nickname and not the portrait;
/// resolve it with the user-info API first when only an id is available.
/// [bawuType] defaults to the assistant moderator role.
Future<void> addBawu(
  TiebaHttpCore http, {
  required int fid,
  required String userName,
  BawuType bawuType = BawuType.manager,
}) async {
  final json = await http.webPostForm(
    '/mo/q/bawuteamadd',
    <MapEntry<String, String>>[
      const MapEntry<String, String>('fn', '-'),
      MapEntry<String, String>('fid', '$fid'),
      MapEntry<String, String>('team_un', userName),
      MapEntry<String, String>('type', bawuType.value),
      MapEntry<String, String>('tbs', requireTbs(http)),
    ],
  );
  ensureWebOk(json);
}

/// Removes a moderator from a forum.
///
/// [portrait] must be the user portrait; resolve it with the user-info API
/// first when only an id is available.
Future<void> delBawu(
  TiebaHttpCore http, {
  required int fid,
  required String portrait,
  BawuType bawuType = BawuType.manager,
}) async {
  final json = await http.webPostForm(
    '/mo/q/bawuteamclear',
    <MapEntry<String, String>>[
      const MapEntry<String, String>('fn', '-'),
      MapEntry<String, String>('fid', '$fid'),
      const MapEntry<String, String>('team_un', '-'),
      MapEntry<String, String>('team_uid', portrait),
      MapEntry<String, String>('bawu_type', bawuType.value),
    ],
  );
  ensureWebOk(json);
}

/// Fetches the moderator team of a forum, grouped by role.
Future<BawuTeamInfo> fetchBawuInfo(
  TiebaHttpCore http, {
  required int fid,
}) async {
  final request = pb.GetBawuInfoReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.fid = Int64(fid);

  final bytes = await http.postProto(
    '/c/f/forum/getBawuInfo',
    301007,
    request.writeToBuffer(),
  );
  final response = pb.GetBawuInfoResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return BawuTeamInfo.fromProto(response.data);
}

/// Fetches one page of the moderator-backend member list.
///
/// [searchValue] filters the list by user name when it is not empty. The
/// endpoint requires a logged-in account with STOKEN.
Future<BawuMemberList> fetchBawuMemberlist(
  TiebaHttpCore http, {
  required String fname,
  int pn = 1,
  String searchValue = '',
}) async {
  final query = <String, String>{'word': fname, 'pn': '$pn', 'ie': 'utf-8'};
  if (searchValue.isNotEmpty) {
    query['svalue'] = searchValue;
    query['stype'] = 'uname';
  }
  final bytes = await http.webGetBytes(
    '/bawu2/platform/listMember',
    query: query,
  );
  return BawuMemberList.fromHtml(utf8.decode(bytes, allowMalformed: true));
}
