import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordAmountStepPrimaryButton extends StatelessWidget {
  final bool isReviewing;

  const SetOweRecordAmountStepPrimaryButton({
    super.key,
    required this.isReviewing,
  });

  void _navigateToNextPage(BuildContext context) {
    context
        .read<SetOweRecordAmountStepBloc>()
        .add(SetOweRecordAmountStepNextPageRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: isReviewing ? 'Salvar alterações' : 'Continuar',
      onPressed: () => _navigateToNextPage(context),
    );
  }
}
