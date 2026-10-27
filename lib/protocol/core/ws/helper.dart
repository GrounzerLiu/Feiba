/// Websocket frame packing: 9-byte header, optional gzip and AES-ECB.
///
/// Ported from `aiotieba/core/websocket/helper.py` (Unlicense).
///
/// Wire format of one websocket binary message:
///
/// ```text
/// flag (1B) | cmd (4B BE) | req_id (4B BE) | data
/// ```
///
/// The low bit of [wsFlagProtobuf] is always set; bit 6 marks a gzip payload
/// and bit 7 an AES-encrypted payload.
library;

import 'dart:io' show gzip;
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import '../account.dart';

/// Always set in outgoing frames.
const int wsFlagProtobuf = 0x08;

/// Payload is gzip compressed.
const int wsFlagCompressed = 0x40;

/// Payload is AES-ECB encrypted.
const int wsFlagEncrypted = 0x80;

/// Salt used to derive the websocket AES key.
const List<int> wsKeyDerivationSalt = <int>[
  0xA4,
  0x0B,
  0xC8,
  0x34,
  0xD6,
  0x95,
  0xF3,
  0x13,
];

/// Number of PBKDF2 iterations used to derive the websocket AES key.
const int wsKeyDerivationIterations = 5;

/// One decoded websocket frame.
class WsFrame {
  const WsFrame(this.data, this.cmd, this.reqId);

  /// Decoded payload.
  final Uint8List data;

  /// Frame command id.
  final int cmd;

  /// Request id echoed by the server.
  final int reqId;
}

/// Derives the 32-byte AES key from the account's `ws_sec_key`.
///
/// `PBKDF2-HMAC-SHA1(ws_sec_key, salt, 5 iterations, 32 bytes)`.
Uint8List deriveWsAesKey(List<int> wsSecKey) {
  final derivator = PBKDF2KeyDerivator(HMac(SHA1Digest(), 64))
    ..init(
      Pbkdf2Parameters(
        Uint8List.fromList(wsKeyDerivationSalt),
        wsKeyDerivationIterations,
        32,
      ),
    );
  return derivator.process(Uint8List.fromList(wsSecKey));
}

/// Packs [data] into a websocket frame.
///
/// [compress] applies gzip level 6; [encrypt] applies PKCS#7 padding followed
/// by AES-256-ECB with the key derived from [account]'s `ws_sec_key`.
Uint8List packWsBytes(
  TiebaAccount account,
  List<int> data,
  int cmd,
  int reqId, {
  bool compress = false,
  bool encrypt = true,
}) {
  var flag = wsFlagProtobuf;
  var payload = Uint8List.fromList(data);

  if (compress) {
    flag |= wsFlagCompressed;
    payload = Uint8List.fromList(gzip.encode(payload));
  }
  if (encrypt) {
    flag |= wsFlagEncrypted;
    payload = _aesEcbEncrypt(deriveWsAesKey(account.wsSecKey), payload);
  }

  final frame = Uint8List(9 + payload.length);
  frame[0] = flag;
  _writeUint32(frame, 1, cmd);
  _writeUint32(frame, 5, reqId);
  frame.setRange(9, frame.length, payload);
  return frame;
}

/// Unpacks a websocket frame received from the server.
///
/// The inverse of [packWsBytes]; decryption needs the same account key.
WsFrame parseWsBytes(TiebaAccount account, Uint8List data) {
  if (data.length < 9) {
    throw const FormatException('websocket frame is too short');
  }
  final flag = data[0];
  final cmd = _readUint32(data, 1);
  final reqId = _readUint32(data, 5);
  var payload = Uint8List.fromList(Uint8List.sublistView(data, 9));

  if (flag & wsFlagEncrypted != 0) {
    payload = _aesEcbDecrypt(deriveWsAesKey(account.wsSecKey), payload);
  }
  if (flag & wsFlagCompressed != 0) {
    payload = Uint8List.fromList(gzip.decode(payload));
  }
  return WsFrame(payload, cmd, reqId);
}

Uint8List _aesEcbEncrypt(List<int> key, Uint8List plain) {
  final cipher = ECBBlockCipher(AESEngine())
    ..init(true, KeyParameter(Uint8List.fromList(key)));
  final padded = _pkcs7Pad(plain, cipher.blockSize);
  final output = Uint8List(padded.length);
  for (var offset = 0; offset < padded.length; offset += cipher.blockSize) {
    cipher.processBlock(padded, offset, output, offset);
  }
  return output;
}

Uint8List _aesEcbDecrypt(List<int> key, Uint8List encrypted) {
  final cipher = ECBBlockCipher(AESEngine())
    ..init(false, KeyParameter(Uint8List.fromList(key)));
  if (encrypted.isEmpty || encrypted.length % cipher.blockSize != 0) {
    throw const FormatException('invalid AES-ECB payload length');
  }
  final output = Uint8List(encrypted.length);
  for (var offset = 0; offset < encrypted.length; offset += cipher.blockSize) {
    cipher.processBlock(encrypted, offset, output, offset);
  }
  return _pkcs7Unpad(output, cipher.blockSize);
}

Uint8List _pkcs7Pad(Uint8List data, int blockSize) {
  final padLength = blockSize - data.length % blockSize;
  final padded = Uint8List(data.length + padLength)
    ..setRange(0, data.length, data);
  padded.fillRange(data.length, padded.length, padLength);
  return padded;
}

Uint8List _pkcs7Unpad(Uint8List data, int blockSize) {
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

int _readUint32(Uint8List data, int offset) =>
    (data[offset] << 24) |
    (data[offset + 1] << 16) |
    (data[offset + 2] << 8) |
    data[offset + 3];

void _writeUint32(Uint8List data, int offset, int value) {
  data[offset] = (value >> 24) & 0xFF;
  data[offset + 1] = (value >> 16) & 0xFF;
  data[offset + 2] = (value >> 8) & 0xFF;
  data[offset + 3] = value & 0xFF;
}
