import 'package:flutter/material.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordDateStepPrimaryButton extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final bool isEdition;

  const SetOweRecordDateStepPrimaryButton({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.isEdition,
  });

  void _finishEdition(BuildContext context) {
    _popCurrentEditDatePageAndPreviousInfoReviewPage(context);
    _navigateToInfoReviewPage(context);
  }

  void _popCurrentEditDatePageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToInfoReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: oweRecordDraft,
          recordDebtor: recordDebtor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () =>
          isEdition ? _finishEdition(context) : _navigateToInfoReviewPage(context),
    );
  }
}
