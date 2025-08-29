import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_amount_step_page.dart';

class SetOweRecordAmountStepContainer extends StatelessWidget {
  final Debtor recordDebtor;
  final OweType oweRecordType;
  final OweRecordDraft? oweRecordDraftToEdit;

  const SetOweRecordAmountStepContainer({
    super.key,
    required this.recordDebtor,
    required this.oweRecordType,
    this.oweRecordDraftToEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetOweRecordAmountStepBloc>()
        ..add(
          SetOweRecordAmountStepPageInitialized(
            amountToEdit: oweRecordDraftToEdit?.amount,
          ),
        ),
      child: SetOweRecordAmountStepPage(
        recordDebtor: recordDebtor,
        oweRecordType: oweRecordType,
        oweRecordDraftToEdit: oweRecordDraftToEdit,
      ),
    );
  }
}
