import 'dart:convert';
import 'dart:typed_data';

import 'package:gbk_codec/gbk_codec.dart';

/// Decodes an HTML page using its declared charset.
///
/// Tieba's management/ranking pages are commonly GBK while the JSON APIs are
/// UTF-8. The response may not expose its Content-Type to callers, so the
/// first few bytes are sniffed for a `<meta charset=...>` declaration.
String decodeHtmlBytes(Uint8List bytes, {String? contentType}) {
  final declared = (contentType ?? '').toLowerCase();
  if (_isGbk(declared)) return _decodeGbk(bytes);

  final head = latin1.decode(
    bytes.length > 4096 ? bytes.sublist(0, 4096) : bytes,
    allowInvalid: true,
  );
  final match = RegExp(
    r'''charset\s*=\s*["']?([\w-]+)''',
    caseSensitive: false,
  ).firstMatch(head);
  if (match != null && _isGbk(match.group(1)!.toLowerCase())) {
    return _decodeGbk(bytes);
  }
  return utf8.decode(bytes, allowMalformed: true);
}

bool _isGbk(String value) =>
    value.contains('gbk') ||
    value.contains('gb2312') ||
    value.contains('gb18030');

String _decodeGbk(Uint8List bytes) {
  try {
    return gbk_bytes.decode(bytes);
  } on Object {
    return utf8.decode(bytes, allowMalformed: true);
  }
}
