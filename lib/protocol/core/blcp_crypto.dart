import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// AES-CBC (PKCS#7) helper used by the zid and BLCP flows.
Uint8List aesCbcEncrypt(Uint8List key, Uint8List iv, List<int> data) {
  final padded = _pkcs7Pad(data);
  final cipher = CBCBlockCipher(AESEngine())
    ..init(true, ParametersWithIV<KeyParameter>(KeyParameter(key), iv));
  final output = Uint8List(padded.length);
  for (var offset = 0; offset < padded.length; offset += 16) {
    cipher.processBlock(padded, offset, output, offset);
  }
  return output;
}

/// AES-CBC decrypt without removing PKCS#7 padding.
Uint8List aesCbcDecryptRaw(Uint8List key, Uint8List iv, List<int> data) {
  if (data.length % 16 != 0) {
    throw ArgumentError.value(data.length, 'data', 'must be a multiple of 16');
  }
  final cipher = CBCBlockCipher(AESEngine())
    ..init(false, ParametersWithIV<KeyParameter>(KeyParameter(key), iv));
  final input = Uint8List.fromList(data);
  final output = Uint8List(input.length);
  for (var offset = 0; offset < input.length; offset += 16) {
    cipher.processBlock(input, offset, output, offset);
  }
  return output;
}

/// AES-CBC (PKCS#7) decrypt; throws [FormatException] on bad padding.
Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, List<int> data) {
  return pkcs7Unpad(aesCbcDecryptRaw(key, iv, data));
}

/// Removes PKCS#7 padding from [data].
Uint8List pkcs7Unpad(Uint8List data) => _pkcs7Unpad(data);

Uint8List _pkcs7Pad(List<int> data) {
  final padding = 16 - (data.length % 16);
  final out = Uint8List(data.length + padding)..setAll(0, data);
  out.fillRange(data.length, out.length, padding);
  return out;
}

Uint8List _pkcs7Unpad(Uint8List data) {
  if (data.isEmpty) return data;
  final pad = data.last;
  if (pad < 1 || pad > 16 || pad > data.length) {
    throw const FormatException('invalid PKCS#7 padding');
  }
  for (var i = data.length - pad; i < data.length; i++) {
    if (data[i] != pad) throw const FormatException('invalid PKCS#7 padding');
  }
  return Uint8List.sublistView(data, 0, data.length - pad);
}

/// RC4 variant used by Tieba: every output byte is XORed with 42.
Uint8List rc4_42(String keyString, List<int> data) {
  final key = ascii.encode(keyString);
  final s = List<int>.generate(256, (i) => i);
  var j = 0;
  for (var i = 0; i < 256; i++) {
    j = (j + s[i] + key[i % key.length]) & 0xFF;
    final tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;
  }
  var x = 0;
  var y = 0;
  final output = Uint8List(data.length);
  for (var i = 0; i < data.length; i++) {
    x = (x + 1) & 0xFF;
    final a = s[x];
    y = (y + a) & 0xFF;
    final b = s[y];
    s[x] = b;
    s[y] = a;
    output[i] = (data[i] ^ s[(a + b) & 0xFF]) ^ 42;
  }
  return output;
}

/// Encrypts a user id into the chat baidu_uk token.
String userId2Bduk(int userId) {
  final key = Uint8List.fromList(ascii.encode('AFD311832EDEEAEF'));
  final iv = Uint8List.fromList(ascii.encode('2011121211143000'));
  final encrypted = aesCbcEncrypt(key, iv, ascii.encode(userId.toString()));
  return base64Url.encode(encrypted).replaceAll('=', '');
}

/// Decrypts a chat baidu_uk token back to a user id.
int bduk2UserId(String bduk) {
  final encrypted = base64Url.decode(base64Url.normalize(bduk));
  final key = Uint8List.fromList(ascii.encode('AFD311832EDEEAEF'));
  final iv = Uint8List.fromList(ascii.encode('2011121211143000'));
  final decrypted = aesCbcDecrypt(key, iv, encrypted);
  return int.parse(ascii.decode(decrypted));
}

/// Computes a chat message deduplication key.
String computeMsgKey(String bduk) {
  final random = Random.secure();
  final timestamp = DateTime.now().millisecondsSinceEpoch * 1000;
  final randint = random.nextInt(0x7FFFFFFF) - 0x40000000;
  return bduk + timestamp.toString() + randint.toString();
}

/// Variant encoding of cuid_galaxy2 used by the BLCP login.
///
/// The native implementation is effectively the input padded with NUL bytes
/// to 57 characters, matching aiotieba's observed output.
String enuid(String cuidGalaxy2) {
  if (cuidGalaxy2.length != 42) {
    throw ArgumentError.value(
      cuidGalaxy2,
      'cuidGalaxy2',
      'must contain 42 characters',
    );
  }
  return cuidGalaxy2.padRight(57, '\u0000');
}

String sha1Hex(List<int> data) => sha1.convert(data).toString();

String md5Hex(List<int> data) => md5.convert(data).toString();
