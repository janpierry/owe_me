import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/presentation/blocs/debtor_monetary_record_history/debtor_monetary_record_history_bloc.dart';
import 'package:owe_me/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_history_list.dart';

class DebtorMonetaryRecordHistoryBuilder extends StatelessWidget {
  const DebtorMonetaryRecordHistoryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtorMonetaryRecordHistoryBloc, DebtorMonetaryRecordHistoryState>(
      builder: (context, state) {
        if (state is DebtorMonetaryRecordHistoryLoaded) {
          return DebtorMonetaryRecordHistoryList(
            monetaryRecords: state.monetaryRecordHistory,
          );
        }
        if (state is DebtorMonetaryRecordHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DebtorMonetaryRecordHistoryError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
