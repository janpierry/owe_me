import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_info_review_page.dart';

class SetPaymentRecordInfoReviewContainer extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final PaymentRecord? paymentRecordToEdit;
  final bool fromDebtorPage;

  const SetPaymentRecordInfoReviewContainer({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.paymentRecordToEdit,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetPaymentRecordInfoReviewBloc>()
        ..add(
          SetPaymentRecordInfoReviewPageInitialized(
            paymentRecordDraft: paymentRecordDraft,
            recordDebtor: recordDebtor,
            paymentRecordToEdit: paymentRecordToEdit,
          ),
        ),
      child: SetPaymentRecordInfoReviewPage(
        paymentRecordDraft: paymentRecordDraft,
        recordDebtor: recordDebtor,
        paymentRecordToEdit: paymentRecordToEdit,
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
