import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/extensions/string_extensions.dart';
import 'package:owe_me/src/presentation/containers/debtor_container.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/info_review_page/set_owe_record_info_review_card.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/info_review_page/set_owe_record_info_review_finish_button.dart';

class SetOweRecordInfoReviewPage extends StatelessWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetOweRecordInfoReviewPage({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  void _listen(
    BuildContext context,
    SetOweRecordInfoReviewState state,
  ) {
    if (state is SetOweRecordInfoReviewRecordSetFinished) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              '${oweRecordDraft.oweType.label.capitalize()} registrado com sucesso.',
            ),
          ),
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
    } else if (state is SetOweRecordInfoReviewError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Um erro ocorreu ao registrar o ${oweRecordDraft.oweType.label}.',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confira as Informações',
          style: AppTextStyles.headline1,
        ),
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
                  fromDebtorPage: fromDebtorPage,
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
