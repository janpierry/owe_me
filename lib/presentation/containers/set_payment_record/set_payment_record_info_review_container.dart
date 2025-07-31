import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/presentation/pages/set_payment_record/set_payment_record_info_review_page.dart';

class SetPaymentRecordInfoReviewContainer extends StatelessWidget {
  final Debtor recordDebtor;
  final PaymentRecordDraft paymentRecordDraft;

  const SetPaymentRecordInfoReviewContainer({
    super.key,
    required this.recordDebtor,
    required this.paymentRecordDraft,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetPaymentRecordInfoReviewBloc>()
        ..add(
          SetPaymentRecordInfoReviewPageInitializedEvent(
            paymentRecordDraft: paymentRecordDraft,
            recordDebtor: recordDebtor,
          ),
        ),
      child: SetPaymentRecordInfoReviewPage(
        recordDebtor: recordDebtor,
        paymentRecordDraft: paymentRecordDraft,
      ),
    );
  }
}
