import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/remove_debtor_confirmation_dialog.dart';
import 'package:owe_me/src/presentation/widgets/shared/set_debtor_dialog.dart';

class DebtorPopupMenuButton extends StatelessWidget {
  final Debtor debtor;

  const DebtorPopupMenuButton({super.key, required this.debtor});

  Future<void> _showSetDebtorDialog(BuildContext context) {
    final bloc = context.read<DebtorBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SetDebtorDialog(
        initialNickname: debtor.nickname,
        onSetDebtorPressed: (nickname) => bloc.add(
          DebtorEditRequested(nickname: nickname),
        ),
      ),
    );
  }

  Future<void> _showRemoveDebtorConfirmationDialog(BuildContext context) {
    final bloc = context.read<DebtorBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RemoveDebtorConfirmationDialog(
        onRemoveDebtorPressed: () => bloc.add(DebtorRemoveRequested()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupMenuButtonOptions>(
      icon: const Icon(
        Icons.more_vert,
        color: OweMeColors.textGray,
      ), //TODO refactor the color names
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
