import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_description_step_page.dart';

class SetOweRecordDescriptionStepContainer extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetOweRecordDescriptionStepContainer({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetOweRecordDescriptionStepBloc>()
        ..add(
          SetOweRecordDescriptionStepPageInitialized(
            oweRecordDraft: oweRecordDraft,
            recordDebtor: recordDebtor,
          ),
        ),
      child: SetOweRecordDescriptionStepPage(
        fromDebtorPage: fromDebtorPage,
      ),
    );
  }
}
