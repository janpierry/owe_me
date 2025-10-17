import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/containers/debtor_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_spacer.dart';

class DebtorListItem extends StatelessWidget {
  final Debtor debtor;

  const DebtorListItem({
    super.key,
    required this.debtor,
  });

  void _navigateToDebtorPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DebtorContainer(debtor: debtor),
      ),
    );
  }

  void _navigateToSetPaymentRecordPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordPage(
          recordDebtor: debtor,
          fromDebtorPage: false,
        ),
      ),
    );
  }

  void _navigateToSetRecordAmountStepPageAsCredit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordAmountStepContainer(
          recordDebtor: debtor,
          oweRecordType: OweType.credit,
          fromDebtorPage: false,
        ),
      ),
    );
  }

  void _navigateToSetRecordAmountStepPageAsDebt(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordAmountStepContainer(
          recordDebtor: debtor,
          oweRecordType: OweType.debt,
          fromDebtorPage: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      color: AppColors.surfaceWhite,
      child: InkWell(
        onTap: () => _navigateToDebtorPage(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    debtor.nickname,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    MoneyFormatter.toStringCurrency(debtor.totalDebt),
                    style: AppTextStyles.body,
                  ),
                ],
              ),
              const AppSpacer(minWidth: 8),
              IconButton(
                onPressed: () => _navigateToSetPaymentRecordPage(context),
                icon: const Icon(
                  Icons.credit_card,
                  color: AppColors.primaryBlue,
                ),
              ),
              IconButton(
                onPressed: () => _navigateToSetRecordAmountStepPageAsCredit(context),
                icon: const Icon(
                  Icons.money_off_csred,
                  color: AppColors.primaryBlue,
                ),
              ),
              IconButton(
                onPressed: () => _navigateToSetRecordAmountStepPageAsDebt(context),
                icon: const Icon(
                  Icons.attach_money,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
