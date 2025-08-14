import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_history_builder.dart';

class DebtorMonetaryRecordHistorySection extends StatelessWidget {
  const DebtorMonetaryRecordHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histórico',
          style: AppTextStyles.headline2,
        ),
        const SizedBox(height: 8),
        const DebtorMonetaryRecordHistoryBuilder(),
      ],
    );
  }
}
