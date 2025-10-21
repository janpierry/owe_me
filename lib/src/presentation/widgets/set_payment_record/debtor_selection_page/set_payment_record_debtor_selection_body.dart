import 'package:flutter/widgets.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/core/presentation/callbacks.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/debtor_selection_list/debtor_selection_list.dart';

class SetPaymentRecordDebtorSelectionBody extends StatelessWidget {
  final List<Debtor> debtors;
  final DebtorSelectedCallback onDebtorSelected;

  const SetPaymentRecordDebtorSelectionBody({
    super.key,
    required this.debtors,
    required this.onDebtorSelected,
  });

  String get _title => 'Quem realizou um pagamento a você?';

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
                  style: OweMeTextStyles.body.copyWith(color: OweMeColors.textGray),
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
