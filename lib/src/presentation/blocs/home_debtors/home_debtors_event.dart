part of 'home_debtors_bloc.dart';

sealed class HomeDebtorsEvent extends Equatable {
  const HomeDebtorsEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadDebtorsRequestedEvent extends HomeDebtorsEvent {}

class HomeAddDebtorRequestedEvent extends HomeDebtorsEvent {
  final String debtorNickname;

  const HomeAddDebtorRequestedEvent({required this.debtorNickname});

  @override
  List<Object> get props => [debtorNickname];
}
