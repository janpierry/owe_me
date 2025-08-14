import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordDescriptionStepPrimaryButton extends StatelessWidget {
  const SetOweRecordDescriptionStepPrimaryButton({super.key});

  void _navigateToNextPage(BuildContext context) {
    context
        .read<SetOweRecordDescriptionStepBloc>()
        .add(SetOweRecordDescriptionStepNextPageRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () => _navigateToNextPage(context),
    );
  }
}
