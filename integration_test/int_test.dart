import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sum_game/ui/controllers/SumController.dart';
import 'package:sum_game/ui/pages/home.dart';

import '../test/widget_test.dart';

void main() {
  Future<Widget> createGame(WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    return const MyApp();
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("All in one", (WidgetTester tester) async {
    MockSumController mockSumController = MockSumController();
    Get.put<SumController>(mockSumController);

    Widget w = await createGame(tester);
    await tester.pumpWidget(w);

    expect(find.text("Score: 0"), findsOneWidget);

    await tester.tap(find.ancestor(
        of: find.text(mockSumController.rta.toString()),
        matching: find.byType(ElevatedButton)));

    await tester.pumpAndSettle();

    expect(find.text('Score: 1'), findsOneWidget);

    await tester.tap(find.ancestor(
        of: find.text((mockSumController.rta + 1).toString()),
        matching: find.byType(ElevatedButton)));

    await tester.pumpAndSettle();

    expect(find.text('Score: 1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('reset')));

    await tester.pumpAndSettle();

    expect(find.text('Score: 0'), findsOneWidget);
  });
}
