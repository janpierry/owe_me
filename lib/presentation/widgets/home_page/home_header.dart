import 'package:flutter/material.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/money.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final List<Debtor> debtors;

  const HomeHeader({super.key, required this.debtors});

  String get _totalDebt {
    Money totalBalance = const Money.zero();
    for (final debtor in debtors) {
      totalBalance += debtor.totalDebt;
    }
    return totalBalance.toString();
  }

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
              Text('Total a receber', style: AppTextStyles.caption),
              const SizedBox(height: 8),
              Text(
                _totalDebt,
                style: AppTextStyles.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
