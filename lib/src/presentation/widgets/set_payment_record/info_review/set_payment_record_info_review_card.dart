import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/core/presentation/utils/app_date_utils.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_debtor_selection_container.dart';
import 'package:owe_me/src/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

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
                      text: 'Quem está te pagando: ',
                      style: AppTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: recordDebtor.nickname,
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primaryBlue,
                          ),
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
                    text: 'Valor: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: MoneyFormatter.toStringCurrencyNullable(
                          paymentRecordDraft.amount,
                        ),
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.primaryBlue,
                        ),
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
                    text: 'Método de pagamento: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.paymentMethod?.label ?? 'Not specified',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.primaryBlue,
                        ),
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
                    text: 'Data: ',
                    style: AppTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.date != null
                            ? AppDateUtils.getFormattedDate(paymentRecordDraft.date!)
                            : 'Não informada',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.primaryBlue,
                        ),
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
