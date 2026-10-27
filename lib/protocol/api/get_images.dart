import 'dart:typed_data';

import '../core/http_core.dart';

/// Downloads an image (or any binary asset) from a Tieba/Baidu URL.
Future<Uint8List> fetchImageBytes(
  TiebaHttpCore http,
  Uri url, {
  String referer = 'tieba.baidu.com',
}) {
  return http.fetchBytes(url, referer: referer);
}

/// Builds a Baidu image-library URL from its raw hash.
Uri hash2ImageUrl(String hash, {String size = 's'}) {
  final path = switch (size) {
    'm' => '/forum/w=960;q=60;g=0/sign=__/$hash.jpg',
    'l' => '/forum/pic/item/$hash.jpg',
    _ => '/forum/w=720;q=60;g=0/sign=__/$hash.jpg',
  };
  return Uri(scheme: 'http', host: 'imgsrc.baidu.com', path: path);
}

/// Builds an avatar URL from a portrait identifier.
Uri portraitUrl(String portrait, {String size = 's'}) {
  final suffix = switch (size) {
    'm' => '',
    'l' => 'h',
    _ => 'n',
  };
  return Uri(
    scheme: 'http',
    host: 'tb.himg.baidu.com',
    path: '/sys/portrait$suffix/item/$portrait',
  );
}
