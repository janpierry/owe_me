import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/domain/entities/favorite_description.dart';
import 'package:owe_me/domain/enums/owe_type.dart';
import 'package:owe_me/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/presentation/extensions/owe_type_ui.dart';

class SetOweRecordDescriptionStepFavoriteDescriptionsSection extends StatelessWidget {
  final List<FavoriteDescription> initialFavoriteDescriptions;
  final OweType oweRecordType;

  const SetOweRecordDescriptionStepFavoriteDescriptionsSection({
    super.key,
    required this.initialFavoriteDescriptions,
    required this.oweRecordType,
  });

  String get _sugestedDescriptionsLabel =>
      'Sugestões de ${oweRecordType.labelPlural} favoritos:';

  void _selectFavoriteDescription(
    BuildContext context,
    FavoriteDescription selectedDescription,
  ) {
    context.read<SetOweRecordDescriptionStepBloc>().add(
          SetOweRecordDescriptionStepFavoriteDescriptionSelectedEvent(
            selectedDescription: selectedDescription,
          ),
        );
  }

  void _listen(BuildContext context, SetOweRecordDescriptionStepState state) {
    if (state is SetOweRecordDescriptionStepFavoriteDescriptionsError) {
      const snackBar = SnackBar(content: Text('Description already in favorites'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetOweRecordDescriptionStepBloc,
        SetOweRecordDescriptionStepState>(
      listener: _listen,
      buildWhen: (previous, current) =>
          current is SetOweRecordDescriptionStepFavoriteDescriptionsState,
      builder: (context, state) {
        if (state is SetOweRecordDescriptionStepFavoriteDescriptionsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final favoriteDescriptions =
            state is SetOweRecordDescriptionStepFavoriteDescriptionsUpdated
                ? state.favoriteDescriptions
                : initialFavoriteDescriptions;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_sugestedDescriptionsLabel),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: favoriteDescriptions
                  .map(
                    (favoriteDescription) => ChoiceChip(
                      label: Text(favoriteDescription.description),
                      selected: false,
                      shape: const StadiumBorder(),
                      onSelected: (value) =>
                          _selectFavoriteDescription(context, favoriteDescription),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
