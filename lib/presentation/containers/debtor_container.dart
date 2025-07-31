import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/blocs/debtor_monetary_record_history/debtor_monetary_record_history_bloc.dart';
import 'package:owe_me/presentation/pages/debtor_page.dart';

class DebtorContainer extends StatelessWidget {
  final Debtor debtor;

  const DebtorContainer({super.key, required this.debtor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<DebtorMonetaryRecordHistoryBloc>()
        ..add(LoadDebtorMonetaryRecordHistoryEvent(debtor: debtor)),
      child: DebtorPage(debtor: debtor),
    );
  }
}
