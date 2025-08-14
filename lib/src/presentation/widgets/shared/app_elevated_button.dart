import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const AppElevatedButton({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primaryBlue,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
