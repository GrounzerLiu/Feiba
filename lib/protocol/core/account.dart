import 'dart:math';
import 'dart:typed_data';

import 'crypto.dart' as tieba_crypto;

/// Account state and the device-derived identifiers used by the app protocol.
///
/// Mirrors aiotieba's `Account`: identifiers are generated lazily and stay
/// stable for the lifetime of the instance.
class TiebaAccount {
  TiebaAccount({String bduss = '', String stoken = ''}) {
    this.bduss = bduss;
    this.stoken = stoken;
  }

  static final Random _random = Random.secure();

  String _bduss = '';
  String _stoken = '';

  String? _androidId;
  String? _uuid;
  String? _clientId;
  String? _sampleId;
  String? _cuid;

  /// BDUSS credential. The official client uses a 192-character value.
  String get bduss => _bduss;

  set bduss(String value) {
    if (value.isNotEmpty && value.length != 192) {
      throw ArgumentError.value(
        value.length,
        'bduss',
        'BDUSS must contain 192 characters (got ${value.length})',
      );
    }
    _bduss = value;
  }

  /// STOKEN credential. The official client uses a 64-character value.
  String get stoken => _stoken;

  set stoken(String value) {
    if (value.isNotEmpty && value.length != 64) {
      throw ArgumentError.value(
        value.length,
        'stoken',
        'STOKEN must contain 64 characters (got ${value.length})',
      );
    }
    _stoken = value;
  }

  bool get isLoggedIn => _bduss.isNotEmpty;

  String get androidId => _androidId ??= _randomHex(8);

  set androidId(String value) => _androidId = value;

  String get uuid => _uuid ??= _uuidV4();

  set uuid(String value) => _uuid = value;

  /// Empty until [fetchSync] fills it, matching aiotieba's lazy account.
  String get clientId => _clientId ?? '';

  set clientId(String value) => _clientId = value;

  String get sampleId => _sampleId ??= '';

  set sampleId(String value) => _sampleId = value;

  String get cuid => _cuid ??= 'baidutiebaapp$uuid';

  String? _cuidGalaxy2;
  String? _c3Aid;

  /// Device identifier derived from [androidId]; stable for this account.
  String get cuidGalaxy2 =>
      _cuidGalaxy2 ??= tieba_crypto.cuidGalaxy2(androidId);

  set cuidGalaxy2(String value) => _cuidGalaxy2 = value;

  /// Second device identifier derived from [androidId] and [uuid].
  String get c3Aid => _c3Aid ??= tieba_crypto.c3Aid(androidId, uuid);

  set c3Aid(String value) => _c3Aid = value;

  String? tbs;

  /// BAIDUID cookie, required by some web endpoints.
  String? baiduId;

  /// Device binding token used by the sofie/zid flow.
  String? zid;

  /// Chat identity fields filled by the BLCP/IM login.
  String? bduk;
  int uk = 0;
  int triggerId = 0;

  /// Basic identity cached after a successful login.
  int userId = 0;
  int tiebaUid = 0;
  String? userName;
  String? nickName;
  String? portrait;
  bool isVip = false;
  int glevel = 0;

  Uint8List? _wsSecKey;
  Uint8List? _zidSecKey;

  /// Random 31-byte key used by the Tieba websocket handshake.
  Uint8List get wsSecKey => _wsSecKey ??= _randomBytes(31);

  set wsSecKey(Uint8List value) => _wsSecKey = value;

  /// Random 16-byte key used by the zid/AES flow.
  Uint8List get zidSecKey => _zidSecKey ??= _randomBytes(16);

  set zidSecKey(Uint8List value) => _zidSecKey = value;

  static Uint8List _randomBytes(int length) {
    return Uint8List.fromList(
      List<int>.generate(length, (_) => _random.nextInt(256)),
    );
  }

  static String _randomHex(int bytes) {
    final buffer = StringBuffer();
    for (var i = 0; i < bytes; i++) {
      buffer.write(_random.nextInt(256).toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  static String _uuidV4() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
