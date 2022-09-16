import 'package:get/get.dart';
import 'dart:math';

extension RandomInt on int {
  static int generate({int min = 0, required int max}) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }
}

class SumController extends GetxController {
  var _score = 0.obs;
  var _op1 = 0.obs;
  var _op2 = 0.obs;
  late int _rta = 0;
  var _vectorRta = <int>[].obs;

  int get score => _score.value;
  int get op1 => _op1.value;
  int get op2 => _op2.value;
  int get rta => _rta;
  List<int> get Rta => _vectorRta;

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

  void onResultClick(int value) {
    (value == _rta) ? _score(_score.value + 1) : _score(_score.value);
    setValues();
  }

  void reset() {
    _score(0);
    setValues();
  }
}
