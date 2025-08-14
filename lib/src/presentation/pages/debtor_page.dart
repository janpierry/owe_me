import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor_monetary_record_history/debtor_monetary_record_history_bloc.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_body.dart';

class DebtorPage extends StatelessWidget {
  final Debtor debtor;

  const DebtorPage({super.key, required this.debtor});

  void _listen(BuildContext context, DebtorMonetaryRecordHistoryState state) {
    if (state is RemoveDebtorSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeContainer(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtorMonetaryRecordHistoryBloc,
        DebtorMonetaryRecordHistoryState>(
      listener: _listen,
      builder: (context, state) {
        //TODO set debtor of received from the bloc state in case of edition
        return DebtorBody(debtor: debtor);
      },
    );
  }
}
