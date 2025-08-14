import 'package:flutter/widgets.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/callbacks.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/debtor_selection_list/debtor_selection_list.dart';

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

  String get _stepTitle => 'Quem tem um novo ${oweRecordType.label} com você?';

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
