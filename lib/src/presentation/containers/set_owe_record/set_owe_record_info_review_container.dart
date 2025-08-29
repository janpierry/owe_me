import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_info_review_page.dart';

class SetOweRecordInfoReviewContainer extends StatelessWidget {
  final Debtor recordDebtor;
  final OweRecordDraft oweRecordDraft;

  const SetOweRecordInfoReviewContainer({
    super.key,
    required this.recordDebtor,
    required this.oweRecordDraft,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SetOweRecordInfoReviewBloc>()
        ..add(
          SetOweRecordInfoReviewPageInitialized(
            oweRecordDraft: oweRecordDraft,
            recordDebtor: recordDebtor,
          ),
        ),
      child: SetOweRecordInfoReviewPage(
        recordDebtor: recordDebtor,
        oweRecordDraft: oweRecordDraft,
      ),
    );
  }
}
