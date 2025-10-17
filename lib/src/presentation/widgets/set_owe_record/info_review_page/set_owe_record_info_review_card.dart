import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/core/presentation/utils/app_date_utils.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_debtor_selection_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_description_step_container.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class SetOweRecordInfoReviewCard extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetOweRecordInfoReviewCard({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.fromDebtorPage,
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
          fromDebtorPage: fromDebtorPage,
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
          fromDebtorPage: fromDebtorPage,
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
          fromDebtorPage: fromDebtorPage,
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
          fromDebtorPage: fromDebtorPage,
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
                      text: recordDebtor.nickname,
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                      children: [
                        TextSpan(
                          text: ' tem um novo ',
                          style: AppTextStyles.subtitle,
                        ),
                        TextSpan(
                          text: oweRecordDraft.oweType.label,
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        TextSpan(text: ' com você', style: AppTextStyles.subtitle),
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
                      text: 'Valor: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: MoneyFormatter.toStringCurrencyNullable(
                            oweRecordDraft.amount,
                          ),
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primaryBlue,
                          ),
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
                      text: 'Descrição: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: oweRecordDraft.description ?? 'Não informada',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primaryBlue,
                          ),
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
                    text: 'Data: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: oweRecordDraft.date != null
                            ? AppDateUtils.getFormattedDate(oweRecordDraft.date!)
                            : 'Não informada',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.primaryBlue,
                        ),
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
