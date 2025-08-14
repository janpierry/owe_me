import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/debtor_selection_page/set_owe_record_debtor_selection_body.dart';

class SetOweRecordDebtorSelectionPage extends StatelessWidget {
  final OweType oweRecordType;
  final OweRecordDraft? oweRecordDraftToEdit;

  const SetOweRecordDebtorSelectionPage({
    super.key,
    required this.oweRecordType,
    required this.oweRecordDraftToEdit,
  });

  void _handleNavigationOnDebtorSelected(BuildContext context, Debtor selectedDebtor) {
    if (_isEdition) {
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
        ),
      ),
    );
  }

  void _navigateToInfoReview(BuildContext context, Debtor selectedDebtor) {
    _popCurrentEditDebtorPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetOweRecordInfoReviewContainer(
          oweRecordDraft: oweRecordDraftToEdit!,
          recordDebtor: selectedDebtor,
        ),
      ),
    );
  }

  void _popCurrentEditDebtorPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  bool get _isEdition => oweRecordDraftToEdit != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione o Devedor', style: AppTextStyles.headline1),
        backgroundColor: AppColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: AppColors.backgroundLight,
      body: BlocBuilder<DebtorsBloc, DebtorsState>(
        builder: (context, state) {
          if (state is DebtorsLoaded) {
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
