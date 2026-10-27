/// Websocket handshake for the Tieba chat endpoint.
///
/// aiotieba connects to `ws://im.tieba.baidu.com:8000` and asks for the
/// `im_version=2.3` extension with gzip accepted. `dart:io`'s
/// [WebSocket.connect] is used for the HTTP upgrade so that arbitrary headers
/// (and, when supplied, cookies) can be sent.
library;

import 'dart:io';

/// Default websocket endpoint used by the chat subsystem.
const String defaultWsUrl = 'ws://im.tieba.baidu.com:8000';

/// Default User-Agent sent during the handshake.
const String defaultWsUserAgent = 'feiba/1.0.0';

/// Builds the HTTP upgrade request used by [WsCore.connect].
class WsHandshake {
  const WsHandshake({
    this.url = defaultWsUrl,
    this.userAgent = defaultWsUserAgent,
    this.extensions = 'im_version=2.3',
    this.acceptEncoding = 'gzip',
    this.cookie,
    this.extraHeaders = const <String, String>{},
  });

  /// Websocket URL, `ws://` or `wss://`.
  final String url;

  /// User-Agent header value.
  final String userAgent;

  /// Value of `Sec-WebSocket-Extensions`; the official client sends
  /// `im_version=2.3`.
  final String extensions;

  /// Value of `Accept-Encoding`.
  final String acceptEncoding;

  /// Optional `Cookie` header (e.g. `BDUSS=...`).
  final String? cookie;

  /// Extra headers appended last; they override the defaults.
  final Map<String, String> extraHeaders;

  /// Parsed [url].
  Uri get uri => Uri.parse(url);

  /// Headers of the upgrade request.
  Map<String, dynamic> get headers {
    final values = <String, dynamic>{
      'Sec-WebSocket-Extensions': extensions,
      'Accept-Encoding': acceptEncoding,
      'User-Agent': userAgent,
    };
    if (cookie != null && cookie!.isNotEmpty) {
      values['Cookie'] = cookie!;
    }
    values.addAll(extraHeaders);
    return values;
  }

  /// Performs the HTTP upgrade and returns the open websocket.
  ///
  /// Permessage-deflate is disabled: the protocol uses its own gzip flag inside
  /// the binary frames.
  Future<WebSocket> connect() => WebSocket.connect(
    url,
    headers: headers,
    compression: CompressionOptions.compressionOff,
  );
}
