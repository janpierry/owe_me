import 'package:flutter/material.dart';
import 'package:owe_me/core/utils/app_date_utils.dart';
import 'package:owe_me/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/presentation/containers/set_owe_record/set_owe_record_debtor_selection_container.dart';
import 'package:owe_me/presentation/containers/set_owe_record/set_owe_record_description_step_container.dart';
import 'package:owe_me/presentation/extensions/owe_type_ui.dart';
import 'package:owe_me/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class SetOweRecordInfoReviewCard extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordInfoReviewCard({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  //TODO check this
  //Flow of feature: SetRecordDebtorSelectionPage(OweRecord isDebt hasDebtor)
  //=> SetRecordAmountPage(isEditing) => SetRecordDescriptionPage => SetRecordDatePage =>
  //SetRecordInfoReview => Edit => pop pop push SetRecordInfoReview

  void _navigateToEditDebtor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordDebtorSelectionContainer(
          oweRecordDraftToEdit: oweRecordDraft,
          oweRecordType: oweRecordDraft.oweType,
        ),
      ),
    );
  }

  void _navigateToEditAmount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordAmountStepContainer(
          oweRecordDraftToEdit: oweRecordDraft,
          recordDebtor: recordDebtor,
          oweRecordType: oweRecordDraft.oweType,
        ),
      ),
    );
  }

  void _navigateToEditDescription(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordDescriptionStepContainer(
          oweRecordDraft: oweRecordDraft,
          recordDebtor: recordDebtor,
        ),
      ),
    );
  }

  void _navigateToEditDate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordDateStepPage(
          oweRecordDraft: oweRecordDraft,
          recordDebtor: recordDebtor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Owns direction
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: recordDebtor.name,
                      style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                      children: [
                        TextSpan(
                          text: ' has a new ',
                          style: AppTextStyles.subtitle,
                        ),
                        TextSpan(
                          text: oweRecordDraft.oweType.label,
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        TextSpan(text: ' with you', style: AppTextStyles.subtitle),
                      ],
                    ),
                    overflow: TextOverflow.clip,
                    style: AppTextStyles.subtitle,
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditDebtor(context),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 16),
            //Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    overflow: TextOverflow.clip,
                    TextSpan(
                      text: 'Amount: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: oweRecordDraft.amount?.toString() ?? 'R\$0,00',
                          style:
                              AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditAmount(context),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 16),
            //Description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO test if null or empty check necessary
                Expanded(
                  child: Text.rich(
                    overflow: TextOverflow.clip,
                    TextSpan(
                      text: 'Description: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: oweRecordDraft.description ?? 'Not specified',
                          style:
                              AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditDescription(context),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 16),
            //Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Date: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: oweRecordDraft.date != null
                            ? AppDateUtils.getFormattedDate(oweRecordDraft.date!)
                            : 'Not specified',
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditDate(context),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
