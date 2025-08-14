import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/set_debtor_dialog.dart';

class HomeNoDebtorsYetPlaceholder extends StatelessWidget {
  const HomeNoDebtorsYetPlaceholder({super.key});

  Future<void> _showSetDebtorDialog(BuildContext context) {
    final bloc = context.read<DebtorsBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SetDebtorDialog(
        onSetDebtorPressed: (nickname) => bloc.add(
          AddDebtorRequestedEvent(debtorNickname: nickname),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 96, color: AppColors.gray400),
            const SizedBox(height: 16),
            Text(
              'Sem devedores por enquanto',
              textAlign: TextAlign.center,
              style: AppTextStyles.headline2.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textGray,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comece adicionando um devedor para acompanhar os débitos, créditos e pagamentos que ele tem com você.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.gray600,
              ),
            ),
            const SizedBox(height: 24),
            AppElevatedButton(
              label: 'Adicionar devedor',
              onPressed: () => _showSetDebtorDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
