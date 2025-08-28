part of 'debtor_selection_bloc.dart';

sealed class DebtorSelectionState extends Equatable {
  const DebtorSelectionState();

  @override
  List<Object> get props => [];
}

final class DebtorSelectionLoadDebtorsInitial extends DebtorSelectionState {}

final class DebtorSelectionLoadDebtorsInProgress extends DebtorSelectionState {}

final class DebtorSelectionLoadDebtorsSuccess extends DebtorSelectionState {
  final List<Debtor> debtors;

  const DebtorSelectionLoadDebtorsSuccess({required this.debtors});

  @override
  List<Object> get props => [debtors];
}

final class DebtorSelectionLoadDebtorsError extends DebtorSelectionState {}
