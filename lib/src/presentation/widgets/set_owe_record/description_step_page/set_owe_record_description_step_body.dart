import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_favorite_button.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_favorite_descriptions_section.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_text_form_field.dart';

class SetOweRecordDescriptionStepBody extends StatelessWidget {
  final String initialDescription;
  final List<FavoriteDescription> initialFavoriteDescriptions;
  final OweType oweRecordType;
  final bool isReviewing;

  const SetOweRecordDescriptionStepBody({
    super.key,
    required this.initialDescription,
    required this.initialFavoriteDescriptions,
    required this.oweRecordType,
    required this.isReviewing,
  });

  String get _stepTitle => 'Descreva a que se refere este ${oweRecordType.label}:';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_stepTitle, style: AppTextStyles.subtitle),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SetOweRecordDescriptionTextFormField(
                      initialDescription: initialDescription,
                    ),
                  ),
                  const SetOweRecordDescriptionStepFavoriteButton(),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SetOweRecordDescriptionStepFavoriteDescriptionsSection(
              initialFavoriteDescriptions: initialFavoriteDescriptions,
              oweRecordType: oweRecordType,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SetOweRecordDescriptionStepPrimaryButton(
            isReviewing: isReviewing,
          ),
        )
      ],
    );
  }
}
