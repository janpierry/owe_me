import 'package:flutter/widgets.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/shared/callbacks.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';
import 'package:owe_me/presentation/widgets/shared/debtor_selection_list/debtor_selection_list.dart';

class SetPaymentRecordDebtorSelectionBody extends StatelessWidget {
  final List<Debtor> debtors;
  final DebtorSelectedCallback onDebtorSelected;

  const SetPaymentRecordDebtorSelectionBody({
    super.key,
    required this.debtors,
    required this.onDebtorSelected,
  });

  String get _title => 'Select the debtor who is paying you';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  style: AppTextStyles.body.copyWith(color: AppColors.textGray),
                ),
                const SizedBox(height: 12),
                //TODO filter
                DebtorSelectionList(
                  debtors: debtors,
                  onDebtorSelected: onDebtorSelected,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
