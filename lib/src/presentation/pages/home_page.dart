import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/presentation/widgets/home_page/home_body.dart';
import 'package:owe_me/src/presentation/widgets/home_page/home_no_debtors_yet_placeholder.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: 'OweMe',
        titleColor: OweMeColors.primaryBlue,
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: BlocBuilder<HomeDebtorsBloc, HomeDebtorsState>(
        builder: (context, state) {
          if (state is HomeDebtorsLoaded) {
            if (state.debtors.isEmpty) {
              return HomeNoDebtorsYetPlaceholder();
            }
            return HomeBody(debtors: state.debtors);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
