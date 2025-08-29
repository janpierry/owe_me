part of 'home_debtors_bloc.dart';

sealed class HomeDebtorsEvent extends Equatable {
  const HomeDebtorsEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadDebtorsRequested extends HomeDebtorsEvent {}

class HomeAddDebtorRequested extends HomeDebtorsEvent {
  final String debtorNickname;

  const HomeAddDebtorRequested({required this.debtorNickname});

  @override
  List<Object> get props => [debtorNickname];
}
