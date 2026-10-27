/// RSA helper used by the websocket initialization request.
///
/// `upload_ws_sec` encrypts the 31-byte `ws_sec_key` with Baidu's public key
/// (PKCS#1 v1.5) so the server can encrypt subsequent websocket payloads.
library;

import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Modulus of the RSA public key embedded in the official client.
///
/// The key is a 2048-bit SubjectPublicKeyInfo DER blob in aiotieba; only the
/// modulus and the `65537` exponent are needed here.
const String wsSecPublicKeyModulusHex =
    'c10a70059c57255fc955117fb8d7f231276eed85b044d2ccf3edb16e7886a7'
    '68884073a290fa536108e5420322d6ebead64669277dab1e8de19308f2da5d25'
    '170af7bb81e4d9693bbe7b2a6108c095894ad130b38e99a223e3a23ce50d56d6'
    '1d088b895a85b73be9be2e0053b0b588a1af73fe084b8e568c7c5e49c1e19d9'
    '67b9e34b84b552034ffc67e54486f381b061c99f64116e7f38ee587c6d5fcbaa'
    'f8292943270e28fe6c395e17edc88a4bfb96415410ba13510888ffdd77d01b2'
    'bad955753c1c9f3cc1cc8b1a7123718cdaac1c985b17702720bd45c905af64e'
    'b33fc74343772c08cd90353f824003b1b618eda7f4c559a0fb33339db0861bdd'
    '31f';

/// Public exponent of Baidu's websocket key.
const int wsSecPublicKeyExponent = 65537;

/// Encrypts [wsSecKey] with Baidu's public key using PKCS#1 v1.5 padding.
Uint8List encryptWsSecKey(List<int> wsSecKey) {
  final modulus = BigInt.parse(wsSecPublicKeyModulusHex, radix: 16);
  final key = RSAPublicKey(modulus, BigInt.from(wsSecPublicKeyExponent));
  final engine = PKCS1Encoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(key));
  final input = Uint8List.fromList(wsSecKey);
  final output = Uint8List(engine.outputBlockSize);
  final written = engine.processBlock(input, 0, input.length, output, 0);
  return Uint8List.sublistView(output, 0, written);
}
