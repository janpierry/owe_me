import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/presentation/containers/home_container.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';
import 'package:owe_me/presentation/widgets/set_owe_record/info_review_page/set_owe_record_info_review_card.dart';
import 'package:owe_me/presentation/widgets/set_owe_record/info_review_page/set_owe_record_info_review_finish_button.dart';

class SetOweRecordInfoReviewPage extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordInfoReviewPage({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  void _listen(
    BuildContext context,
    SetOweRecordInfoReviewState state,
  ) {
    if (state is SetOweRecordInfoReviewRecordSetFinished) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeContainer(),
        ),
        (route) => false,
      );
    } else if (state is SetOweRecordInfoReviewError) {
      // TODO Handle error state, e.g., show a snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while setting the record.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Info', style: AppTextStyles.headline1),
        backgroundColor: AppColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: AppColors.backgroundLight,
      body: BlocListener<SetOweRecordInfoReviewBloc, SetOweRecordInfoReviewState>(
        listener: _listen,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: SetOweRecordInfoReviewCard(
                  oweRecordDraft: oweRecordDraft,
                  recordDebtor: recordDebtor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: SetOweRecordInfoReviewFinishButton(),
            ),
          ],
        ),
      ),
    );
  }
}
