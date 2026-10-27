export 'account_init_types.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import '../core/blcp_crypto.dart';
import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../core/utils.dart';
import '_common.dart';
import 'account_init_types.dart';

/// Fetches the per-install client_id/sample_id pair and stores it on the account.
Future<TiebaSyncResult> fetchSync(TiebaHttpCore http) async {
  final json = await http.postForm(
    '/c/s/realtimeSync',
    <MapEntry<String, String>>[
      MapEntry<String, String>('BDUSS', http.account.bduss),
      MapEntry<String, String>('_client_version', TiebaConstants.latestVersion),
      MapEntry<String, String>('cuid', http.account.cuidGalaxy2),
    ],
  );
  ensureJsonOk(json);
  final client = json['client'];
  final wlConfig = json['wl_config'];
  if (client is! Map || wlConfig is! Map) {
    throw const TiebaFormatException('sync payload is incomplete');
  }
  final result = TiebaSyncResult(
    clientId: parseString(client['client_id']),
    sampleId: parseString(wlConfig['sample_id']),
  );
  http.account
    ..clientId = result.clientId
    ..sampleId = result.sampleId;
  return result;
}

/// Requests a BAIDUID cookie from the app API and stores it on the account.
Future<String?> fetchInitBaiduId(TiebaHttpCore http) async {
  final response = await http.postFormResponse(
    '/c/c/forum/statClientStartTimes',
    <MapEntry<String, String>>[const MapEntry<String, String>('type', '1')],
  );
  if (response.statusCode != 200) {
    throw TiebaHttpException(response.statusCode, 'init baidu id failed');
  }
  final json = response.json;
  ensureJsonOk(json);
  final cookie = response.setCookie ?? '';
  final match = RegExp(r'BAIDUID=([^;]+)').firstMatch(cookie);
  if (match == null) {
    throw const TiebaValueException('missing BAIDUID in response cookies');
  }
  final value = match.group(1)!;
  http.account.baiduId = value;
  return value;
}

/// Performs the sofire/zid handshake and stores the resulting device token.
Future<String> fetchInitZid(TiebaHttpCore http) async {
  const appKey = '200033';
  const secKey = 'ea737e4f435b53786043369d2e5ace4f';
  const host = 'sofire.baidu.com';
  final account = http.account;

  final deviceKey = md5
      .convert(ascii.encode(account.androidId + account.uuid))
      .toString()
      .toUpperCase();
  final xyus = '$deviceKey|0';
  final xyusMd5 = md5.convert(ascii.encode(xyus)).toString();
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final body = jsonEncode(<String, Object>{
    'module_section': <Object>[
      <String, String>{'zid': xyus},
    ],
  });
  final gzipBody = gzip.encode(utf8.encode(body));
  final encrypted = aesCbcEncrypt(account.zidSecKey, Uint8List(16), gzipBody);
  final payload = Uint8List(encrypted.length + 16)
    ..setAll(0, encrypted)
    ..setAll(encrypted.length, md5.convert(gzipBody).bytes);

  final pathCombineMd5 = md5
      .convert(ascii.encode(appKey + timestamp.toString() + secKey))
      .toString();
  final skey = '${base64.encode(rc4_42(xyusMd5, account.zidSecKey))}\n';
  final uri = Uri.https(
    host,
    '/c/11/z/100/$appKey/$timestamp/$pathCombineMd5',
    <String, String>{'skey': skey},
  );

  final response = await http.postRaw(
    uri,
    body: payload,
    contentType: 'application/x-www-form-urlencoded',
    headers: <String, String>{
      'x-device-id': xyusMd5,
      'User-Agent': 'x6/$appKey/${TiebaConstants.legacyVersion}/4.4.1.3',
      'x-plu-ver': 'x6/4.4.1.3',
      'Accept-Encoding': 'gzip',
    },
  );
  if (response.statusCode != 200) {
    throw TiebaHttpException(response.statusCode, 'zid request failed');
  }
  final json = response.json;
  final responseSkey = base64.decode(
    parseString(json['skey']).replaceAll(RegExp(r'\s'), ''),
  );
  final responseData = base64.decode(
    parseString(json['data']).replaceAll(RegExp(r'\s'), ''),
  );
  final aesKey = rc4_42(xyusMd5, responseSkey);
  final decrypted = aesCbcDecryptRaw(aesKey, Uint8List(16), responseData);
  final withoutMd5 = Uint8List.sublistView(decrypted, 0, decrypted.length - 16);
  final unpadded = pkcs7Unpad(withoutMd5);
  final decoded = const JsonDecoder().convert(utf8.decode(unpadded));
  if (decoded is! Map) {
    throw const TiebaFormatException('zid payload is incomplete');
  }
  final zid = parseString(decoded['token']);
  if (zid.isEmpty) {
    throw const TiebaFormatException('zid token is empty');
  }
  account.zid = zid;
  return zid;
}
