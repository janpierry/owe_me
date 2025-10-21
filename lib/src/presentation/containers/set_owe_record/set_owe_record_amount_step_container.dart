import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_amount_step_page.dart';

class SetOweRecordAmountStepContainer extends StatelessWidget {
  final Debtor recordDebtor;
  final OweType oweRecordType;
  final OweRecord? oweRecordToEdit;
  final OweRecordDraft? oweRecordDraftToReview;
  final bool fromDebtorPage;

  const SetOweRecordAmountStepContainer({
    super.key,
    required this.recordDebtor,
    required this.oweRecordType,
    this.oweRecordToEdit,
    this.oweRecordDraftToReview,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetOweRecordAmountStepBloc>()
        ..add(
          SetOweRecordAmountStepPageInitialized(
            amountToEdit: oweRecordDraftToReview?.amount ?? oweRecordToEdit?.amount,
          ),
        ),
      child: SetOweRecordAmountStepPage(
        recordDebtor: recordDebtor,
        oweRecordType: oweRecordType,
        oweRecordToEdit: oweRecordToEdit,
        oweRecordDraftToReview: oweRecordDraftToReview,
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
