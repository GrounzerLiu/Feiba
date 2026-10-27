import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

const String appSecret = 'tiebaclient!!!';
String calcSign(Map<String, String> p) {
  final e = p.entries.map((x) => '${x.key}=${x.value}').toList()..sort();
  return md5.convert(utf8.encode(e.join('') + appSecret)).toString();
}
Future<Map<String, dynamic>?> post(String path, Map<String, String> extra) async {
  final p = <String, String>{
    '_client_type': '2', '_client_version': '8.2.2',
    '_client_id': 'wappc_1700000000000_123', '_os_version': '30',
    '_phone_imei': '000000000000000',
    '_timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    'model': 'PLQ110', 'net_type': '1', 'from': 'baidu_appstore',
    'cuid': 'A1B2C3D4E5F6', 'scr_dip': '2.75', 'scr_h': '2400', 'scr_w': '1080',
    ...extra,
  };
  p['sign'] = calcSign(p);
  final body = p.entries.map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}').join('&');
  final c = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  try {
    final req = await c.postUrl(Uri.parse('http://c.tieba.baidu.com$path'));
    req.headers.set('User-Agent', 'bdtb for Android 8.2.2');
    req.headers.set('Cookie', 'ka=open');
    req.headers.set('Content-Type', 'application/x-www-form-urlencoded');
    req.write(body);
    final resp = await req.close();
    return jsonDecode(await resp.transform(utf8.decoder).join()) as Map<String, dynamic>;
  } finally { c.close(force: true); }
}
String cut(String s, int n) => s.length > n ? s.substring(0, n) : s;

Future<void> main() async {
  final frs = await post('/c/f/frs/page', {'kw': '原神', 'pn': '1', 'rn': '20', 'sort_type': '0', 'q_type': '2', 'st_type': 'tb_forumlist', 'with_group': '0'});
  final t = (frs!['thread_list'] as List).first as Map<String, dynamic>;
  stdout.writeln('THREAD JSON:\n${cut(jsonEncode(t), 1600)}');
  stdout.writeln();
  final fb = (frs['forum'] ?? {}) as Map;
  stdout.writeln('FORUM JSON:\n${cut(jsonEncode(fb), 800)}');
  stdout.writeln();
  final pb = await post('/c/f/pb/page', {'kz': t['id'].toString(), 'pn': '1', 'rn': '20', 'with_floor': '1', 'st_type': 'tb_frslist', 'back': '0', 'floor_rn': '3', 'mark': '0'});
  final posts = pb!['post_list'] as List;
  final p0 = posts.first as Map<String, dynamic>;
  final p1 = posts.length > 1 ? posts[1] as Map<String, dynamic> : p0;
  stdout.writeln('POST[0] JSON:\n${cut(jsonEncode(p0), 1800)}');
  stdout.writeln();
  stdout.writeln('POST[1] JSON:\n${cut(jsonEncode(p1), 900)}');
}
