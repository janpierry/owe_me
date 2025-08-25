part of 'debtor_bloc.dart';

sealed class DebtorState extends Equatable {
  const DebtorState();

  @override
  List<Object> get props => [];
}

abstract class DebtorPageState extends DebtorState {
  const DebtorPageState();
}

final class DebtorPageInitial extends DebtorPageState {
  const DebtorPageInitial();
}

final class DebtorPageLoading extends DebtorPageState {
  const DebtorPageLoading();
}

final class DebtorPageLoaded extends DebtorPageState {
  final Debtor debtor;

  const DebtorPageLoaded({required this.debtor});

  @override
  List<Object> get props => [debtor];
}

final class DebtorMonetaryRecordHistoryState extends DebtorState {
  const DebtorMonetaryRecordHistoryState();
}

final class DebtorMonetaryRecordHistoryInitial extends DebtorMonetaryRecordHistoryState {}

final class DebtorMonetaryRecordHistoryLoading extends DebtorMonetaryRecordHistoryState {}

final class DebtorMonetaryRecordHistoryLoaded extends DebtorMonetaryRecordHistoryState {
  final List<MonetaryRecord> monetaryRecordHistory;

  const DebtorMonetaryRecordHistoryLoaded({required this.monetaryRecordHistory});

  @override
  List<Object> get props => [monetaryRecordHistory];
}

final class DebtorMonetaryRecordHistoryEmpty extends DebtorMonetaryRecordHistoryState {}

final class DebtorMonetaryRecordHistoryError extends DebtorMonetaryRecordHistoryState {
  final String message;

  const DebtorMonetaryRecordHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

abstract class DebtorEditState extends DebtorState {
  const DebtorEditState();
}

final class DebtorEditInProgress extends DebtorEditState {}

final class DebtorEditSuccess extends DebtorEditState {}

final class DebtorEditError extends DebtorEditState {
  final String message;

  const DebtorEditError({required this.message});

  @override
  List<Object> get props => [message];
}

abstract class DebtorRemoveState extends DebtorState {
  const DebtorRemoveState();
}

final class DebtorRemoveInProgress extends DebtorRemoveState {}

final class DebtorRemoveSuccess extends DebtorRemoveState {}

final class DebtorRemoveError extends DebtorRemoveState {
  final String message;

  const DebtorRemoveError({required this.message});

  @override
  List<Object> get props => [message];
}
