import 'package:flutter/material.dart';
import 'package:owe_me/src/presentation/widgets/shared/remove_confirmation_dialog.dart';

class RemoveDebtorConfirmationDialog extends StatelessWidget {
  final VoidCallback? onRemoveDebtorPressed;

  const RemoveDebtorConfirmationDialog({super.key, this.onRemoveDebtorPressed});

  @override
  Widget build(BuildContext context) {
    return RemoveConfirmationDialog(
      title: 'Excluir o Devedor?',
      description:
          'Esta ação vai excluir permatentemente este devedor e todos os registros associados a ele. Esta ação não poderá ser desfeita.',
      onRemovePressed: onRemoveDebtorPressed,
    );
  }
}
