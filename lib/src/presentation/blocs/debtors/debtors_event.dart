part of 'debtors_bloc.dart';

sealed class DebtorsEvent extends Equatable {
  const DebtorsEvent();

  @override
  List<Object> get props => [];
}

class LoadDebtorsRequestedEvent extends DebtorsEvent {}

//TODO if it makes sense, should not be debtors bloc, but home bloc
class AddDebtorRequestedEvent extends DebtorsEvent {
  final String debtorNickname;

  const AddDebtorRequestedEvent({required this.debtorNickname});

  @override
  List<Object> get props => [debtorNickname];
}
