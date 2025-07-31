import 'package:flutter/material.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/shared/callbacks.dart';
import 'package:owe_me/presentation/widgets/shared/debtor_selection_list/debtor_selection_list_item.dart';

class DebtorSelectionList extends StatelessWidget {
  final List<Debtor> debtors;
  final DebtorSelectedCallback onDebtorSelected;

  const DebtorSelectionList({
    super.key,
    required this.debtors,
    required this.onDebtorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DebtorSelectionListItem(
          debtor: debtors[index],
          onDebtorSelected: onDebtorSelected,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: debtors.length,
    );
  }
}
