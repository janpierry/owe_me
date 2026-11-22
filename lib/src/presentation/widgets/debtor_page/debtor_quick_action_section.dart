import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_form_container.dart';
import 'package:owe_me/src/presentation/widgets/shared/quick_action_button.dart';

class DebtorQuickActionSection extends StatelessWidget {
  final Debtor debtor;

  const DebtorQuickActionSection({super.key, required this.debtor});

  void _navigateToSetPaymentRecordFormPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordFormContainer(
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
    // IntrinsicHeight + stretch: when one label grows (larger text scale or a
    // wrapped label), every button takes the height of the tallest one.
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QuickActionButton(
            label: 'Pagamento',
            icon: Icons.credit_card,
            onPressed: () => _navigateToSetPaymentRecordFormPage(context),
          ),
          const SizedBox(width: 8),
          QuickActionButton(
            label: 'Crédito',
            icon: Icons.money_off_csred,
            onPressed: () =>
                _navigateToSetRecordAmountStepPageAsCredit(context),
          ),
          const SizedBox(width: 8),
          QuickActionButton(
            label: 'Débito',
            icon: Icons.attach_money,
            onPressed: () => _navigateToSetRecordAmountStepPageAsDebt(context),
          ),
        ],
      ),
    );
  }
}
