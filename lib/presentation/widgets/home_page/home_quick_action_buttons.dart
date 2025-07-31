import 'package:flutter/material.dart';
import 'package:owe_me/domain/enums/owe_type.dart';
import 'package:owe_me/presentation/containers/set_owe_record/set_owe_record_debtor_selection_container.dart';
import 'package:owe_me/presentation/containers/set_payment_record/set_payment_record_debtor_selection_container.dart';
import 'package:owe_me/presentation/widgets/shared/quick_action_button.dart';

class HomeQuickActionButtons extends StatelessWidget {
  const HomeQuickActionButtons({super.key});

  void _navigateToSetPaymentRecordPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SetPaymentRecordDebtorSelectionContainer(),
      ),
    );
  }

  void _navigateToSetRecordDebtorSelectionPageAsCredit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const SetOweRecordDebtorSelectionContainer(oweRecordType: OweType.credit),
      ),
    );
  }

  void _navigateToSetRecordDebtorSelectionPageAsDebt(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const SetOweRecordDebtorSelectionContainer(oweRecordType: OweType.debt),
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
          label: 'Payment',
          icon: Icons.credit_card,
          onPressed: () => _navigateToSetPaymentRecordPage(context),
        ),
        const SizedBox(width: 8),
        QuickActionButton(
          label: 'Credit',
          icon: Icons.money_off_csred,
          onPressed: () => _navigateToSetRecordDebtorSelectionPageAsCredit(context),
        ),
        const SizedBox(width: 8),
        QuickActionButton(
          label: 'Debt',
          icon: Icons.attach_money,
          onPressed: () => _navigateToSetRecordDebtorSelectionPageAsDebt(context),
        ),
      ],
    );
  }
}
