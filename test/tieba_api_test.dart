import 'package:feiba/core/session.dart';
import 'package:feiba/core/tieba_api.dart';
import 'package:feiba/protocol/core/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('protocol API requires a signed-in session', () async {
    TiebaApi.instance.reset();
    await Session.instance.clear();

    await expectLater(
      TiebaApi.instance.selfProfile(),
      throwsA(isA<TiebaValueException>()),
    );
  });

  test('protocol credential validation rejects malformed BDUSS', () async {
    TiebaApi.instance.reset();
    await expectLater(
      TiebaApi.instance.validateCredentials('short'),
      throwsA(isA<TiebaValueException>()),
    );
  });

  test('protocol error messages stay human readable', () {
    expect(
      tiebaErrorMessage(const TiebaValueException('请先登录贴吧账号')),
      '请先登录贴吧账号',
    );
  });
}
