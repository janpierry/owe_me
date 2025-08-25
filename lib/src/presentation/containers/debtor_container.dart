import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/presentation/pages/debtor_page.dart';

class DebtorContainer extends StatelessWidget {
  final Debtor debtor;

  const DebtorContainer({super.key, required this.debtor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.instance<DebtorBloc>()..add(DebtorPageInitializedEvent(debtor: debtor)),
      child: DebtorPage(),
    );
  }
}
