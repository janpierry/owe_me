import 'package:flutter/material.dart';
import 'package:owe_me/src/app/app.dart';
import 'package:owe_me/src/app/di/dependency_injection.dart' as injections;

void bootstrap() {
  // Setup dependency injection
  injections.init();

  runApp(const App());
}
