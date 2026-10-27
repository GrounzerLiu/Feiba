import 'dart:convert';
import 'dart:typed_data';

import 'package:feiba/protocol/core/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('decodes GBK HTML using the meta charset', () {
    // "<meta charset=\"GBK\">贴吧用户" where the Chinese is GBK-encoded.
    final bytes = Uint8List.fromList(<int>[
      ...'<meta charset="GBK">'.codeUnits,
      0xCC,
      0xF9,
      0xB0,
      0xC9,
      0xD3,
      0xC3,
      0xBB,
      0xA7,
    ]);
    expect(decodeHtmlBytes(bytes), '<meta charset="GBK">贴吧用户');
  });

  test('keeps UTF-8 HTML unchanged', () {
    final bytes = Uint8List.fromList(utf8.encode('<meta charset="UTF-8">原神'));
    expect(decodeHtmlBytes(bytes), '<meta charset="UTF-8">原神');
  });
}
