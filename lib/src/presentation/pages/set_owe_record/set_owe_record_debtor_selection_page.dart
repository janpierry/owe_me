import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor_selection/debtor_selection_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/debtor_selection_page/set_owe_record_debtor_selection_body.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';

class SetOweRecordDebtorSelectionPage extends StatelessWidget {
  final OweType oweRecordType;
  final OweRecordDraft? oweRecordDraftToReview;
  final bool fromDebtorPage;

  const SetOweRecordDebtorSelectionPage({
    super.key,
    required this.oweRecordType,
    required this.oweRecordDraftToReview,
    required this.fromDebtorPage,
  });

  void _handleNavigationOnDebtorSelected(BuildContext context, Debtor selectedDebtor) {
    final isReviewing = oweRecordDraftToReview != null;
    if (isReviewing) {
      _navigateToInfoReview(context, selectedDebtor);
    } else {
      _navigateToNextStep(context, selectedDebtor);
    }
  }

  void _navigateToNextStep(BuildContext context, Debtor selectedDebtor) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordAmountStepContainer(
          recordDebtor: selectedDebtor,
          oweRecordType: oweRecordType,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _navigateToInfoReview(BuildContext context, Debtor selectedDebtor) {
    _popCurrentEditDebtorPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: oweRecordDraftToReview!,
          recordDebtor: selectedDebtor,
          oweRecordToEdit: null,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _popCurrentEditDebtorPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: 'Selecione o Devedor',
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: BlocBuilder<DebtorSelectionBloc, DebtorSelectionState>(
        builder: (context, state) {
          if (state is DebtorSelectionLoadDebtorsSuccess) {
            return SetOweRecordDebtorSelectionBody(
              debtors: state.debtors,
              onDebtorSelected: (debtor) => _handleNavigationOnDebtorSelected(
                context,
                debtor,
              ),
              oweRecordType: oweRecordType,
            );
          }
          //TODO implement error state handling here and in payment selection page
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
