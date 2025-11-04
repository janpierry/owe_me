import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/form/set_payment_record_form_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class SetPaymentRecordFormPrimaryButton extends StatelessWidget {
  final bool isEnabled;
  final bool isReviewing;

  const SetPaymentRecordFormPrimaryButton({
    super.key,
    required this.isEnabled,
    required this.isReviewing,
  });

  void _navigateToNextPage(BuildContext context) {
    context.read<SetPaymentRecordFormBloc>().add(SetPaymentRecordFormNextPageRequested());
  }

  @override
  Widget build(BuildContext context) {
    return OweMeElevatedButton(
      label: isReviewing ? 'Salvar alterações' : 'Continuar',
      onPressed: isEnabled ? () => _navigateToNextPage(context) : null,
    );
  }
}
