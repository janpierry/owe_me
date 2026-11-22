import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class SetPaymentRecordInfoReviewFinishButton extends StatelessWidget {
  final bool isEditing;

  const SetPaymentRecordInfoReviewFinishButton({super.key, required this.isEditing});

  void _requestToSetRecord(BuildContext context) {
    context
        .read<SetPaymentRecordInfoReviewBloc>()
        .add(SetPaymentRecordInfoReviewSetRecordRequested());
  }

  // Stays locked after success too: the page is navigating away, and a tap
  // during the transition would start a second save.
  bool _isSaving(SetPaymentRecordInfoReviewState state) =>
      state is SetPaymentRecordInfoReviewSettingRecord ||
      state is SetPaymentRecordInfoReviewRecordSetFinished;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPaymentRecordInfoReviewBloc, SetPaymentRecordInfoReviewState>(
      buildWhen: (previous, current) => _isSaving(previous) != _isSaving(current),
      builder: (context, state) => OweMeElevatedButton(
        label: isEditing ? 'Salvar alterações' : 'Confirmar',
        isLoading: _isSaving(state),
        onPressed: () => _requestToSetRecord(context),
      ),
    );
  }
}
