import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_description_step_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/amount_step_page/set_owe_record_amount_step_body.dart';

class SetOweRecordAmountStepPage extends StatelessWidget {
  final Debtor recordDebtor;
  final OweType oweRecordType;
  final OweRecord? oweRecordToEdit;
  final OweRecordDraft? oweRecordDraftToReview;
  final bool fromDebtorPage;

  const SetOweRecordAmountStepPage({
    super.key,
    required this.recordDebtor,
    required this.oweRecordType,
    required this.oweRecordToEdit,
    required this.oweRecordDraftToReview,
    required this.fromDebtorPage,
  });

  void _listen(BuildContext context, SetOweRecordAmountStepState state) {
    if (state is SetOweRecordAmountStepNavigatingToNextPage) {
      _navigateToNextPage(context, state);
    }
  }

  void _navigateToNextPage(
    BuildContext context,
    SetOweRecordAmountStepNavigatingToNextPage state,
  ) {
    final isReviewing = oweRecordDraftToReview != null;
    if (isReviewing) {
      _finishInfoReview(context, state.amount);
    } else {
      _navigateToDescriptionStep(context, state.amount);
    }
  }

  void _finishInfoReview(BuildContext context, Money amount) {
    _popCurrentEditAmountPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: oweRecordDraftToReview!.copyWith(amount: amount),
          recordDebtor: recordDebtor,
          oweRecordToEdit: oweRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _popCurrentEditAmountPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToDescriptionStep(
    BuildContext context,
    Money amount,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordDescriptionStepContainer(
          oweRecordDraft: OweRecordDraft(
            oweType: oweRecordType,
            amount: amount,
          ),
          recordDebtor: recordDebtor,
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
          'Informe o Valor',
          style: OweMeTextStyles.headline1,
        ),
        backgroundColor: OweMeColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      body: BlocConsumer<SetOweRecordAmountStepBloc, SetOweRecordAmountStepState>(
        listener: _listen,
        buildWhen: (_, current) => current is SetOweRecordAmountStepPageBuildState,
        builder: (context, state) {
          if (state is SetOweRecordAmountStepPageLoaded) {
            return SetOweRecordAmountStepBody(
              recordDebtor: recordDebtor,
              oweRecordType: oweRecordType,
              amountToEdit: state.amountToEdit,
              isReviewing: oweRecordDraftToReview != null,
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
