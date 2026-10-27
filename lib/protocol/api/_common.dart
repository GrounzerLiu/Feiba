import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/utils.dart';
import '../generated/generated.dart' as pb;

/// Builds the CommonReq block shared by protobuf requests.
pb.CommonReq buildCommon({
  String version = TiebaConstants.latestVersion,
  String? bduss,
}) {
  final common = pb.CommonReq()
    ..clientType = 2
    ..clientVersion = version;
  if (bduss != null && bduss.isNotEmpty) {
    common.bDUSS = bduss;
  }
  return common;
}

/// Throws when an app JSON response carries a non-zero error code.
void ensureJsonOk(Map<String, dynamic> json) {
  final code = parseInt(json['error_code']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error_msg']));
  }
  final error = json['error'];
  if (error is Map) {
    final subCode = parseInt(error['errno']);
    if (subCode != 0) {
      throw TiebaServerException(subCode, parseString(error['errmsg']));
    }
  }
  final errno = parseInt(json['errorno']);
  if (errno != 0) {
    throw TiebaServerException(errno, parseString(json['errmsg']));
  }
}

/// Throws when a web JSON response carries a non-zero error code.
void ensureWebOk(Map<String, dynamic> json) {
  final code = parseInt(json['no']);
  if (code != 0) {
    throw TiebaServerException(code, parseString(json['error']));
  }
  final error = json['error'];
  if (error is Map) {
    final subCode = parseInt(error['errno']);
    if (subCode != 0) {
      throw TiebaServerException(subCode, parseString(error['errmsg']));
    }
  }
  final errno = parseInt(json['errorno']);
  if (errno != 0) {
    throw TiebaServerException(errno, parseString(json['errmsg']));
  }
}
