import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/set_debtor_dialog.dart';

class HomeNoDebtorsYetPlaceholder extends StatelessWidget {
  const HomeNoDebtorsYetPlaceholder({super.key});

  Future<void> _showSetDebtorDialog(BuildContext context) {
    final bloc = context.read<HomeDebtorsBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SetDebtorDialog(
        onSetDebtorPressed: (nickname) => bloc.add(
          HomeAddDebtorRequested(debtorNickname: nickname),
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
            Icon(Icons.person, size: 96, color: OweMeColors.gray400),
            const SizedBox(height: 16),
            Text(
              'Sem devedores por enquanto',
              textAlign: TextAlign.center,
              style: OweMeTextStyles.headline2.copyWith(
                fontWeight: FontWeight.w600,
                color: OweMeColors.textGray,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comece adicionando um devedor para acompanhar os débitos, créditos e pagamentos que ele tem com você.',
              textAlign: TextAlign.center,
              style: OweMeTextStyles.body.copyWith(
                color: OweMeColors.gray600,
              ),
            ),
            const SizedBox(height: 24),
            OweMeElevatedButton(
              label: 'Adicionar devedor',
              onPressed: () => _showSetDebtorDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
