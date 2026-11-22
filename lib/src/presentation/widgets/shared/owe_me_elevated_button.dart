import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class OweMeElevatedButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  /// Shows a spinner instead of the label and ignores taps, keeping the
  /// button's color so it reads as "working" rather than "unavailable".
  final bool isLoading;

  const OweMeElevatedButton({
    super.key,
    required this.label,
    this.backgroundColor = OweMeColors.primaryBlue,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: isLoading ? backgroundColor : null,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: OweMeColors.white,
                ),
              )
            : Text(
                label,
                style: OweMeTextStyles.subtitle.copyWith(color: OweMeColors.white),
              ),
      ),
    );
  }
}
