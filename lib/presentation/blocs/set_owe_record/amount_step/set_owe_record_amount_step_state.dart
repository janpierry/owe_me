part of 'set_owe_record_amount_step_bloc.dart';

sealed class SetOweRecordAmountStepState extends Equatable {
  const SetOweRecordAmountStepState();

  @override
  List<Object?> get props => [];
}

final class SetOweRecordAmountStepInitial extends SetOweRecordAmountStepState {}

final class SetOweRecordAmountStepLoading extends SetOweRecordAmountStepState {}

sealed class SetOweRecordAmountStepPageBuildState extends SetOweRecordAmountStepState {
  const SetOweRecordAmountStepPageBuildState();
}

final class SetOweRecordAmountStepPageLoading
    extends SetOweRecordAmountStepPageBuildState {}

final class SetOweRecordAmountStepPageLoaded
    extends SetOweRecordAmountStepPageBuildState {
  final Money? amountToEdit;

  const SetOweRecordAmountStepPageLoaded({required this.amountToEdit});

  @override
  List<Object?> get props => [amountToEdit];
}

class SetOweRecordAmountStepNavigatingToNextPage extends SetOweRecordAmountStepState {
  final Money amount;

  const SetOweRecordAmountStepNavigatingToNextPage({required this.amount});

  @override
  List<Object> get props => [amount];
}
