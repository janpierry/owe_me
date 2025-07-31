import 'package:flutter/material.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headline1 = const TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle headline2 = const TextStyle(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle subtitle = const TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle body = const TextStyle(
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.textBlack,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.textGray,
  );
}
