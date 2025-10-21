import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class DebtorHeader extends StatelessWidget {
  final Debtor debtor;

  const DebtorHeader({super.key, required this.debtor});

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
              Text('Débito total', style: OweMeTextStyles.caption),
              const SizedBox(height: 8),
              Text(
                MoneyFormatter.toStringCurrency(debtor.totalDebt),
                style: OweMeTextStyles.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
