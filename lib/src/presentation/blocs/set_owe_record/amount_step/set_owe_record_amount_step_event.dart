part of 'set_owe_record_amount_step_bloc.dart';

sealed class SetOweRecordAmountStepEvent extends Equatable {
  const SetOweRecordAmountStepEvent();

  @override
  List<Object?> get props => [];
}

class SetOweRecordAmountStepPageInitialized extends SetOweRecordAmountStepEvent {
  final Money? amountToEdit;

  const SetOweRecordAmountStepPageInitialized({
    required this.amountToEdit,
  });

  @override
  List<Object?> get props => [amountToEdit];
}

class SetOweRecordAmountStepAmountChanged extends SetOweRecordAmountStepEvent {
  final Money amount;

  const SetOweRecordAmountStepAmountChanged({required this.amount});

  @override
  List<Object> get props => [amount];
}

class SetOweRecordAmountStepNextPageRequested extends SetOweRecordAmountStepEvent {}
