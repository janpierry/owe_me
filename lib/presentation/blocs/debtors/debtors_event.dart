part of 'debtors_bloc.dart';

sealed class DebtorsEvent extends Equatable {
  const DebtorsEvent();

  @override
  List<Object> get props => [];
}

class LoadDebtorsRequestedEvent extends DebtorsEvent {}

class AddDebtorRequestedEvent extends DebtorsEvent {
  final String debtorNickname;

  const AddDebtorRequestedEvent({required this.debtorNickname});

  @override
  List<Object> get props => [debtorNickname];
}
