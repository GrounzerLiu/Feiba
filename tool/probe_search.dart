import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  const ua = 'Mozilla/5.0 (Linux; Android 14; PLQ110) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36';
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  for (final q in ['原神', '孙笑川']) {
    final uri = Uri.parse('https://tieba.baidu.com/mo/q/search/forum').replace(queryParameters: {
      'word': q,
      'pn': '1',
      'rn': '20',
    });
    final req = await client.getUrl(uri);
    req.headers.set('User-Agent', ua);
    req.headers.set('Referer',
        'https://tieba.baidu.com/mo/q/hybrid/search?keyword=${Uri.encodeComponent(q)}&_webview_time=${DateTime.now().millisecondsSinceEpoch}');
    req.headers.set('Accept', 'application/json, text/plain, */*');
    final resp = await req.close();
    final text = await resp.transform(utf8.decoder).join();
    stdout.writeln('[$q] status=${resp.statusCode} len=${text.length}');
    final j = jsonDecode(text) as Map<String, dynamic>;
    stdout.writeln('  top keys: ${j.keys.take(12).join(", ")}');
    final data = j['data'];
    if (data is Map) {
      stdout.writeln('  data keys: ${data.keys.take(12).join(", ")}');
      for (final k in ['exactMatch', 'fuzzyMatch']) {
        final v = data[k];
        if (v is List && v.isNotEmpty) {
          stdout.writeln('  $k count=${v.length}');
          stdout.writeln('  sample: ${jsonEncode(v.first).substring(0, jsonEncode(v.first).length.clamp(0, 500))}');
        } else {
          stdout.writeln('  $k: empty');
        }
      }
    }
  }
  client.close(force: true);
}
