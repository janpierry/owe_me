import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class SetPaymentRecordInfoReviewFinishButton extends StatelessWidget {
  final bool isEditing;

  const SetPaymentRecordInfoReviewFinishButton({super.key, required this.isEditing});

  void _requestRecordSetting(BuildContext context) {
    context
        .read<SetPaymentRecordInfoReviewBloc>()
        .add(SetPaymentRecordInfoReviewSetRecordRequested());
  }

  @override
  Widget build(BuildContext context) {
    return OweMeElevatedButton(
      label: isEditing ? 'Salvar alterações' : 'Confirmar',
      onPressed: () => _requestRecordSetting(context),
    );
  }
}
