import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/extensions/monetary_record_ui_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/widgets/shared/remove_confirmation_dialog.dart';

class RemoveDebtorMonetaryRecordConfirmationDialog extends StatelessWidget {
  final MonetaryRecord monetaryRecord;
  final VoidCallback? onRemoveMonetaryRecordPressed;

  const RemoveDebtorMonetaryRecordConfirmationDialog({
    super.key,
    required this.monetaryRecord,
    this.onRemoveMonetaryRecordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RemoveConfirmationDialog(
      title: 'Excluir o ${monetaryRecord.typeLabel}?',
      description:
          'Esta ação vai excluir permatentemente este ${monetaryRecord.typeLabel}. Esta ação não poderá ser desfeita.',
      onRemovePressed: onRemoveMonetaryRecordPressed,
    );
  }
}
