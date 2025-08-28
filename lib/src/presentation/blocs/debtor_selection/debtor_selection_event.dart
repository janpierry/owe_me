part of 'debtor_selection_bloc.dart';

sealed class DebtorSelectionEvent extends Equatable {
  const DebtorSelectionEvent();

  @override
  List<Object> get props => [];
}

//TODO remove 'event' suffix?
class DebtorSelectionLoadDebtorsRequestedEvent extends DebtorSelectionEvent {}
