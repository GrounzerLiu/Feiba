import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

const String appSecret = 'tiebaclient!!!';

String calcSign(Map<String, String> params) {
  final entries = params.entries.map((e) => '${e.key}=${e.value}').toList()..sort();
  final raw = entries.join('');
  return md5.convert(utf8.encode(raw + appSecret)).toString();
}

Future<void> call(String baseUrl, String path, Map<String, String> extra) async {
  final params = <String, String>{
    '_client_type': '2',
    '_client_version': '8.2.2',
    '_client_id': 'wappc_1700000000000_123',
    '_os_version': '30',
    '_phone_imei': '000000000000000',
    '_timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    'model': 'PLQ110',
    'net_type': '1',
    'from': 'baidu_appstore',
    'cuid': 'A1B2C3D4E5F6',
    ...extra,
  };
  params['sign'] = calcSign(params);
  final body = params.entries.map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}').join('&');

  final client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  try {
    final uri = Uri.parse(baseUrl + path);
    final req = await client.postUrl(uri);
    req.headers.set('User-Agent', 'bdtb for Android 8.2.2');
    req.headers.set('Cookie', 'ka=open');
    req.headers.set('Content-Type', 'application/x-www-form-urlencoded');
    req.write(body);
    final resp = await req.close();
    final bytes = await resp.fold<List<int>>(<int>[], (p, e) => p..addAll(e));
    final text = utf8.decode(bytes, allowMalformed: true);
    stdout.writeln('[$baseUrl$path] status=${resp.statusCode} bytes=${bytes.length} sign=${params['sign']}');
    stdout.writeln(text.substring(0, text.length < 600 ? text.length : 600));
  } catch (e) {
    stdout.writeln('[$baseUrl$path] ERROR: $e');
  } finally {
    client.close(force: true);
  }
}

Future<void> main() async {
  await call('http://c.tieba.baidu.com', '/c/f/pb/page',
      {'kz': '8537603600', 'pn': '1', 'rn': '30', 'with_floor': '1', 'st_type': 'tb_frslist', 'back': '0', 'floor_rn': '3', 'mark': '0', 'scr_dip': '2.75', 'scr_h': '2400', 'scr_w': '1080'});
  await call('http://tieba.baidu.com', '/c/f/pb/page',
      {'kz': '8537603600', 'pn': '1', 'rn': '30'});
}
