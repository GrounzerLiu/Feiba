import 'constants.dart';

/// Runtime configuration for the protocol client.
class TiebaConfig {
  const TiebaConfig({
    this.userAgent = TiebaConstants.appUserAgent,
    this.webUserAgent = TiebaConstants.webUserAgent,
    this.connectTimeout = const Duration(seconds: 20),
    this.receiveTimeout = const Duration(seconds: 25),
    this.useHttps = true,
    this.proxy,
  });

  final String userAgent;
  final String webUserAgent;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  /// Whether app API requests use HTTPS. Both schemes work today; HTTPS is
  /// the default because the official client is moving that way.
  final bool useHttps;

  /// Optional HTTP proxy in host:port form (applied to every request).
  final String? proxy;
}
