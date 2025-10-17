import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_body.dart';

class SetOweRecordDescriptionStepPage extends StatelessWidget {
  final bool fromDebtorPage;

  const SetOweRecordDescriptionStepPage({
    super.key,
    required this.fromDebtorPage,
  });

  void _listen(BuildContext context, SetOweRecordDescriptionStepState state) {
    if (state is SetOweRecordDescriptionStepNavigatingToNextPage) {
      _navigateToNextPage(context, state);
    }
  }

  void _navigateToNextPage(
    BuildContext context,
    SetOweRecordDescriptionStepNavigatingToNextPage state,
  ) {
    final isEdition = state.isEdition;
    if (isEdition) {
      _finishEdition(context, state);
    } else {
      _navigateToDateStep(context, state);
    }
  }

  void _finishEdition(
    BuildContext context,
    SetOweRecordDescriptionStepNavigatingToNextPage state,
  ) {
    _popCurrentEditDescriptionPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: state.oweRecordDraft,
          recordDebtor: state.recordDebtor,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _popCurrentEditDescriptionPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToDateStep(
    BuildContext context,
    SetOweRecordDescriptionStepNavigatingToNextPage state,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordDateStepPage(
          oweRecordDraft: state.oweRecordDraft,
          recordDebtor: state.recordDebtor,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicione uma Descrição',
          style: AppTextStyles.headline1,
        ),
        backgroundColor: AppColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      body:
          BlocConsumer<SetOweRecordDescriptionStepBloc, SetOweRecordDescriptionStepState>(
        listener: _listen,
        buildWhen: (previous, current) =>
            current is SetOweRecordDescriptionStepPageBuildState,
        builder: (context, state) {
          if (state is SetOweRecordDescriptionStepPageLoaded) {
            return SetOweRecordDescriptionStepBody(
              initialDescription: state.initialDescription,
              initialFavoriteDescriptions: state.initialFavoriteDescriptions,
              oweRecordType: state.oweRecordType,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
