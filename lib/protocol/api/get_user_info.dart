import 'package:fixnum/fixnum.dart';

import '../core/constants.dart';
import '../core/exceptions.dart';
import '../generated/generated.dart' as pb;
import '../core/http_core.dart';
import '../models/user.dart';
import '_common.dart';

/// Fetches a user profile by user id or portrait.
///
/// Exactly one of [userId] and [portrait] must be provided.
Future<TiebaUser?> fetchUserInfo(
  TiebaHttpCore http, {
  int? userId,
  String? portrait,
}) async {
  if ((userId == null) == (portrait == null)) {
    throw const TiebaValueException(
      'provide exactly one of userId or portrait',
    );
  }
  final request = pb.ProfileReqIdl();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.latestVersion);
  data.needPostCount = 1;
  data.page = 1;
  if (userId != null) {
    data.uid = Int64(userId);
  } else {
    data.friendUidPortrait = portrait!;
  }

  final bytes = await http.postProto(
    '/c/u/user/profile',
    303012,
    request.writeToBuffer(),
  );
  final response = pb.ProfileResIdl.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return parseProfileUser(response.data);
}

/// Parses the profile user block shared by the profile and homepage APIs.
TiebaUser? parseProfileUser(pb.ProfileResIdl_DataRes data) {
  final proto = data.user;
  if (proto.id.toInt() == 0) return null;
  final user = TiebaUser.fromProto(proto)
    ..agreeNum = data.userAgreeInfo.totalAgreeNum.toInt();
  final anti = data.antiStat;
  user.isBlocked =
      anti.blockStat != 0 && anti.hideStat != 0 && anti.daysTofree > 30;
  return user;
}
