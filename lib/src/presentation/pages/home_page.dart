import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/home_page/home_body.dart';
import 'package:owe_me/src/presentation/widgets/home_page/home_no_debtors_yet_placeholder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OweMe',
            style: AppTextStyles.headline1.copyWith(
              color: AppColors.primaryBlue,
            )),
        backgroundColor: AppColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: AppColors.backgroundLight,
      //TODO refresh page in case of debtor deleted
      body: BlocBuilder<DebtorsBloc, DebtorsState>(
        builder: (context, state) {
          if (state is DebtorsLoaded) {
            return HomeBody(debtors: state.debtors);
          }
          if (state is DebtorsEmpty) {
            return HomeNoDebtorsYetPlaceholder();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
