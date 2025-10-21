import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/containers/debtor_container.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/info_review/set_payment_record_info_review_card.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/info_review/set_payment_record_info_review_finish_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';

class SetPaymentRecordInfoReviewPage extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final PaymentRecord? paymentRecordToEdit;
  final bool fromDebtorPage;

  const SetPaymentRecordInfoReviewPage({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.paymentRecordToEdit,
    required this.fromDebtorPage,
  });

  void _listen(
    BuildContext context,
    SetPaymentRecordInfoReviewState state,
  ) {
    if (state is SetPaymentRecordInfoReviewRecordSetFinished) {
      final successMessage = _isEditing
          ? 'Pagamento atualizado com sucesso.'
          : 'Pagamento registrado com sucesso.';
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(successMessage)),
        );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeContainer(),
        ),
        (route) => false,
      );
      if (fromDebtorPage) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DebtorContainer(debtor: state.updatedDebtor),
          ),
        );
      }
    } else if (state is SetPaymentRecordInfoReviewError) {
      final errorMessage = _isEditing
          ? 'Um erro ocorreu ao atualizar o pagamento.'
          : 'Um erro ocorreu ao registrar o pagamento.';
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
    }
  }

  bool get _isEditing => paymentRecordToEdit != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: 'Confira as Informações',
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: BlocListener<SetPaymentRecordInfoReviewBloc, SetPaymentRecordInfoReviewState>(
        listener: _listen,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: SetPaymentRecordInfoReviewCard(
                  paymentRecordDraft: paymentRecordDraft,
                  recordDebtor: recordDebtor,
                  paymentRecordToEdit: paymentRecordToEdit,
                  fromDebtorPage: fromDebtorPage,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SetPaymentRecordInfoReviewFinishButton(
                isEditing: _isEditing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
