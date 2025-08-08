import 'package:flutter/material.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class DebtorHeader extends StatelessWidget {
  final Debtor debtor;

  const DebtorHeader({super.key, required this.debtor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 96,
      child: Card(
        color: AppColors.surfaceWhite,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Débito total', style: AppTextStyles.caption),
              const SizedBox(height: 8),
              Text(debtor.totalDebt.toString(), style: AppTextStyles.headline1),
            ],
          ),
        ),
      ),
    );
  }
}
