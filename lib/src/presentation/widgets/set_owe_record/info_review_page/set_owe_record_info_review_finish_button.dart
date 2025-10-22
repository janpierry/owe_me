import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class SetOweRecordInfoReviewFinishButton extends StatelessWidget {
  final bool isEditing;

  const SetOweRecordInfoReviewFinishButton({
    super.key,
    required this.isEditing,
  });

  void _requestToSetRecord(BuildContext context) {
    context
        .read<SetOweRecordInfoReviewBloc>()
        .add(SetOweRecordInfoReviewSetRecordRequested());
  }

  @override
  Widget build(BuildContext context) {
    return OweMeElevatedButton(
      label: isEditing ? 'Salvar alterações' : 'Confirmar',
      onPressed: () => _requestToSetRecord(context),
    );
  }
}
