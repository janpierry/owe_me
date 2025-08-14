import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const QuickActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  Color get _primaryColor => AppColors.primaryBlue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryBlueLightest,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        highlightColor:
            AppColors.primaryBlueLight, //TODO update widget to have fixed color
        child: Container(
          height: 80,
          width: 104,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(color: _primaryColor, width: 2)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: _primaryColor,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(color: _primaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
