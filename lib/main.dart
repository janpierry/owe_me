import 'package:flutter/material.dart';
import 'package:owe_me/presentation/containers/home_container.dart';
import 'package:owe_me/core/injections/inj_container.dart' as injections;

void main() {
  injections.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeContainer(),
    );
  }
}
