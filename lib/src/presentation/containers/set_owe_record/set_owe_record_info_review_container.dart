import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_info_review_page.dart';

class SetOweRecordInfoReviewContainer extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final OweRecord? oweRecordToEdit;
  final bool fromDebtorPage;

  const SetOweRecordInfoReviewContainer({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.oweRecordToEdit,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetOweRecordInfoReviewBloc>()
        ..add(
          SetOweRecordInfoReviewPageInitialized(
            oweRecordDraft: oweRecordDraft,
            recordDebtor: recordDebtor,
            oweRecordToEdit: oweRecordToEdit,
          ),
        ),
      child: SetOweRecordInfoReviewPage(
        oweRecordDraft: oweRecordDraft,
        recordDebtor: recordDebtor,
        oweRecordToEdit: oweRecordToEdit,
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
