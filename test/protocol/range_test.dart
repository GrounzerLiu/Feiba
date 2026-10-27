import 'package:feiba/protocol/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checkRn no longer leaks a RangeError', () {
    expect(() => checkRn('rn', 101, 1, 100), returnsNormally);
  });
}
