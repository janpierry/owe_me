import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class RemoveDebtorConfirmationDialog extends StatelessWidget {
  final VoidCallback? onRemoveDebtorPressed;

  const RemoveDebtorConfirmationDialog({super.key, this.onRemoveDebtorPressed});

  void _removeDebtor(BuildContext context) {
    onRemoveDebtorPressed?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 312,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            //TODO create file for shadows
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Excluir o Devedor?',
              style: AppTextStyles.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Esta ação vai excluir permatentemente este devedor e todos os registros associados a ele. Esta ação não poderá ser desfeita.',
              style: AppTextStyles.body.copyWith(color: AppColors.textGray),
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
                    style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _removeDebtor(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.surfaceWhite,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Excluir',
                    style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
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
