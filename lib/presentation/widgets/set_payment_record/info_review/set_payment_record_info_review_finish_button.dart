import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/presentation/widgets/shared/app_elevated_button.dart';

class SetPaymentRecordInfoReviewFinishButton extends StatelessWidget {
  const SetPaymentRecordInfoReviewFinishButton({super.key});

  void _requestRecordSetting(BuildContext context) {
    context
        .read<SetPaymentRecordInfoReviewBloc>()
        .add(SetPaymentRecordInfoReviewSetRecordRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () => _requestRecordSetting(context),
    );
  }
}
