import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final List<Debtor> debtors;

  const HomeHeader({super.key, required this.debtors});

  String get _totalDebt {
    Money totalBalance = Money.zero;
    for (final debtor in debtors) {
      totalBalance += debtor.totalDebt;
    }
    return MoneyFormatter.toStringCurrency(totalBalance);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 96,
      child: Card(
        color: OweMeColors.surfaceWhite,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Total a receber', style: OweMeTextStyles.caption),
              const SizedBox(height: 8),
              Text(
                _totalDebt,
                style: OweMeTextStyles.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
