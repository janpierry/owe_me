part of 'set_owe_record_amount_step_bloc.dart';

sealed class SetOweRecordAmountStepEvent extends Equatable {
  const SetOweRecordAmountStepEvent();

  @override
  List<Object?> get props => [];
}

class SetOweRecordAmountStepPageInitializedEvent extends SetOweRecordAmountStepEvent {
  final Money? amountToEdit;

  const SetOweRecordAmountStepPageInitializedEvent({
    required this.amountToEdit,
  });

  @override
  List<Object?> get props => [amountToEdit];
}

class SetOweRecordAmountStepAmountChangedEvent extends SetOweRecordAmountStepEvent {
  final Money amount;

  const SetOweRecordAmountStepAmountChangedEvent({required this.amount});

  @override
  List<Object> get props => [amount];
}

class SetOweRecordAmountStepNextPageRequestedEvent extends SetOweRecordAmountStepEvent {}
