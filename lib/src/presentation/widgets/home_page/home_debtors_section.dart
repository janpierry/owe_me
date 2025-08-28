import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/home_page/debtors_list.dart';
import 'package:owe_me/src/presentation/widgets/shared/set_debtor_dialog.dart';

class HomeDebtorsSection extends StatelessWidget {
  final List<Debtor> debtors;

  const HomeDebtorsSection({super.key, required this.debtors});

  Future<void> _showAddNewDebtorDialog(BuildContext context) {
    final bloc = context.read<HomeDebtorsBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SetDebtorDialog(
        onSetDebtorPressed: (nickname) => bloc.add(
          HomeAddDebtorRequestedEvent(debtorNickname: nickname),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Devedores',
                style: AppTextStyles.headline2,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 24),
              onPressed: () => _showAddNewDebtorDialog(context),
            )
          ],
        ),
        const SizedBox(height: 8),
        DebtorsList(debtors: debtors),
      ],
    );
  }
}
