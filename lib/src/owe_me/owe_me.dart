import 'package:flutter/material.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';

class OweMe extends StatelessWidget {
  const OweMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: OweMeColors.primaryBlue),
        useMaterial3: true,
      ),
      home: const HomeContainer(),
    );
  }
}
