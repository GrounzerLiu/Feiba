/// Crypto helpers used by the BLCP chat subsystem.
///
/// `user_id2bduk` / `bduk2user_id` reproduce
/// `aiotieba/helper/crypto/blcp.py`; `rc4_42` and `enuid` reproduce the
/// corresponding `tbcrypto` C routines (`rc442.c` and `bb64.c`).
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

const String _bdukAesKey = 'AFD311832EDEEAEF';
const String _bdukAesIv = '2011121211143000';
const int _aesBlockSize = 16;

final Random _random = Random.secure();

/// Encrypts a user id into the `baidu_uk` (bduk) value carried by chat
/// messages.
///
/// AES-128-CBC over the decimal representation of [userId], PKCS#7 padded,
/// then URL-safe base64 without `=` padding.
String userId2bduk(int userId) {
  final cipher = CBCBlockCipher(AESEngine())
    ..init(
      true,
      ParametersWithIV(
        KeyParameter(Uint8List.fromList(ascii.encode(_bdukAesKey))),
        Uint8List.fromList(ascii.encode(_bdukAesIv)),
      ),
    );
  final padded = _pkcs7Pad(
    Uint8List.fromList(utf8.encode('$userId')),
    _aesBlockSize,
  );
  final encrypted = Uint8List(padded.length);
  for (var offset = 0; offset < padded.length; offset += _aesBlockSize) {
    cipher.processBlock(padded, offset, encrypted, offset);
  }
  return base64Url.encode(encrypted).replaceAll('=', '');
}

/// Decrypts a `baidu_uk` (bduk) value back into a user id.
int bduk2userId(String bduk) {
  final paddedBase64 = bduk + '=' * (-bduk.length % 4);
  final encrypted = Uint8List.fromList(base64Url.decode(paddedBase64));
  if (encrypted.isEmpty || encrypted.length % _aesBlockSize != 0) {
    throw ArgumentError.value(bduk, 'bduk', 'invalid ciphertext length');
  }
  final cipher = CBCBlockCipher(AESEngine())
    ..init(
      false,
      ParametersWithIV(
        KeyParameter(Uint8List.fromList(ascii.encode(_bdukAesKey))),
        Uint8List.fromList(ascii.encode(_bdukAesIv)),
      ),
    );
  final decrypted = Uint8List(encrypted.length);
  for (var offset = 0; offset < encrypted.length; offset += _aesBlockSize) {
    cipher.processBlock(encrypted, offset, decrypted, offset);
  }
  final plain = _pkcs7Unpad(decrypted, _aesBlockSize);
  return int.parse(utf8.decode(plain));
}

/// Builds the de-duplication key attached to an outgoing chat message.
///
/// Mirrors `compute_msg_key`: `bduk + (now_ms * 1000) + random_long`.
String computeMsgKey(String bduk) {
  final timestamp = DateTime.now().millisecondsSinceEpoch * 1000;
  return '$bduk$timestamp${_randomSignedLong()}';
}

/// RC4 variant with an extra `^ 42` on every output byte.
///
/// [xyusMd5Str] must contain 32 characters (a lowercase MD5 hex string) and
/// [zidSecKey] must contain 16 bytes; 16 bytes are returned.
Uint8List rc4_42(String xyusMd5Str, List<int> zidSecKey) {
  if (xyusMd5Str.length != 32) {
    throw ArgumentError.value(
      xyusMd5Str.length,
      'xyusMd5Str',
      'must contain 32 characters',
    );
  }
  if (zidSecKey.length != 16) {
    throw ArgumentError.value(
      zidSecKey.length,
      'zidSecKey',
      'must contain 16 bytes',
    );
  }

  final key = ascii.encode(xyusMd5Str);
  final box = Uint8List(256);
  for (var i = 0; i < 256; i++) {
    box[i] = i;
  }
  var j = 0;
  var k = 0;
  for (var i = 0; i < 256; i++) {
    if (k >= key.length) k = 0;
    final a = box[i];
    j = (j + a + key[k]) & 0xFF;
    box[i] = box[j];
    box[j] = a;
    k++;
  }

  var x = 0;
  var y = 0;
  final output = Uint8List(zidSecKey.length);
  for (var i = 0; i < zidSecKey.length; i++) {
    x = (x + 1) & 0xFF;
    final a = box[x];
    y = (y + a) & 0xFF;
    final b = box[y];
    box[x] = b;
    box[y] = a;
    output[i] = (zidSecKey[i] ^ box[(a + b) & 0xFF]) ^ 42;
  }
  return output;
}

/// Encodes `cuid_galaxy2` into the `enuid` value expected by the cloud
/// control login.
///
/// The reference C implementation is effectively the 42-character input
/// zero-padded to 57 characters (the BB64 table encoder is dead code in that
/// source tree).
String enuid(String cuidGalaxy2) {
  if (cuidGalaxy2.length != 42) {
    throw ArgumentError.value(
      cuidGalaxy2.length,
      'cuidGalaxy2',
      'must contain 42 characters',
    );
  }
  return cuidGalaxy2.padRight(57, '\u0000');
}

int _randomSignedLong() {
  final magnitude =
      _random.nextInt(0x7FFFFFFF) | (_random.nextInt(0x7FFFFFFF) << 31);
  return _random.nextBool() ? -magnitude : magnitude;
}

Uint8List _pkcs7Pad(Uint8List data, int blockSize) {
  final padLength = blockSize - data.length % blockSize;
  final padded = Uint8List(data.length + padLength)
    ..setRange(0, data.length, data);
  padded.fillRange(data.length, padded.length, padLength);
  return padded;
}

Uint8List _pkcs7Unpad(Uint8List data, int blockSize) {
  if (data.isEmpty || data.length % blockSize != 0) {
    throw const FormatException('invalid padded block length');
  }
  final padLength = data.last;
  if (padLength < 1 || padLength > blockSize || padLength > data.length) {
    throw const FormatException('invalid PKCS#7 padding');
  }
  for (var i = 0; i < padLength; i++) {
    if (data[data.length - 1 - i] != padLength) {
      throw const FormatException('invalid PKCS#7 padding');
    }
  }
  return Uint8List.sublistView(data, 0, data.length - padLength);
}
