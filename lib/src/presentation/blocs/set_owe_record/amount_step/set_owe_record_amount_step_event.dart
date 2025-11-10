part of 'set_owe_record_amount_step_bloc.dart';

sealed class SetOweRecordAmountStepEvent extends Equatable {
  const SetOweRecordAmountStepEvent();

  @override
  List<Object?> get props => [];
}

class SetOweRecordAmountStepAmountChanged extends SetOweRecordAmountStepEvent {
  final Money amount;

  const SetOweRecordAmountStepAmountChanged({required this.amount});

  @override
  List<Object> get props => [amount];
}

class SetOweRecordAmountStepNextPageRequested extends SetOweRecordAmountStepEvent {}
