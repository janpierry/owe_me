part of 'debtor_monetary_record_history_bloc.dart';

sealed class DebtorMonetaryRecordHistoryState extends Equatable {
  const DebtorMonetaryRecordHistoryState();

  @override
  List<Object> get props => [];
}

final class DebtorMonetaryRecordHistoryInitial extends DebtorMonetaryRecordHistoryState {}

final class DebtorMonetaryRecordHistoryLoading extends DebtorMonetaryRecordHistoryState {}

final class DebtorMonetaryRecordHistoryLoaded extends DebtorMonetaryRecordHistoryState {
  final List<MonetaryRecord> monetaryRecordHistory;

  const DebtorMonetaryRecordHistoryLoaded({required this.monetaryRecordHistory});

  @override
  List<Object> get props => [monetaryRecordHistory];
}

final class DebtorMonetaryRecordHistoryError extends DebtorMonetaryRecordHistoryState {
  final String message;

  const DebtorMonetaryRecordHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

//TODO rename to follow state naming conventions
final class EditDebtorSuccess extends DebtorMonetaryRecordHistoryState {
  final Debtor updatedDebtor;

  const EditDebtorSuccess({required this.updatedDebtor});

  @override
  List<Object> get props => [updatedDebtor];
}

//TODO rename to follow state naming conventions
final class RemoveDebtorSuccess extends DebtorMonetaryRecordHistoryState {}
