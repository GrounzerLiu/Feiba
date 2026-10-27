import 'package:feiba/protocol/tieba_protocol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tieba sign', () {
    test('sorts key=value tuples before hashing', () {
      final sign = computeSign(<MapEntry<String, String>>[
        const MapEntry<String, String>('b', '2'),
        const MapEntry<String, String>('a', '1'),
      ], TiebaConstants.appSalt);
      expect(sign, '42961b9881c2d7cb297e9498f9767789');
    });

    test('is stable regardless of input order', () {
      final a = computeSign(<MapEntry<String, String>>[
        const MapEntry<String, String>('kz', '123'),
        const MapEntry<String, String>('pn', '1'),
        const MapEntry<String, String>('rn', '20'),
      ], TiebaConstants.appSalt);
      final b = computeSign(<MapEntry<String, String>>[
        const MapEntry<String, String>('rn', '20'),
        const MapEntry<String, String>('kz', '123'),
        const MapEntry<String, String>('pn', '1'),
      ], TiebaConstants.appSalt);
      expect(a, '2ea6004fbaacf918a8854246d2d2e438');
      expect(a, b);
    });

    test('signForm appends the sign entry', () {
      final signed = signForm(<MapEntry<String, String>>[
        const MapEntry<String, String>('kw', '原神'),
      ], salt: TiebaConstants.appSalt);
      expect(signed.last.key, 'sign');
      expect(signed.last.value, hasLength(32));
    });
  });
}
