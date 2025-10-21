import 'package:flutter/material.dart';
import 'package:owe_me/src/owe_me/owe_me.dart';
import 'package:owe_me/src/owe_me/di/dependency_injection.dart' as injections;

void bootstrap() {
  // Setup dependency injection
  injections.init();

  runApp(const OweMe());
}
