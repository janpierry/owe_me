import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordDateStepPrimaryButton extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final OweRecord? oweRecordToEdit;
  final bool isReviewing;
  final bool fromDebtorPage;

  const SetOweRecordDateStepPrimaryButton({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.oweRecordToEdit,
    required this.isReviewing,
    required this.fromDebtorPage,
  });

  void _finishInfoReview(BuildContext context) {
    _popCurrentDatePageAndPreviousInfoReviewPage(context);
    _navigateToInfoReviewPage(context);
  }

  void _popCurrentDatePageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToInfoReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: oweRecordDraft,
          recordDebtor: recordDebtor,
          oweRecordToEdit: oweRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: isReviewing ? 'Salvar alterações' : 'Continuar',
      onPressed: () =>
          isReviewing ? _finishInfoReview(context) : _navigateToInfoReviewPage(context),
    );
  }
}
