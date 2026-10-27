import 'dart:typed_data';

import 'package:feiba/protocol/core/blcp_crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BLCP crypto', () {
    test('rc4_42 matches the aiotieba reference', () {
      final output = rc4_42(
        'a' * 32,
        Uint8List.fromList(List<int>.generate(16, (i) => i)),
      );
      expect(
        output.map((b) => b.toRadixString(16).padLeft(2, '0')).join(),
        '3a97b0376cf6a9660c4e8d067a3be1ee',
      );
    });

    test('user_id2bduk matches the reference and round-trips', () {
      final bduk = userId2Bduk(2213840917);
      expect(bduk, '8EeRlId94t4EySNsx5eiYg');
      expect(bduk2UserId(bduk), 2213840917);
    });

    test('enuid pads cuid_galaxy2 to 57 NUL characters', () {
      const cuid = 'CA42873BB9AF2FF285BE40BA5AED34DB|VLUK6HOUN';
      final value = enuid(cuid);
      expect(value.length, 57);
      expect(value.substring(0, cuid.length), cuid);
      expect(value.substring(cuid.length), '\u0000' * 15);
    });
  });
}
