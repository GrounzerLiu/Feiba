import 'dart:typed_data';

import 'package:feiba/protocol/core/ws/rsa.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ws RSA modulus is a complete 2048-bit key', () {
    expect(wsSecPublicKeyModulusHex.length, 512);
    final modulus = BigInt.parse(wsSecPublicKeyModulusHex, radix: 16);
    expect(modulus.bitLength, 2048);
  });

  test('ws secret encryption produces a 256-byte PKCS#1 block', () {
    final encrypted = encryptWsSecKey(Uint8List(31));
    expect(encrypted.length, 256);
  });
}
