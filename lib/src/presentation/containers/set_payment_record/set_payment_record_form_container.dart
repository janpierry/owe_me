import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/form/set_payment_record_form_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_form_page.dart';
import 'package:owe_me/src/presentation/validation/services/validation_services.dart';

class SetPaymentRecordFormContainer extends StatelessWidget {
  final PaymentRecord? paymentRecordToEdit;
  final PaymentRecordDraft? paymentRecordDraftToReview;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetPaymentRecordFormContainer({
    super.key,
    this.paymentRecordToEdit,
    this.paymentRecordDraftToReview,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetPaymentRecordFormBloc(
        paymentRecordToEdit: paymentRecordToEdit,
        paymentRecordDraftToReview: paymentRecordDraftToReview,
        validationService: GetIt.instance<AmountValidationService>(),
      ),
      child: SetPaymentRecordFormPage(
        paymentRecordToEdit: paymentRecordToEdit,
        paymentRecordDraftToReview: paymentRecordDraftToReview,
        recordDebtor: recordDebtor,
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
