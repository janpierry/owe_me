part of 'debtor_monetary_record_history_bloc.dart';

sealed class DebtorMonetaryRecordHistoryEvent extends Equatable {
  const DebtorMonetaryRecordHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadDebtorMonetaryRecordHistoryEvent extends DebtorMonetaryRecordHistoryEvent {
  final Debtor debtor;

  const LoadDebtorMonetaryRecordHistoryEvent({required this.debtor});

  @override
  List<Object?> get props => [debtor];
}

class EditDebtorRequestedEvent extends DebtorMonetaryRecordHistoryEvent {
  final Debtor debtor;

  const EditDebtorRequestedEvent({required this.debtor});

  @override
  List<Object?> get props => [debtor];
}

//TODO remove debtor attribute from this event and receive it from page after initialization
class RemoveDebtorRequestedEvent extends DebtorMonetaryRecordHistoryEvent {
  final Debtor debtor;

  const RemoveDebtorRequestedEvent({required this.debtor});

  @override
  List<Object?> get props => [debtor];
}
