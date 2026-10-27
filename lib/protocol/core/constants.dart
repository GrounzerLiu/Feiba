/// Protocol constants mirrored from `aiotieba` (Unlicense).
///
/// Do not change these values casually: they are the client identity used by
/// the official Android client and by aiotieba.
class TiebaConstants {
  TiebaConstants._();

  /// Current app client version, used by most APIs.
  static const String latestVersion = '22.12.1.0';

  /// Legacy app client version, still required by some protobuf APIs
  /// (notably thread list and post list).
  static const String legacyVersion = '12.64.1.1';

  /// Client version for the user reply-history endpoint.
  ///
  /// aiotieba pins this endpoint to a completely separate old version.
  static const String userPostsVersion = '8';

  /// Mobile app API host.
  static const String appBaseHost = 'tiebac.baidu.com';

  /// Mobile web host.
  static const String webBaseHost = 'tieba.baidu.com';

  /// Salt used to sign app form requests.
  static const String appSalt = 'tiebaclient!!!';

  /// Salt used to sign PC web requests (search endpoints).
  static const String pcSalt = '36770b1f34c9bbf2e7d1a99d2b82fa9e';

  /// Salt used by a few misc web endpoints.
  static const String miscSalt = '0039d79dc3cc2075129745a30237a3c4';

  /// User-Agent used for app API requests.
  static const String appUserAgent = 'bdtb for Android 12.64.1.1';

  /// User-Agent used for web requests.
  static const String webUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36';

  /// Multipart boundary used by the official client for protobuf payloads.
  static const String protoBoundary = '-*_r1999';

  /// Content type header used by protobuf requests.
  static const String protoHeader = 'protobuf';
}
