import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

const String appSecret = 'tiebaclient!!!';

String calcSign(Map<String, String> params) {
  final entries = params.entries.map((e) => '${e.key}=${e.value}').toList()..sort();
  return md5.convert(utf8.encode(entries.join('') + appSecret)).toString();
}

Future<Map<String, dynamic>?> post(String path, Map<String, String> extra) async {
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
    'scr_dip': '2.75',
    'scr_h': '2400',
    'scr_w': '1080',
    ...extra,
  };
  params['sign'] = calcSign(params);
  final body = params.entries
      .map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  try {
    final req = await client.postUrl(Uri.parse('http://c.tieba.baidu.com$path'));
    req.headers.set('User-Agent', 'bdtb for Android 8.2.2');
    req.headers.set('Cookie', 'ka=open');
    req.headers.set('Content-Type', 'application/x-www-form-urlencoded');
    req.write(body);
    final resp = await req.close();
    final text = await resp.transform(utf8.decoder).join();
    stdout.writeln('  <- $path status=${resp.statusCode} len=${text.length}');
    return jsonDecode(text) as Map<String, dynamic>;
  } catch (e) {
    stdout.writeln('  <- $path ERROR: $e');
    return null;
  } finally {
    client.close(force: true);
  }
}

Future<void> main() async {
  stdout.writeln('=== 1) 吧页: /c/f/frs/page kw=原神 ===');
  final frs = await post('/c/f/frs/page', {
    'kw': '原神', 'pn': '1', 'rn': '20', 'sort_type': '0',
    'q_type': '2', 'st_type': 'tb_forumlist', 'with_group': '0',
  });
  if (frs == null) return;
  stdout.writeln('  top keys: ${frs.keys.take(14).join(", ")}');
  stdout.writeln('  error_code=${frs["error_code"]} msg=${frs["error_msg"]}');
  final threads = frs['thread_list'] as List?;
  stdout.writeln('  thread_list count=${threads?.length}');
  if (threads != null && threads.isNotEmpty) {
    for (final t in threads.take(3)) {
      stdout.writeln('   - id=${t["id"]} title=${(t["title"] ?? "").toString().replaceAll("\n", " ").substring(0, (t["title"] ?? "").toString().length.clamp(0, 40))}');
    }
    final tid = threads.first['id'].toString();
    stdout.writeln();
    stdout.writeln('=== 2) 帖子内容: /c/f/pb/page kz=$tid ===');
    final pb = await post('/c/f/pb/page', {
      'kz': tid, 'pn': '1', 'rn': '20', 'with_floor': '1',
      'st_type': 'tb_frslist', 'back': '0', 'floor_rn': '3', 'mark': '0',
    });
    if (pb == null) return;
    stdout.writeln('  top keys: ${pb.keys.take(14).join(", ")}');
    stdout.writeln('  error_code=${pb["error_code"]} msg=${pb["error_msg"]}');
    final posts = (pb['post_list'] ?? pb['postList']) as List?;
    stdout.writeln('  post_list count=${posts?.length}');
    if (posts != null && posts.isNotEmpty) {
      for (final p in posts.take(3)) {
        final c = (p['content'] ?? '').toString().replaceAll('\n', ' ');
        stdout.writeln('   - floor=${p["floor"]} author=${(p["author"]?["name_show"] ?? p["author"]?["name"] ?? "?")} content=${c.length > 70 ? c.substring(0, 70) : c}');
      }
    }
  }
}
