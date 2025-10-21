import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/extensions/monetary_record_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/core/presentation/date_formats.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_list_item/debtor_monetary_record_list_item_popup_menu_button.dart';

class DebtorMonetaryRecordListItem extends StatelessWidget {
  final MonetaryRecord monetaryRecord;
  final Debtor recordDebtor;

  const DebtorMonetaryRecordListItem({
    super.key,
    required this.monetaryRecord,
    required this.recordDebtor,
  });

  String get _description {
    final record = monetaryRecord;
    switch (record) {
      case PaymentRecord():
        return 'Pagamento no ${record.paymentMethod.label}';
      case OweRecord():
        return record.description ?? 'Sem descrição';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      color: OweMeColors.surfaceWhite,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 4),
        child: Row(
          children: [
            Icon(
              monetaryRecord.iconData,
              color: OweMeColors.primaryBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _description,
                    style: OweMeTextStyles.body,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormats.ddMMMyyyy.format(monetaryRecord.date),
                    style: OweMeTextStyles.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              MoneyFormatter.toStringCurrency(monetaryRecord.amount),
              style: OweMeTextStyles.subtitle,
            ),
            const SizedBox(width: 4),
            DebtorMonetaryRecordListItemPopupMenuButton(
              monetaryRecord: monetaryRecord,
              recordDebtor: recordDebtor,
            ),
          ],
        ),
      ),
    );
  }
}
