import 'package:flutter/material.dart';
import 'package:owe_me/core/utils/date_formatters.dart';
import 'package:owe_me/domain/entities/payment_record.dart';
import 'package:owe_me/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

//TODO merge this with DebtorOweRecordListItem
class DebtorPaymentRecordListItem extends StatelessWidget {
  final PaymentRecord paymentRecord;

  const DebtorPaymentRecordListItem({super.key, required this.paymentRecord});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      color: AppColors.surfaceWhite,
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.payment,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pagamento no ${paymentRecord.paymentMethod.label}',
                    style: AppTextStyles.subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormatters.ddMMMyyyy.format(paymentRecord.date),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              paymentRecord.amount.toString(),
              style: AppTextStyles.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
