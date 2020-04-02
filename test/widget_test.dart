import 'package:flutter_test/flutter_test.dart';

import 'package:openinventory_staff_app/main.dart';
import 'package:openinventory_staff_app/routes/routes.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    defineAllRoutes();
    await tester.pumpWidget(App());
    expect(find.text('Open Inventory'), findsNothing);
  });
}
