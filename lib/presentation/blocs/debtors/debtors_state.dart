part of 'debtors_bloc.dart';

sealed class DebtorsState extends Equatable {
  const DebtorsState();

  @override
  List<Object> get props => [];
}

final class DebtorsInitial extends DebtorsState {}

final class DebtorsLoading extends DebtorsState {}

final class DebtorsLoaded extends DebtorsState {
  final List<Debtor> debtors;

  const DebtorsLoaded({required this.debtors});

  @override
  List<Object> get props => [debtors];
}

final class DebtorsEmpty extends DebtorsState {}

final class DebtorsError extends DebtorsState {}
