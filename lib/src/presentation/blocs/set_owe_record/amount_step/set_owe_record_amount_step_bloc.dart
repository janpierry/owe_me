import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/validation/rules/record_amount_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_validation_failures.dart';
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/models/validatable_field_state/validatable_field_states.dart';

part 'set_owe_record_amount_step_event.dart';
part 'set_owe_record_amount_step_state.dart';

class SetOweRecordAmountStepBloc
    extends Bloc<SetOweRecordAmountStepEvent, SetOweRecordAmountStepState> {
  SetOweRecordAmountStepBloc({
    required Money? amountToEdit,
  }) : super(
          SetOweRecordAmountStepState.initial(
            amountToEdit: amountToEdit,
          ),
        ) {
    on<SetOweRecordAmountStepAmountChanged>(_setAmount);
    on<SetOweRecordAmountStepNextPageRequested>(_sendAmountToNavigateToNextPage);
  }

  FutureOr<void> _setAmount(
    SetOweRecordAmountStepAmountChanged event,
    Emitter<SetOweRecordAmountStepState> emit,
  ) async {
    final amount = event.amount;
    final failure = _validateAmount(amount);
    final isValid = failure == null;

    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          value: amount,
          failure: failure,
          removeFailure: isValid,
          showError: !isValid,
        ),
      ),
    );
  }

  AmountValidationFailure? _validateAmount(Money amount) {
    return RecordAmountRules.validate(amount);
  }

  FutureOr<void> _sendAmountToNavigateToNextPage(
    SetOweRecordAmountStepNextPageRequested event,
    Emitter<SetOweRecordAmountStepState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.loading));
    final failure = _validateAmount(state.amount.value);
    final isValid = failure == null;
    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          failure: failure,
          removeFailure: isValid,
          showError: !isValid,
        ),
        status: isValid ? FormStatus.success : FormStatus.error,
      ),
    );
    emit(state.copyWith(status: FormStatus.initial));
  }
}
