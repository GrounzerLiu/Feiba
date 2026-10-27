/// Login APIs of the chat/IM subsystem.
///
/// Ported from aiotieba's `get_lcm_token`, `login_blcp_lcm`,
/// `login_blcp_im` and `login_blcp_cloud_ctrl` (Unlicense).
///
/// Typical sequence:
///
/// 1. [fetchLcmToken] over HTTP.
/// 2. `BlcpCore.connect()`.
/// 3. [loginBlcpLcm] - LCP handshake, returns the heartbeat interval.
/// 4. [loginBlcpCloudCtrl] - optional cloud configuration login.
/// 5. [loginBlcpIm] - IM login, fills `account.uk/bduk/triggerId`.
library;

import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../core/blcp/blcp_crypto.dart';
import '../core/blcp/constants.dart';
import '../core/blcp/core.dart';
import '../core/blcp/enums.dart';
import '../core/blcp/exceptions.dart';
import '../core/blcp/packet.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '../models/chat_login.dart';

Uri _pimUri(String path) =>
    Uri(scheme: 'https', host: 'pim.baidu.com', path: path);

Map<String, String> get _pimHeaders => const <String, String>{
  'Accept-Encoding': 'gzip',
  'User-Agent': 'okhttp/3.11.0',
};

Map<String, dynamic> _decodeJson(List<int> bytes) {
  final decoded = jsonDecode(utf8.decode(bytes, allowMalformed: true));
  if (decoded is Map<String, dynamic>) return decoded;
  if (decoded is Map) return decoded.cast<String, dynamic>();
  throw const TiebaFormatException('unexpected JSON payload');
}

/// Requests an LCP token from `pim.baidu.com`.
///
/// The token is required by [loginBlcpLcm]. Mirrors `get_lcm_token`.
Future<String> fetchLcmToken(
  TiebaHttpCore http, {
  String appVersion = chatVersion,
}) async {
  final account = http.account;
  final cuid = account.cuidGalaxy2;
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final signature = md5
      .convert(utf8.encode('$chatAppId${cuid}android$timestamp'))
      .toString();

  final body = <String, dynamic>{
    'app_id': '$chatAppId',
    'app_version': appVersion,
    'cuid': cuid,
    'device_type': 'android',
    'manufacture': '',
    'model_type': '',
    'request_id': '$timestamp',
    'sdk_version': lcpSdkVersion,
    'sign': signature,
    'ts': timestamp,
    'user_key': '',
  };

  final response = await http.postRaw(
    _pimUri('/rest/5.0/generate_lcm_token'),
    body: utf8.encode(jsonEncode(body)),
    headers: _pimHeaders,
    contentType: 'application/json',
  );
  final json = _decodeJson(response.body);
  final token = parseString(json['token']);
  if (token.isEmpty) {
    throw const TiebaFormatException('lcm token missing from response');
  }
  return token;
}

/// Performs the LCM login (LCP handshake).
///
/// Returns the heartbeat interval requested by the server, in milliseconds.
Future<int> loginBlcpLcm(BlcpCore core, String token) async {
  final correlationId = randomCorrelationId();
  final body = LcmBody.login(
    logId: correlationId,
    token: token,
    timestamp: DateTime.now().millisecondsSinceEpoch,
    cuid: core.account.cuidGalaxy2,
    appId: chatAppId,
    appVersion: chatVersion,
    sdkVersion: lcpSdkVersion,
  );
  final request = BlcpRequest.create(
    BlcpServiceId.lcm.value,
    BlcpMethodId.login.value,
    body: body,
    correlationId: correlationId,
  );
  final response = await core.send(request);
  if (!response.ok) {
    throw BlcpLoginException(
      'LCP handshake failed: ${response.describeError()}',
    );
  }
  final lcm = response.lcm;
  if (lcm == null) {
    throw const BlcpLoginException('LCP handshake returned no control body');
  }
  return lcm.nextIntervalMs.toInt();
}

/// Performs the cloud-control login.
///
/// This is an optional configuration channel; it depends on
/// [enuid] (the `BB64` device identifier), which is ported from the
/// decompiled client and is the least verified part of the chat port.
Future<void> loginBlcpCloudCtrl(BlcpCore core) async {
  final account = core.account;
  final requestData = <String, dynamic>{
    'params': <String, dynamic>{
      'appname': 'tieba',
      'sid': account.sampleId,
      'ua': '900_1600_android_12.68.1.0_240',
      'uid': enuid(account.cuidGalaxy2),
      'cfrom': '1008550l',
      'from': '1008550l',
      'network': '1_-1',
      'p_sv': '32',
      'mps': '',
      'mpv': '1',
      'c3_aid': account.c3Aid,
      'type_id': '0',
    },
    'filter': <String, dynamic>{
      'aps': <String, dynamic>{'cpu_abi': 'armeabi-v7a'},
      'command': <String, dynamic>{'step': '0'},
    },
  };
  final request = BlcpRequest.create(
    BlcpServiceId.cloudControl.value,
    BlcpMethodId.login.value,
    body: JsonBody(requestData),
  );
  final response = await core.send(request);
  if (response.errorCode != 0) {
    throw BlcpLoginException(
      'cloud control login failed: ${response.describeError()}',
    );
  }
  final errno = parseInt(response.payload['errno']);
  if (errno != 0) {
    throw BlcpLoginException('cloud control login failed errno=$errno');
  }
}

/// Performs the IM login and stores the chat identity on [core]'s account.
///
/// Fills `account.bduk`, `account.uk` and `account.triggerId`.
Future<LoginImResult> loginBlcpIm(BlcpCore core) async {
  final account = core.account;
  final requestData = <String, dynamic>{
    'method': BlcpMethodId.loginByToken.value,
    'appid': chatAppId,
    'device_id': 'android_${account.cuidGalaxy2}',
    'account_type': 1,
    'token': account.bduss,
    'version': 4,
    'sdk_version': chatSdkVersion,
    'app_version': chatVersion,
    'app_open_type': 0,
    'client_identifier': jsonEncode(<String, dynamic>{
      'zid': '',
      'version_code': '',
    }),
    'tail': 0,
    'timeout': 10,
    'cookie': '',
    'device_info': <String, dynamic>{
      'app_version': chatVersion,
      'os_version': '32',
      'platform': 'android',
      'appid': '$chatAppId',
      'from': '1008550l',
      'cfrom': '1008550l',
    },
    'rpc': jsonEncode(<String, dynamic>{'rpc_retry_time': 0}),
    'user_type': 0,
    'client_logid': DateTime.now().microsecondsSinceEpoch,
  };

  final request = BlcpRequest.create(
    BlcpServiceId.im.value,
    BlcpMethodId.loginByToken.value,
    body: JsonBody(requestData),
  );
  final response = await core.send(request);
  if (response.errorCode != 0) {
    throw BlcpLoginException('IM login failed: ${response.describeError()}');
  }
  final payload = response.payload;
  final errCode = parseInt(payload['err_code']);
  if (errCode != 0) {
    throw BlcpLoginException('IM login failed err_code=$errCode');
  }

  final result = LoginImResult.fromJson(payload);
  account
    ..uk = result.uk
    ..bduk = result.bduk
    ..triggerId = result.triggerId;
  return result;
}
