part of 'set_owe_record_amount_step_bloc.dart';

final class SetOweRecordAmountStepState extends Equatable {
  final ValidatableAmountState amount;
  final FormStatus status;

  const SetOweRecordAmountStepState({
    required this.amount,
    this.status = FormStatus.initial,
  });

  bool get isValid => amount.isValid;

  factory SetOweRecordAmountStepState.initial({
    required Money? amountToEdit,
  }) {
    final initialAmount = amountToEdit ?? Money.zero;
    final result = RecordAmount.create(initialAmount);
    final failure = result.isLeft() ? result.asLeft() : null;
    return SetOweRecordAmountStepState(
      amount: ValidatableAmountState(
        value: initialAmount,
        failure: failure,
        showError: false,
      ),
    );
  }

  SetOweRecordAmountStepState copyWith({
    ValidatableAmountState? amount,
    FormStatus? status,
  }) {
    return SetOweRecordAmountStepState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [amount, status];
}
