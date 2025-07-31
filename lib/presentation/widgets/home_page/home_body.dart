import 'package:flutter/widgets.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/widgets/home_page/home_debtors_section.dart';
import 'package:owe_me/presentation/widgets/home_page/home_header.dart';
import 'package:owe_me/presentation/widgets/home_page/home_quick_action_buttons.dart';

class HomeBody extends StatelessWidget {
  final List<Debtor> debtors;

  const HomeBody({super.key, required this.debtors});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(debtors: debtors),
          const SizedBox(height: 16),
          const HomeQuickActionButtons(),
          const SizedBox(height: 24),
          HomeDebtorsSection(debtors: debtors),
        ],
      ),
    );
  }
}
