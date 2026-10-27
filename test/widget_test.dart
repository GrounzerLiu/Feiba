import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:feiba/app.dart';

void main() {
  testWidgets('home page renders search field and hot forums', (WidgetTester tester) async {
    await tester.pumpWidget(const FeibaApp());

    expect(find.text('Feiba'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('热门吧'), findsOneWidget);
    expect(find.text('原神'), findsOneWidget);
  });
}
