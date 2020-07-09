// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Loading'), findsOneWidget);

    await tester.tap(find.text('Add value'));
    await tester.pumpAndSettle(Duration(milliseconds: 200));

    expect(find.text('Loading'), findsNothing);
    expect(find.text('Error'), findsNothing);

    await tester.tap(find.text('Add error'));
    await tester.pumpAndSettle(Duration(milliseconds: 200));

    expect(find.text('Error'), findsOneWidget);
  });
}
