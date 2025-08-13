import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/blocs/debtor_monetary_record_history/debtor_monetary_record_history_bloc.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/widgets/debtor_page/remove_debtor_confirmation_dialog.dart';
import 'package:owe_me/presentation/widgets/shared/set_debtor_dialog.dart';

class DebtorPopupMenuButton extends StatelessWidget {
  final Debtor debtor;

  const DebtorPopupMenuButton({super.key, required this.debtor});

  Future<void> _showSetDebtorDialog(BuildContext context) {
    // final bloc = context.read<DebtorMonetaryRecordHistoryBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SetDebtorDialog(
        initialNickname: debtor.nickname,
        //TODO pass just the nickname to bloc after refactoring
        //TODO uncomment this when edition is ready
        // onSetDebtorPressed: (nickname) => bloc.add(
        //   EditDebtorRequestedEvent(debtor: debtor.copyWith(nickname: nickname)),
        // ),
      ),
    );
  }

  Future<void> _showRemoveDebtorConfirmationDialog(BuildContext context) {
    final bloc = context.read<DebtorMonetaryRecordHistoryBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RemoveDebtorConfirmationDialog(
        onRemoveDebtorPressed: () => bloc.add(RemoveDebtorRequestedEvent(debtor: debtor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupMenuButtonOptions>(
      icon: const Icon(Icons.more_vert,
          color: AppColors.textGray), //TODO refactor the color names
      onSelected: (value) {
        switch (value) {
          case _PopupMenuButtonOptions.edit:
            _showSetDebtorDialog(context);
            break;
          case _PopupMenuButtonOptions.remove:
            _showRemoveDebtorConfirmationDialog(context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _PopupMenuButtonOptions.edit,
          child: Text('Editar devedor'),
        ),
        const PopupMenuItem(
          value: _PopupMenuButtonOptions.remove,
          child: Text('Excluir devedor'),
        ),
      ],
    );
  }
}

enum _PopupMenuButtonOptions { edit, remove }
