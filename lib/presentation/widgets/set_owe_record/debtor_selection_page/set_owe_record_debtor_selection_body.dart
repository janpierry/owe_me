import 'package:flutter/widgets.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/enums/owe_type.dart';
import 'package:owe_me/presentation/extensions/owe_type_ui.dart';
import 'package:owe_me/presentation/shared/callbacks.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';
import 'package:owe_me/presentation/widgets/shared/debtor_selection_list/debtor_selection_list.dart';

class SetOweRecordDebtorSelectionBody extends StatelessWidget {
  final List<Debtor> debtors;
  final DebtorSelectedCallback onDebtorSelected;
  final OweType oweRecordType;

  const SetOweRecordDebtorSelectionBody({
    super.key,
    required this.debtors,
    required this.onDebtorSelected,
    required this.oweRecordType,
  });

  String get _stepTitle =>
      'Select the debtor who has a new ${oweRecordType.label} with you';

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
                  _stepTitle,
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
