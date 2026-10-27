import 'package:feiba/protocol/core/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('device crypto', () {
    test('crc32 matches the IEEE vector', () {
      expect(crc32('123456789'.codeUnits), 0xCBF43926);
    });

    test('cuid_galaxy2 matches the aiotieba reference', () {
      expect(
        cuidGalaxy2('0123456789abcdef'),
        'CA42873BB9AF2FF285BE40BA5AED34DB|VLUK6HOUN',
      );
    });

    test('c3_aid matches the aiotieba reference', () {
      expect(
        c3Aid('0123456789abcdef', '12345678-1234-4234-8234-123456789012'),
        'A00-PD5PJEGINNPNX3PBIBBDWWWPDHTGB3WR-HWPTJQ6R',
      );
    });
  });
}
