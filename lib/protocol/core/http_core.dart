import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:gbk_codec/gbk_codec.dart';

import 'account.dart';
import 'config.dart';
import 'constants.dart';
import 'exceptions.dart';
import 'sign.dart';

/// HTTP transport for the three request families used by Tieba:
/// app form requests, app protobuf requests and web requests.
/// Raw HTTP response used by cookie/zid/web flows.
class TiebaHttpResponse {
  const TiebaHttpResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  final int statusCode;
  final Map<String, String> headers;
  final Uint8List body;

  /// First Set-Cookie value, if present.
  String? get setCookie => headers['set-cookie'];

  Map<String, dynamic> get json {
    final decoded = jsonDecode(utf8.decode(body, allowMalformed: true));
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return decoded.cast<String, dynamic>();
    throw const TiebaFormatException('unexpected JSON payload');
  }
}

class TiebaHttpCore {
  TiebaHttpCore({required this.account, TiebaConfig? config, Dio? dio})
    : config = config ?? const TiebaConfig(),
      _dio = dio ?? Dio() {
    _dio.options
      ..connectTimeout = this.config.connectTimeout
      ..receiveTimeout = this.config.receiveTimeout
      ..followRedirects = true
      ..validateStatus = (_) => true;
    final proxy = this.config.proxy;
    if (proxy != null && proxy.isNotEmpty) {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (uri) => 'PROXY $proxy';
          return client;
        },
      );
    }
  }

  final TiebaAccount account;
  final TiebaConfig config;
  final Dio _dio;

  Uri _appUri(String path, [Map<String, String>? query]) {
    return Uri(
      scheme: config.useHttps ? 'https' : 'http',
      host: TiebaConstants.appBaseHost,
      path: path,
      queryParameters: (query == null || query.isEmpty) ? null : query,
    );
  }

  Uri _webUri(String path, [Map<String, String>? query]) {
    return Uri(
      scheme: 'https',
      host: TiebaConstants.webBaseHost,
      path: path,
      queryParameters: (query == null || query.isEmpty) ? null : query,
    );
  }

  Map<String, String> get _appHeaders => <String, String>{
    'User-Agent': config.userAgent,
    'Accept-Encoding': 'gzip',
    'Connection': 'keep-alive',
  };

  Map<String, String> get _protoHeaders => <String, String>{
    ..._appHeaders,
    'x_bd_data_type': TiebaConstants.protoHeader,
  };

  Map<String, String> get _webHeaders {
    final headers = <String, String>{
      'User-Agent': config.webUserAgent,
      'Accept': 'application/json, text/plain, */*',
      'Accept-Encoding': 'gzip, deflate',
      'Connection': 'keep-alive',
    };
    if (account.bduss.isNotEmpty) {
      headers['Cookie'] = _cookie;
    }
    return headers;
  }

  String get _cookie {
    final parts = <String>[];
    if (account.bduss.isNotEmpty) parts.add('BDUSS=${account.bduss}');
    if (account.stoken.isNotEmpty) parts.add('STOKEN=${account.stoken}');
    return parts.join('; ');
  }

  /// Sends a protobuf payload as `multipart/form-data`.
  Future<Uint8List> postProto(String path, int cmd, List<int> payload) async {
    const boundary = TiebaConstants.protoBoundary;
    final body = BytesBuilder()
      ..add(utf8.encode('--$boundary\r\n'))
      ..add(
        utf8.encode(
          'Content-Disposition: form-data; name="data"; filename="file"\r\n\r\n',
        ),
      )
      ..add(payload)
      ..add(utf8.encode('\r\n--$boundary--\r\n'));

    final uri = _appUri(path, <String, String>{'cmd': '$cmd'});
    final response = await _dio.post<List<int>>(
      uri.toString(),
      data: body.toBytes(),
      options: Options(
        headers: _protoHeaders,
        contentType: 'multipart/form-data; boundary=$boundary',
        responseType: ResponseType.bytes,
      ),
    );
    return _checkedBytes(response);
  }

  /// Sends a signed app form request and returns the raw response.
  Future<TiebaHttpResponse> postFormResponse(
    String path,
    List<MapEntry<String, String>> data, {
    String salt = TiebaConstants.appSalt,
  }) async {
    final signed = signForm(data, salt: salt);
    final body = signed
        .map(
          (e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
        )
        .join('&');
    final response = await _dio.post<List<int>>(
      _appUri(path).toString(),
      data: body,
      options: Options(
        headers: _appHeaders,
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.bytes,
      ),
    );
    return _toResponse(response);
  }

  /// Sends a raw POST to an arbitrary URI (zid/sofie and similar flows).
  Future<TiebaHttpResponse> postRaw(
    Uri uri, {
    required List<int> body,
    Map<String, String> headers = const <String, String>{},
    String? contentType,
  }) async {
    final response = await _dio.post<List<int>>(
      uri.toString(),
      data: body,
      options: Options(
        headers: headers,
        contentType: contentType,
        responseType: ResponseType.bytes,
      ),
    );
    return _toResponse(response);
  }

  /// Sends a raw GET to an arbitrary URI.
  Future<TiebaHttpResponse> getRaw(
    Uri uri, {
    Map<String, String> headers = const <String, String>{},
  }) async {
    final response = await _dio.get<List<int>>(
      uri.toString(),
      options: Options(headers: headers, responseType: ResponseType.bytes),
    );
    return _toResponse(response);
  }

  /// Sends a signed app form request and decodes the JSON envelope.
  Future<Map<String, dynamic>> postForm(
    String path,
    List<MapEntry<String, String>> data, {
    String salt = TiebaConstants.appSalt,
  }) async {
    final signed = signForm(data, salt: salt);
    final body = signed
        .map(
          (e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
        )
        .join('&');
    final response = await _dio.post<List<int>>(
      _appUri(path).toString(),
      data: body,
      options: Options(
        headers: _appHeaders,
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.bytes,
      ),
    );
    return _decodeJson(_checkedBytes(response));
  }

  /// GET against the mobile web host, decoded as a JSON object.
  Future<Map<String, dynamic>> webGetJson(
    String path, {
    Map<String, String>? query,
    String? referer,
  }) async {
    final headers = <String, String>{..._webHeaders};
    if (referer != null) headers['Referer'] = referer;
    final response = await _dio.get<List<int>>(
      _webUri(path, query).toString(),
      options: Options(headers: headers, responseType: ResponseType.bytes),
    );
    return _decodeJson(
      _checkedBytes(response),
      contentType: response.headers.value('content-type'),
    );
  }

  /// GET against the mobile web host, returning the raw bytes.
  Future<Uint8List> webGetBytes(
    String path, {
    Map<String, String>? query,
    String? referer,
  }) async {
    final headers = <String, String>{..._webHeaders};
    if (referer != null) headers['Referer'] = referer;
    final response = await _dio.get<List<int>>(
      _webUri(path, query).toString(),
      options: Options(headers: headers, responseType: ResponseType.bytes),
    );
    return _checkedBytes(response);
  }

  /// GET an arbitrary URL (image CDN, avatar host) with web headers.
  Future<Uint8List> fetchBytes(Uri uri, {String? referer}) async {
    final headers = <String, String>{..._webHeaders};
    if (referer != null) headers['Referer'] = referer;
    final response = await _dio.get<List<int>>(
      uri.toString(),
      options: Options(headers: headers, responseType: ResponseType.bytes),
    );
    return _checkedBytes(response);
  }

  /// POST form against the mobile web host.
  Future<Map<String, dynamic>> webPostForm(
    String path,
    List<MapEntry<String, String>> data, {
    String? referer,
    Map<String, String>? extraHeaders,
    Map<String, String>? query,
  }) async {
    final body = data
        .map(
          (e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
        )
        .join('&');
    final headers = <String, String>{..._webHeaders};
    if (referer != null) headers['Referer'] = referer;
    if (extraHeaders != null) headers.addAll(extraHeaders);
    final response = await _dio.post<List<int>>(
      _webUri(path, query).toString(),
      data: body,
      options: Options(
        headers: headers,
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.bytes,
      ),
    );
    return _decodeJson(_checkedBytes(response));
  }

  /// Closes the underlying HTTP client.
  void close() => _dio.close(force: true);

  TiebaHttpResponse _toResponse(Response<List<int>> response) {
    final headers = <String, String>{};
    response.headers.forEach((name, values) {
      if (values.isNotEmpty) headers[name.toLowerCase()] = values.first;
    });
    final data = response.data;
    return TiebaHttpResponse(
      statusCode: response.statusCode ?? -1,
      headers: headers,
      body: data == null ? Uint8List(0) : Uint8List.fromList(data),
    );
  }

  Uint8List _checkedBytes(Response<List<int>> response) {
    final status = response.statusCode ?? -1;
    if (status != 200) {
      throw TiebaHttpException(status, response.statusMessage ?? '');
    }
    final data = response.data;
    if (data == null || data.isEmpty) {
      throw TiebaHttpException(status, 'empty response body');
    }
    return Uint8List.fromList(data);
  }

  Map<String, dynamic> _decodeJson(Uint8List bytes, {String? contentType}) {
    try {
      final type = (contentType ?? '').toLowerCase();
      final text =
          (type.contains('gbk') ||
              type.contains('gb2312') ||
              type.contains('gb18030'))
          ? gbk.decode(bytes)
          : utf8.decode(bytes, allowMalformed: true);
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
      throw const TiebaFormatException('unexpected JSON payload');
    } on FormatException catch (e) {
      throw TiebaFormatException('invalid JSON: ${e.message}');
    }
  }
}
