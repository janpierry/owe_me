import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_step_body.dart';

class SetOweRecordDescriptionStepPage extends StatelessWidget {
  final OweType oweRecordType;
  final OweRecord? oweRecordToEdit;
  final bool isReviewing;
  final bool fromDebtorPage;

  const SetOweRecordDescriptionStepPage({
    super.key,
    required this.oweRecordType,
    required this.oweRecordToEdit,
    required this.isReviewing,
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
    if (isReviewing) {
      _finishInfoReview(context, state);
    } else {
      _navigateToDateStep(context, state);
    }
  }

  void _finishInfoReview(
    BuildContext context,
    SetOweRecordDescriptionStepNavigatingToNextPage state,
  ) {
    _popCurrentDescriptionPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: state.oweRecordDraft,
          recordDebtor: state.recordDebtor,
          oweRecordToEdit: oweRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _popCurrentDescriptionPageAndPreviousInfoReviewPage(BuildContext context) {
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
          oweRecordToEdit: oweRecordToEdit,
          isReviewing: false,
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
          'Descreva o ${oweRecordType.label}',
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
              oweRecordType: oweRecordType,
              isReviewing: isReviewing,
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
