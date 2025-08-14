import 'package:flutter/material.dart';
import 'package:owe_me/src/presentation/widgets/home_page/debtor_list_item.dart';

import '../../../domain/entities/debtor.dart';

class DebtorsList extends StatelessWidget {
  final List<Debtor> debtors;

  const DebtorsList({
    super.key,
    required this.debtors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DebtorListItem(debtor: debtors[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: debtors.length,
    );
  }
}
