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
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/amount_step_page/set_owe_record_amount_step_body.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';

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
    if (state.status == FormStatus.success) {
      _navigateToNextPage(context, state);
    } else if (state.status == FormStatus.error) {
      _showErrorSnackBar(context);
    }
  }

  void _navigateToNextPage(
    BuildContext context,
    SetOweRecordAmountStepState state,
  ) {
    final isReviewing = oweRecordDraftToReview != null;
    if (isReviewing) {
      _finishInfoReview(context, state.amount.value);
    } else {
      _navigateToDescriptionStep(context, state.amount.value);
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

  void _showErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Confira as informações.'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: 'Informe o Valor',
      ),
      body: BlocListener<SetOweRecordAmountStepBloc, SetOweRecordAmountStepState>(
        listener: _listen,
        child: SetOweRecordAmountStepBody(
          recordDebtor: recordDebtor,
          oweRecordType: oweRecordType,
          isReviewing: oweRecordDraftToReview != null,
        ),
      ),
    );
  }
}
