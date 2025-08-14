import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_info_review_container.dart';
import 'package:owe_me/src/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetPaymentRecordPrimaryButton extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;

  const SetPaymentRecordPrimaryButton({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
  });

  void _navigateToInfoReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordInfoReviewContainer(
          paymentRecordDraft: paymentRecordDraft,
          recordDebtor: recordDebtor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () => _navigateToInfoReviewPage(context),
    );
  }
}
