import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_elevated_button.dart';

class SetOweRecordInfoReviewFinishButton extends StatelessWidget {
  const SetOweRecordInfoReviewFinishButton({super.key});

  //TODO fix name
  void _requestRecordSetting(BuildContext context) {
    context
        .read<SetOweRecordInfoReviewBloc>()
        .add(SetOweRecordInfoReviewSetRecordRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      label: 'Confirmar',
      onPressed: () => _requestRecordSetting(context),
    );
  }
}
