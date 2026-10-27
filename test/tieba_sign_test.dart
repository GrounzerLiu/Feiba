import 'package:flutter_test/flutter_test.dart';

import 'package:feiba/core/tieba_client.dart';

void main() {
  group('tiebaSign', () {
    test('sorts key=value pairs before hashing', () {
      final sign = tiebaSign(<String, String>{'b': '2', 'a': '1'});
      expect(sign, '42961b9881c2d7cb297e9498f9767789');
    });

    test('is stable for the same input regardless of map order', () {
      final a = tiebaSign(<String, String>{'kz': '123', 'pn': '1', 'rn': '20'});
      final b = tiebaSign(<String, String>{'rn': '20', 'kz': '123', 'pn': '1'});
      expect(a, '2ea6004fbaacf918a8854246d2d2e438');
      expect(a, b);
    });

    test('uses the official client secret', () {
      expect(TiebaProtocol.appSecret, 'tiebaclient!!!');
    });
  });
}
