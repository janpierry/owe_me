import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

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

  Color get _primaryColor => OweMeColors.primaryBlue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: OweMeColors.primaryBlueLightest,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        highlightColor: OweMeColors.primaryBlueLight,
        // Fixed width so three buttons plus two 8px gaps fit a 360dp-wide
        // screen. The height is only a minimum: it grows with the system text
        // scale (or a wrapped label) instead of overflowing.
        child: Container(
          width: 104,
          constraints: const BoxConstraints(minHeight: 80),
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: _primaryColor, width: 2),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28, color: _primaryColor),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: OweMeTextStyles.caption.copyWith(color: _primaryColor),
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
