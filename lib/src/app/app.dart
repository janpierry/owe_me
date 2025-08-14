import 'package:flutter/material.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      home: const HomeContainer(),
    );
  }
}
