import 'package:flutter/material.dart';
import 'package:owe_me/core/utils/app_date_utils.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/containers/set_payment_record/set_payment_record_debtor_selection_container.dart';
import 'package:owe_me/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/presentation/extensions/payment_method_ui.dart';
import 'package:owe_me/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class SetPaymentRecordInfoReviewCard extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;

  const SetPaymentRecordInfoReviewCard({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
  });

  //TODO check this
  //Flow of feature: SetRecordDebtorSelectionPage(OweRecord isDebt hasDebtor)
  //=> SetRecordAmountPage(isEditing) => SetRecordDescriptionPage => SetRecordDatePage =>
  //SetRecordInfoReview => Edit => pop pop push SetRecordInfoReview

  void _navigateToEditDebtor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordDebtorSelectionContainer(
          paymentRecordDraftToEdit: paymentRecordDraft,
        ),
      ),
    );
  }

  void _navigateToEditRecordData(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordPage(
          paymentRecordDraftToEdit: paymentRecordDraft,
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
            //TODO check this
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Who is paying you: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: recordDebtor.name,
                          style:
                              AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                        ),
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
                Text.rich(
                  TextSpan(
                    text: 'Amount: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.amount?.toString() ?? 'R\$0,00',
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditRecordData(context),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 16),
            //Payment method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO test if null or empty check necessary
                Text.rich(
                  TextSpan(
                    text: 'Payment method: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.paymentMethod?.label ?? 'Not specified',
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditRecordData(context),
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
                        text: paymentRecordDraft.date != null
                            ? AppDateUtils.getFormattedDate(paymentRecordDraft.date!)
                            : 'Not specified',
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToEditRecordData(context),
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
