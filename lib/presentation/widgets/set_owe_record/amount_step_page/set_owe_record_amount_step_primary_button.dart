import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordAmountStepPrimaryButton extends StatelessWidget {
  const SetOweRecordAmountStepPrimaryButton({super.key});

  void _navigateToNextPage(BuildContext context) {
    context
        .read<SetOweRecordAmountStepBloc>()
        .add(SetOweRecordAmountStepNextPageRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () => _navigateToNextPage(context),
    );
  }
}
