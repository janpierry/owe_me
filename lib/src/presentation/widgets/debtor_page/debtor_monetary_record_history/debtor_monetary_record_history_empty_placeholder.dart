import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class DebtorMonetaryRecordHistoryEmptyPlaceholder extends StatelessWidget {
  const DebtorMonetaryRecordHistoryEmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: AppColors.gray400),
          const SizedBox(height: 12),
          Text(
            'Sem registros por enquanto',
            textAlign: TextAlign.center,
            style: AppTextStyles.headline2.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textGray,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione um débito, crédito ou pagamento para começar a acompanhar.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
