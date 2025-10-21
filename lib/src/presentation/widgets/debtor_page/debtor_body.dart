import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_header.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_history_section.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_popup_menu_button.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_quick_action_section.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';

class DebtorBody extends StatelessWidget {
  final Debtor debtor;

  const DebtorBody({super.key, required this.debtor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: debtor.nickname,
        actions: [
          DebtorPopupMenuButton(debtor: debtor),
        ],
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Debtor Header
            DebtorHeader(debtor: debtor),
            const SizedBox(height: 16),
            //Debtor Quick Action Section
            DebtorQuickActionSection(debtor: debtor),
            const SizedBox(height: 24),
            //Debtor Records History Section
            const DebtorMonetaryRecordHistorySection()
          ],
        ),
      ),
    );
  }
}
