part of 'debtor_bloc.dart';

sealed class DebtorEvent extends Equatable {
  const DebtorEvent();

  @override
  List<Object?> get props => [];
}

class DebtorPageInitialized extends DebtorEvent {
  final Debtor debtor;

  const DebtorPageInitialized({required this.debtor});

  @override
  List<Object?> get props => [debtor];
}

class DebtorMonetaryRecordHistoryLoadRequested extends DebtorEvent {}

class DebtorEditRequested extends DebtorEvent {
  final String nickname;

  const DebtorEditRequested({required this.nickname});

  @override
  List<Object?> get props => [nickname];
}

class DebtorRemoveRequested extends DebtorEvent {}

class DebtorRemoveMonetaryRecordRequested extends DebtorEvent {
  final MonetaryRecord monetaryRecord;

  const DebtorRemoveMonetaryRecordRequested({required this.monetaryRecord});

  @override
  List<Object?> get props => [monetaryRecord];
}
