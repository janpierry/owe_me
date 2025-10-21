import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor_selection/debtor_selection_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_info_review_container.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/debtor_selection_page/set_payment_record_debtor_selection_body.dart';

class SetPaymentRecordDebtorSelectionPage extends StatelessWidget {
  final PaymentRecordDraft? paymentRecordDraftToReview;
  final bool fromDebtorPage;

  const SetPaymentRecordDebtorSelectionPage({
    super.key,
    this.paymentRecordDraftToReview,
    required this.fromDebtorPage,
  });

  void _handleNavigationOnDebtorSelected(BuildContext context, Debtor selectedDebtor) {
    if (_isReviewing) {
      _navigateToInfoReview(context, selectedDebtor);
    } else {
      _navigateToNextStep(context, selectedDebtor);
    }
  }

  void _navigateToInfoReview(BuildContext context, Debtor selectedDebtor) {
    _popCurrentEditDebtorPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordInfoReviewContainer(
          paymentRecordDraft: paymentRecordDraftToReview!,
          recordDebtor: selectedDebtor,
          paymentRecordToEdit: null,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _popCurrentEditDebtorPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToNextStep(BuildContext context, Debtor selectedDebtor) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordPage(
          recordDebtor: selectedDebtor,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  bool get _isReviewing => paymentRecordDraftToReview != null;

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
      body: BlocBuilder<DebtorSelectionBloc, DebtorSelectionState>(
        builder: (context, state) {
          if (state is DebtorSelectionLoadDebtorsSuccess) {
            return SetPaymentRecordDebtorSelectionBody(
              debtors: state.debtors,
              onDebtorSelected: (debtor) => _handleNavigationOnDebtorSelected(
                context,
                debtor,
              ),
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
