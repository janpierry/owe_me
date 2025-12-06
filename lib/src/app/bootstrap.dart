import 'package:flutter/material.dart';
import 'package:owe_me/src/app/app.dart';
import 'package:owe_me/src/app/di/service_locator_setup.dart' as service_locator;

void bootstrap() {
  // Setup service locator
  service_locator.init();

  runApp(const App());
}
