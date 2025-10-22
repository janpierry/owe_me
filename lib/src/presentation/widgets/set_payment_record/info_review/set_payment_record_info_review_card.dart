import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/core/presentation/utils/owe_me_date_utils.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_debtor_selection_container.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class SetPaymentRecordInfoReviewCard extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final PaymentRecord? paymentRecordToEdit;
  final bool fromDebtorPage;

  const SetPaymentRecordInfoReviewCard({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.paymentRecordToEdit,
    required this.fromDebtorPage,
  });

  //TODO check this
  //Flow of feature: SetRecordDebtorSelectionPage(OweRecord isDebt hasDebtor)
  //=> SetRecordAmountPage(isEditing) => SetRecordDescriptionPage => SetRecordDatePage =>
  //SetRecordInfoReview => Edit => pop pop push SetRecordInfoReview

  void _navigateToEditDebtor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordDebtorSelectionContainer(
          paymentRecordDraftToReview: paymentRecordDraft,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _navigateToEditRecordData(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordPage(
          paymentRecordDraftToReview: paymentRecordDraft,
          recordDebtor: recordDebtor,
          paymentRecordToEdit: paymentRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: OweMeColors.surfaceWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Quem te pagou: ',
                      style: OweMeTextStyles.subtitle,
                      children: [
                        TextSpan(
                          text: recordDebtor.nickname,
                          style: OweMeTextStyles.subtitle.copyWith(
                            color: OweMeColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.clip,
                    style: OweMeTextStyles.subtitle,
                  ),
                ),
                if (paymentRecordToEdit == null)
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
                    style: OweMeTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: MoneyFormatter.toStringCurrencyNullable(
                          paymentRecordDraft.amount,
                        ),
                        style: OweMeTextStyles.subtitle.copyWith(
                          color: OweMeColors.primaryBlue,
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
                Text.rich(
                  TextSpan(
                    text: 'Método de pagamento: ',
                    style: OweMeTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.paymentMethod?.label ?? 'Não informado',
                        style: OweMeTextStyles.subtitle.copyWith(
                          color: OweMeColors.primaryBlue,
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
                    style: OweMeTextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: paymentRecordDraft.date != null
                            ? OweMeDateUtils.getFormattedDate(paymentRecordDraft.date!)
                            : 'Não informada',
                        style: OweMeTextStyles.subtitle.copyWith(
                          color: OweMeColors.primaryBlue,
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
