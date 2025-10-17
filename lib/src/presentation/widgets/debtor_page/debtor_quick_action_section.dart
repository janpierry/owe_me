import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/presentation/widgets/shared/quick_action_button.dart';

class DebtorQuickActionSection extends StatelessWidget {
  final Debtor debtor;

  const DebtorQuickActionSection({super.key, required this.debtor});

  void _navigateToSetPaymentRecordPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordPage(
          recordDebtor: debtor,
          fromDebtorPage: true,
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
          fromDebtorPage: true,
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
          fromDebtorPage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuickActionButton(
          label: 'Pagamento',
          icon: Icons.credit_card,
          onPressed: () => _navigateToSetPaymentRecordPage(context),
        ),
        const SizedBox(width: 8),
        QuickActionButton(
          label: 'Crédito',
          icon: Icons.money_off_csred,
          onPressed: () => _navigateToSetRecordAmountStepPageAsCredit(context),
        ),
        const SizedBox(width: 8),
        QuickActionButton(
          label: 'Débito',
          icon: Icons.attach_money,
          onPressed: () => _navigateToSetRecordAmountStepPageAsDebt(context),
        ),
      ],
    );
  }
}
