import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/src/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_info_review_page.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_page.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/debtor_selection_page/set_payment_record_debtor_selection_body.dart';

class SetPaymentRecordDebtorSelectionPage extends StatelessWidget {
  final PaymentRecordDraft? paymentRecordDraftToEdit;

  const SetPaymentRecordDebtorSelectionPage({
    super.key,
    this.paymentRecordDraftToEdit,
  });

  void _handleNavigationOnDebtorSelected(BuildContext context, Debtor selectedDebtor) {
    if (_isEdition) {
      _navigateToInfoReview(context, selectedDebtor);
    } else {
      _navigateToNextStep(context, selectedDebtor);
    }
  }

  void _navigateToInfoReview(BuildContext context, Debtor selectedDebtor) {
    _popCurrentEditDebtorPageAndPreviousInfoReviewPage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordInfoReviewPage(
          paymentRecordDraft: paymentRecordDraftToEdit!,
          recordDebtor: selectedDebtor,
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
        ),
      ),
    );
  }

  bool get _isEdition => paymentRecordDraftToEdit != null;

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
