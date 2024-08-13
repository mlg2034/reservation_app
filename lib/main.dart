import 'package:flutter/material.dart';
import 'package:paloma_test_app/core/service_locator/service_locator.dart';
import 'package:paloma_test_app/src/feature/main/screen/app.dart';

Future<void> main() async {
  await serviceLocator();
  runApp(AppScreen());
}
