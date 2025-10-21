import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';

class OweMeTextStyles {
  OweMeTextStyles._();

  static TextStyle headline1 = const TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.bold,
    color: OweMeColors.textBlack,
  );

  static TextStyle headline2 = const TextStyle(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w500,
    color: OweMeColors.textBlack,
  );

  static TextStyle subtitle = const TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    color: OweMeColors.textBlack,
  );

  static TextStyle body = const TextStyle(
    fontSize: 14,
    height: 20 / 14,
    color: OweMeColors.textBlack,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 12,
    height: 16 / 12,
    color: OweMeColors.textGray,
  );
}
