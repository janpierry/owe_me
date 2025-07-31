import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/presentation/blocs/debtors/debtors_bloc.dart';
import 'package:owe_me/presentation/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<DebtorsBloc>()..add(LoadDebtorsRequestedEvent()),
      child: const HomePage(),
    );
  }
}
