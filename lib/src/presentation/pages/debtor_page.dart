import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/presentation/containers/debtor_container.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_body.dart';

class DebtorPage extends StatelessWidget {
  final Debtor debtor;

  const DebtorPage({super.key, required this.debtor});

  void _listen(BuildContext context, DebtorState state) {
    if (state is DebtorRemoveSuccess) {
      _showDebtorRemovedSnackbar(context);
      _navigateToHomePage(context);
    } else if (state is DebtorEditSuccess) {
      _showDebtorEditedSnackbar(context);
    } else if (state is DebtorRemoveMonetaryRecordSuccess) {
      _refreshHomeAndDebtorPages(context, state.updatedDebtor);
      _showDebtorMonetaryRecordRemovedSnackbar(context);
    } else if (state is DebtorMonetaryRecordHistoryError) {
      _showErrorSnackbar(context, state.message);
    } else if (state is DebtorEditError) {
      _showErrorSnackbar(context, state.message);
    } else if (state is DebtorRemoveError) {
      _showErrorSnackbar(context, state.message);
    } else if (state is DebtorRemoveMonetaryRecordError) {
      _showErrorSnackbar(context, state.message);
    }
  }

  void _showDebtorRemovedSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Devedor removido com sucesso'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeContainer(),
      ),
      (route) => false,
    );
  }

  void _showDebtorEditedSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Devedor editado com sucesso'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _refreshHomeAndDebtorPages(BuildContext context, Debtor updatedDebtor) {
    _navigateToHomePage(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DebtorContainer(debtor: updatedDebtor),
      ),
    );
  }

  void _showDebtorMonetaryRecordRemovedSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Registro removido com sucesso'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      //TODO adapt this
      content: Text('Erro: $message'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtorBloc, DebtorState>(
      listener: _listen,
      buildWhen: (previous, current) => current is DebtorPageState,
      builder: (context, state) {
        if (state is DebtorPageLoaded) {
          return Stack(
            children: [
              DebtorBody(debtor: state.debtor),
              BlocBuilder<DebtorBloc, DebtorState>(
                buildWhen: (previous, current) =>
                    current is DebtorEditState || current is DebtorRemoveState,
                builder: (context, state) {
                  if (state is DebtorEditInProgress || state is DebtorRemoveInProgress) {
                    return PopScope(
                      canPop: false,
                      child: AbsorbPointer(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
