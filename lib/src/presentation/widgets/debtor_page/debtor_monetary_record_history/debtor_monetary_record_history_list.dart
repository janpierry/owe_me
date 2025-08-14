import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/owe_record.dart';
import 'package:owe_me/src/domain/entities/payment_record.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_owe_record_list_item.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_payment_record_list_item.dart';

class DebtorMonetaryRecordHistoryList extends StatelessWidget {
  final List<MonetaryRecord> monetaryRecords;

  const DebtorMonetaryRecordHistoryList({
    super.key,
    required this.monetaryRecords,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final currentRecord = monetaryRecords[index];
        if (currentRecord is OweRecord) {
          return DebtorOweRecordListItem(
            oweRecord: currentRecord,
          );
        } else if (currentRecord is PaymentRecord) {
          return DebtorPaymentRecordListItem(paymentRecord: currentRecord);
        }
        return const SizedBox.shrink(); // Fallback for unexpected types
      },
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemCount: monetaryRecords.length,
    );
  }
}
