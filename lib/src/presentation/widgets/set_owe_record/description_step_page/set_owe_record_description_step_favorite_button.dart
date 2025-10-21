import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';

class SetOweRecordDescriptionStepFavoriteButton extends StatelessWidget {
  const SetOweRecordDescriptionStepFavoriteButton({super.key});

  void _addDescriptionToFavorites(BuildContext context) {
    context
        .read<SetOweRecordDescriptionStepBloc>()
        .add(const SetOweRecordDescriptionStepDescriptionAddedToFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _addDescriptionToFavorites(context),
      color: OweMeColors.primaryBlue,
      highlightColor: OweMeColors.primaryBlueLight,
      icon: const Icon(Icons.star_border),
    );
  }
}
