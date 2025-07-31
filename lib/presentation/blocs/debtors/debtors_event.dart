part of 'debtors_bloc.dart';

sealed class DebtorsEvent extends Equatable {
  const DebtorsEvent();

  @override
  List<Object> get props => [];
}

class LoadDebtorsRequestedEvent extends DebtorsEvent {}

class AddDebtorRequestedEvent extends DebtorsEvent {
  final String debtorName;

  const AddDebtorRequestedEvent({required this.debtorName});

  @override
  List<Object> get props => [debtorName];
}
