import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/presentation/pages/set_payment_record/set_payment_record_debtor_selection_page.dart';

class SetPaymentRecordDebtorSelectionContainer extends StatelessWidget {
  final PaymentRecordDraft? paymentRecordDraftToEdit;

  const SetPaymentRecordDebtorSelectionContainer({
    super.key,
    this.paymentRecordDraftToEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<DebtorsBloc>()..add(LoadDebtorsRequestedEvent()),
      child: SetPaymentRecordDebtorSelectionPage(
        paymentRecordDraftToEdit: paymentRecordDraftToEdit,
      ),
    );
  }
}
