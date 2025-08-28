part of 'home_debtors_bloc.dart';

sealed class HomeDebtorsState extends Equatable {
  const HomeDebtorsState();

  @override
  List<Object> get props => [];
}

final class HomeDebtorsInitial extends HomeDebtorsState {}

final class HomeDebtorsLoading extends HomeDebtorsState {}

final class HomeDebtorsLoaded extends HomeDebtorsState {
  final List<Debtor> debtors;

  const HomeDebtorsLoaded({required this.debtors});

  @override
  List<Object> get props => [debtors];
}

final class HomeDebtorsError extends HomeDebtorsState {}
