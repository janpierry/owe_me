import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_body.dart';

class SetOweRecordDescriptionStepPage extends StatelessWidget {
  const SetOweRecordDescriptionStepPage({
    super.key,
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              isEdition: state.isEdition,
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
