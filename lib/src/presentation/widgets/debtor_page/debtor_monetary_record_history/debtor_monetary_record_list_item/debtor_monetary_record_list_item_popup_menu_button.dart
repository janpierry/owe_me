import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/monetary_record_ui_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_list_item/remove_debtor_monetary_record_confirmation_dialog.dart';

class DebtorMonetaryRecordListItemPopupMenuButton extends StatelessWidget {
  final MonetaryRecord monetaryRecord;
  final Debtor recordDebtor;

  const DebtorMonetaryRecordListItemPopupMenuButton({
    super.key,
    required this.monetaryRecord,
    required this.recordDebtor,
  });

  void _navigateToEditMonetaryRecordPage(BuildContext context) {
    final record = monetaryRecord;
    final page = switch (record) {
      PaymentRecord() => SetPaymentRecordPage(
          recordDebtor: recordDebtor,
          paymentRecordToEdit: record,
          fromDebtorPage: true,
        ),
      OweRecord() => SetOweRecordAmountStepContainer(
          recordDebtor: recordDebtor,
          oweRecordType: record.oweType,
          oweRecordToEdit: record,
          fromDebtorPage: true,
        ),
    };
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> _showRemoveMonetaryRecordConfirmationDialog(BuildContext context) {
    final bloc = context.read<DebtorBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RemoveDebtorMonetaryRecordConfirmationDialog(
        onRemoveMonetaryRecordPressed: () => bloc.add(
          DebtorRemoveMonetaryRecordRequested(monetaryRecord: monetaryRecord),
        ),
        monetaryRecord: monetaryRecord,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupMenuButtonOptions>(
      icon: const Icon(
        Icons.more_vert,
        color: OweMeColors.textGray,
      ),
      onSelected: (value) {
        switch (value) {
          case _PopupMenuButtonOptions.edit:
            _navigateToEditMonetaryRecordPage(context);
            break;
          case _PopupMenuButtonOptions.remove:
            _showRemoveMonetaryRecordConfirmationDialog(context);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _PopupMenuButtonOptions.edit,
          child: Text('Editar ${monetaryRecord.typeLabel}'),
        ),
        PopupMenuItem(
          value: _PopupMenuButtonOptions.remove,
          child: Text('Remover ${monetaryRecord.typeLabel}'),
        ),
      ],
    );
  }
}

enum _PopupMenuButtonOptions { edit, remove }
