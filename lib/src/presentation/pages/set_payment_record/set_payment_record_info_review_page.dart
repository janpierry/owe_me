import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/containers/debtor_container.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/info_review/set_payment_record_info_review_card.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/info_review/set_payment_record_info_review_finish_button.dart';

class SetPaymentRecordInfoReviewPage extends StatelessWidget {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetPaymentRecordInfoReviewPage({
    super.key,
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  void _listen(
    BuildContext context,
    SetPaymentRecordInfoReviewState state,
  ) {
    if (state is SetPaymentRecordInfoReviewRecordSetFinished) {
      //TODO should go back to debtor page instead of home in some cases
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Pagamento registrado com sucesso.')),
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
            builder: (context) => DebtorContainer(debtor: recordDebtor),
          ),
        );
      }
    } else if (state is SetPaymentRecordInfoReviewError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Um erro ocorreu ao registrar o pagamento.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confira as Informações', style: AppTextStyles.headline1),
        backgroundColor: AppColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: AppColors.backgroundLight,
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
                  fromDebtorPage: fromDebtorPage,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: SetPaymentRecordInfoReviewFinishButton(),
            ),
          ],
        ),
      ),
    );
  }
}
