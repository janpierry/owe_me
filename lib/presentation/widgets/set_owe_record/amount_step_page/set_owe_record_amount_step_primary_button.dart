import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordAmountStepPrimaryButton extends StatelessWidget {
  final bool isEdition;

  const SetOweRecordAmountStepPrimaryButton({
    super.key,
    required this.isEdition,
  });

  void _navigateToNextPage(BuildContext context) {
    context
        .read<SetOweRecordAmountStepBloc>()
        .add(SetOweRecordAmountStepNextPageRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: isEdition ? 'Confirmar' : 'Próximo',
      onPressed: () => _navigateToNextPage(context),
    );
  }
}
