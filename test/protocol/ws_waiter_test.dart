import 'dart:async';

import 'package:feiba/protocol/core/ws/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'timed-out websocket responses are removed from the waiter map',
    () async {
      final waiter = WsWaiter(const Duration(milliseconds: 20));
      final response = waiter.newResponse();
      expect(waiter.pendingCount, 1);
      await expectLater(response.read(), throwsA(isA<TimeoutException>()));
      expect(waiter.pendingCount, 0);
    },
  );
}
