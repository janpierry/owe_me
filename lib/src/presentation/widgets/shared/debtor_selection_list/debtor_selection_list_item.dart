import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/core/presentation/callbacks.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_spacer.dart';

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
      color: OweMeColors.surfaceWhite,
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
                  Text(debtor.nickname, style: OweMeTextStyles.subtitle),
                  Text(
                    MoneyFormatter.toStringCurrency(debtor.totalDebt),
                    style: OweMeTextStyles.body,
                  ),
                ],
              ),
              OweMeSpacer(minWidth: 8),
              Icon(Icons.chevron_right, color: OweMeColors.textGray),
            ],
          ),
        ),
      ),
    );
  }
}
