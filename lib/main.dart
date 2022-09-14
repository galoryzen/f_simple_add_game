import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/controllers/SumController.dart';
import './ui/pages/home.dart';

void main() {
  Get.lazyPut<SumController>(() => SumController());
  runApp(const MyApp());
}
