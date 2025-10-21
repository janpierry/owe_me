import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/presentation/blocs/debtor_selection/debtor_selection_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_debtor_selection_page.dart';

class SetOweRecordDebtorSelectionContainer extends StatelessWidget {
  final OweType oweRecordType;
  final OweRecordDraft? oweRecordDraftToReview;
  final bool fromDebtorPage;

  const SetOweRecordDebtorSelectionContainer({
    super.key,
    required this.oweRecordType,
    this.oweRecordDraftToReview,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<DebtorSelectionBloc>()
        ..add(
          DebtorSelectionLoadDebtorsRequested(),
        ),
      child: SetOweRecordDebtorSelectionPage(
        oweRecordType: oweRecordType,
        oweRecordDraftToReview: oweRecordDraftToReview,
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
