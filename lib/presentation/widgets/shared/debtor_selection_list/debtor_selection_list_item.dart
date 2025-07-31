import 'package:flutter/material.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/shared/callbacks.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';
import 'package:owe_me/presentation/widgets/shared/app_spacer.dart';

class DebtorSelectionListItem extends StatelessWidget {
  final Debtor debtor;
  final DebtorSelectedCallback onDebtorSelected;

  const DebtorSelectionListItem({
    super.key,
    required this.debtor,
    required this.onDebtorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      color: AppColors.surfaceWhite,
      child: InkWell(
        onTap: () => onDebtorSelected(debtor),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 76,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(debtor.name, style: AppTextStyles.subtitle),
                  Text(
                    debtor.totalDebt.toString(),
                    style: AppTextStyles.body,
                  ),
                ],
              ),
              AppSpacer(minWidth: 8),
              Icon(Icons.chevron_right, color: AppColors.textGray),
            ],
          ),
        ),
      ),
    );
  }
}
