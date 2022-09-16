// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sum_game/main.dart';
import 'package:sum_game/ui/controllers/SumController.dart';
import 'package:mockito/mockito.dart';
import 'package:sum_game/ui/pages/home.dart';
import 'package:sum_game/ui/widgets/SumWidget.dart';

class MockSumController extends GetxService with Mock implements SumController {
  var _score = 0.obs;
  var _op1 = 0.obs;
  var _op2 = 0.obs;
  late int _rta = 0;
  var _vectorRta = <int>[].obs;

  @override
  int get score => _score.value;

  @override
  int get op1 => _op1.value;

  @override
  int get op2 => _op2.value;

  int get rta => _rta;

  @override
  List<int> get Rta => _vectorRta;

  @override
  void setValues() {
    // print("Set Values");
    _op1.value = RandomInt.generate(max: 50);
    _op2.value = RandomInt.generate(max: 50);

    _rta = op1 + op2;
    _vectorRta.clear();
    _vectorRta.add(_rta);
    _vectorRta.add(_rta + 1);
    _vectorRta.add(_rta - 1);
    _vectorRta.shuffle();
  }

  @override
  void onResultClick(int value) {
    (value == _rta) ? _score(_score.value + 1) : _score(_score.value);
    setValues();
  }

  @override
  void reset() {
    _score(0);
    setValues();
  }
}

void main() {
  group('Some Group', () {
    late MockSumController mockSumController;

    setUp(() {
      mockSumController = MockSumController();
      Get.put<SumController>(mockSumController);
    });

    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      SumController mockSumController = Get.find();

      await tester.pumpWidget(const GetMaterialApp(home: SumWidget()));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);

      await tester.tap(find.ancestor(
          of: find.text(mockSumController.rta.toString()),
          matching: find.byType(ElevatedButton)));

      await tester.pumpAndSettle();

      expect(find.text('Score: 1'), findsOneWidget);
      mockSumController.reset();
    });

    testWidgets('Testing wrong answer', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      SumController mockSumController = Get.find();
      await tester.pumpWidget(const GetMaterialApp(home: SumWidget()));

      expect(find.text('Score: 0'), findsOneWidget);

      await tester.tap(find.ancestor(
          of: find.text((mockSumController.rta - 1).toString()),
          matching: find.byType(ElevatedButton)));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);
      mockSumController.reset();
    });

    testWidgets('Testing reset after good answer', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const GetMaterialApp(home: SumWidget()));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);

      SumController sumController = Get.find();

      await tester.tap(find.ancestor(
          of: find.text(sumController.rta.toString()),
          matching: find.byType(ElevatedButton)));

      await tester.pumpAndSettle();

      expect(find.text('Score: 1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reset')));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);
      mockSumController.reset();
    });

    testWidgets('Testing reset changes answers', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const GetMaterialApp(home: SumWidget()));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);

      SumController sumController = Get.find();

      int op1 = sumController.op1;
      int op2 = sumController.op2;

      await tester.tap(find.byKey(const Key('reset')));

      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);

      expect(op1 != sumController.op1, true);
      expect(op2 != sumController.op2, true);
      mockSumController.reset();
    });
  });
}
