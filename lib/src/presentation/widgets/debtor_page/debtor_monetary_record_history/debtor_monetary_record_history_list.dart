import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_list_item/debtor_monetary_record_list_item.dart';

class DebtorMonetaryRecordHistoryList extends StatelessWidget {
  final List<MonetaryRecord> monetaryRecords;
  final Debtor debtor;

  const DebtorMonetaryRecordHistoryList({
    super.key,
    required this.monetaryRecords,
    required this.debtor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final currentRecord = monetaryRecords[index];
        return DebtorMonetaryRecordListItem(
          monetaryRecord: currentRecord,
          recordDebtor: debtor,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: monetaryRecords.length,
    );
  }
}
