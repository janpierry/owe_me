part of 'debtor_bloc.dart';

sealed class DebtorEvent extends Equatable {
  const DebtorEvent();

  @override
  List<Object?> get props => [];
}

class DebtorPageInitializedEvent extends DebtorEvent {
  final Debtor debtor;

  const DebtorPageInitializedEvent({required this.debtor});

  @override
  List<Object?> get props => [debtor];
}

class DebtorMonetaryRecordHistoryLoadRequestedEvent extends DebtorEvent {}

class DebtorEditRequestedEvent extends DebtorEvent {
  final String nickname;

  const DebtorEditRequestedEvent({required this.nickname});

  @override
  List<Object?> get props => [nickname];
}

class DebtorRemoveRequestedEvent extends DebtorEvent {}
