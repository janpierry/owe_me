import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_info_review_container.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class SetPaymentRecordPrimaryButton extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final PaymentRecord? paymentRecordToEdit;
  final bool isReviewing;
  final bool fromDebtorPage;

  const SetPaymentRecordPrimaryButton({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.paymentRecordToEdit,
    required this.isReviewing,
    required this.fromDebtorPage,
  });

  void _finishInfoReview(BuildContext context) {
    _popCurrentPageAndPreviousInfoReviewPage(context);
    _navigateToInfoReviewPage(context);
  }

  void _popCurrentPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToInfoReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordInfoReviewContainer(
          paymentRecordDraft: paymentRecordDraft,
          recordDebtor: recordDebtor,
          paymentRecordToEdit: paymentRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OweMeElevatedButton(
      label: isReviewing ? 'Salvar alterações' : 'Continuar',
      onPressed: () =>
          isReviewing ? _finishInfoReview(context) : _navigateToInfoReviewPage(context),
    );
  }
}
