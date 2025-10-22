import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_shadows.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class RemoveConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onRemovePressed;

  const RemoveConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.onRemovePressed,
  });

  void _remove(BuildContext context) {
    onRemovePressed?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: OweMeColors.surfaceWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 312,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        decoration: BoxDecoration(
          color: OweMeColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: OweMeShadows.defaultShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: OweMeTextStyles.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: OweMeTextStyles.body.copyWith(color: OweMeColors.textGray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Cancelar',
                    style: OweMeTextStyles.subtitle.copyWith(color: OweMeColors.textGray),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _remove(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OweMeColors.red,
                    foregroundColor: OweMeColors.surfaceWhite,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Excluir',
                    style: OweMeTextStyles.subtitle.copyWith(color: OweMeColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
