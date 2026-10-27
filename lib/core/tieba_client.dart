import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'session.dart';

/// Protocol constants of the Baidu Tieba client API.
///
/// The protocol facts (endpoints, parameter names, signature algorithm) are
/// publicly known reverse-engineered knowledge. Implemented from scratch here.
class TiebaProtocol {
  TiebaProtocol._();

  /// Shared secret used by the official Android client to sign form requests.
  static const String appSecret = 'tiebaclient!!!';
  static const String clientVersion = '8.2.2';
  static const String clientType = '2';
  static const String userAgent = 'bdtb for Android 8.2.2';
  static const String mobileWebUserAgent =
      'Mozilla/5.0 (Linux; Android 14; PLQ110) AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/131.0.0.0 Mobile Safari/537.36';
  static const String clientBase = 'http://c.tieba.baidu.com';
  static const String from = 'baidu_appstore';
}

/// Computes the request signature: md5 of (sorted "k=v" pairs + appSecret).
String tiebaSign(Map<String, String> params) {
  final entries =
      params.entries.map((e) => '${e.key}=${e.value}').toList()..sort();
  return md5.convert(utf8.encode(entries.join('') + TiebaProtocol.appSecret)).toString();
}

class TiebaApiException implements Exception {
  TiebaApiException(this.code, this.message);

  final int code;
  final String message;

  @override
  String toString() => 'TiebaApiException($code, $message)';
}

/// Thin transport layer for the Tieba client API.
class TiebaClient {
  TiebaClient({Dio? dio, this.cuid = 'A1B2C3D4E5F6', this.bduss, this.stoken})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: TiebaProtocol.clientBase,
              connectTimeout: const Duration(seconds: 20),
              receiveTimeout: const Duration(seconds: 20),
              responseType: ResponseType.plain,
              validateStatus: (_) => true,
            ));

  final Dio _dio;
  final String cuid;
  String? bduss;
  String? stoken;

  /// Posts a signed form request and decodes the JSON envelope.
  Future<Map<String, dynamic>> post(
    String path, [
    Map<String, String> fields = const {},
  ]) async {
    final params = <String, String>{
      '_client_type': TiebaProtocol.clientType,
      '_client_version': TiebaProtocol.clientVersion,
      '_client_id': 'wappc_${DateTime.now().millisecondsSinceEpoch}_001',
      '_os_version': '30',
      '_phone_imei': '000000000000000',
      '_timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'model': 'PLQ110',
      'net_type': '1',
      'from': TiebaProtocol.from,
      'cuid': cuid,
      'scr_dip': '2.75',
      'scr_h': '2400',
      'scr_w': '1080',
      ...fields,
    };
    final String? bdussValue = bduss ?? Session.instance.bduss;
    if (bdussValue != null && bdussValue.isNotEmpty) params['BDUSS'] = bdussValue;
    final String? stokenValue = stoken ?? Session.instance.stoken;
    if (stokenValue != null && stokenValue.isNotEmpty) params['stoken'] = stokenValue;
    params['sign'] = tiebaSign(params);

    final body = params.entries
        .map((e) =>
            '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
        .join('&');

    final response = await _dio.post<String>(
      path,
      data: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'User-Agent': TiebaProtocol.userAgent,
          'Cookie': 'ka=open',
        },
      ),
    );

    final raw = response.data ?? '';
    if (raw.isEmpty) {
      throw TiebaApiException(-1, 'empty response (http ${response.statusCode})');
    }
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw TiebaApiException(-2, 'unexpected payload');
    }
    final code = (decoded['error_code'] as num?)?.toInt() ?? 0;
    if (code != 0) {
      throw TiebaApiException(code, (decoded['error_msg'] ?? '').toString());
    }
    return decoded;
  }

  /// GET request against the mobile web host, decoded as JSON.
  Future<Map<String, dynamic>> webGetJson(
    String path, [
    Map<String, String> query = const <String, String>{},
    String? referer,
  ]) async {
    final keyword = query['word'];
    final response = await _dio.get<String>(
      'https://tieba.baidu.com$path',
      queryParameters: query,
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'User-Agent': TiebaProtocol.mobileWebUserAgent,
          'Accept': 'application/json, text/plain, */*',
          'Referer': referer ??
              'https://tieba.baidu.com/mo/q/hybrid/search'
                  '?keyword=${Uri.encodeComponent(keyword ?? '')}'
                  '&_webview_time=${DateTime.now().millisecondsSinceEpoch}',
        },
      ),
    );
    final raw = response.data ?? '';
    if (raw.isEmpty) {
      throw TiebaApiException(-1, 'empty response (http ${response.statusCode})');
    }
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw TiebaApiException(-2, 'unexpected payload');
    }
    final code = (decoded['no'] as num?)?.toInt() ?? 0;
    if (code != 0) {
      throw TiebaApiException(code, (decoded['error'] ?? '').toString());
    }
    return decoded;
  }

  /// Fetches the web session info (`/dc/common/tbs`) to validate a BDUSS.
  ///
  /// Returns null when the credential is rejected.
  Future<TiebaAccount?> fetchAccount([String? bdussOverride]) async {
    final value = bdussOverride ?? bduss ?? Session.instance.bduss;
    if (value == null || value.isEmpty) return null;
    final response = await _dio.get<String>(
      'https://tieba.baidu.com/dc/common/tbs',
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'User-Agent': TiebaProtocol.userAgent,
          'Cookie': 'BDUSS=$value',
        },
      ),
    );
    final raw = response.data ?? '';
    if (raw.isEmpty) return null;
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return null;
    if ((decoded['is_login'] as num?)?.toInt() != 1) return null;
    return TiebaAccount(
      userName: (decoded['user_name'] ?? '').toString(),
      tbs: (decoded['tbs'] ?? '').toString(),
    );
  }
}

/// Minimal account info returned by the web session endpoint.
class TiebaAccount {
  const TiebaAccount({required this.userName, required this.tbs});

  final String userName;
  final String tbs;
}
