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
