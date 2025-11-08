import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';
import 'package:owe_me/src/domain/validation/validators/amount_validator.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/models/validatable_field_state/validatable_field_states.dart';

part 'set_payment_record_form_event.dart';
part 'set_payment_record_form_state.dart';

class SetPaymentRecordFormBloc
    extends Bloc<SetPaymentRecordFormEvent, SetPaymentRecordFormState> {
  final AmountValidator _amountValidator;

  SetPaymentRecordFormBloc({
    required AmountValidator amountValidator,
    required PaymentRecordDraft? paymentRecordDraftToReview,
    required PaymentRecord? paymentRecordToEdit,
  })  : _amountValidator = amountValidator,
        super(
          SetPaymentRecordFormState.initial(
            paymentRecordDraftToReview: paymentRecordDraftToReview,
            paymentRecordToEdit: paymentRecordToEdit,
            amountValidator: amountValidator,
          ),
        ) {
    on<SetPaymentRecordFormAmountChanged>(_onAmountChanged);
    on<SetPaymentRecordFormPaymentMethodChanged>(_onPaymentMethodChanged);
    on<SetPaymentRecordFormDateChanged>(_onDateChanged);
    on<SetPaymentRecordFormNextPageRequested>(_onNextPageRequested);
  }

  FutureOr<void> _onAmountChanged(
    SetPaymentRecordFormAmountChanged event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    final amount = event.amount;
    final amountFailure = _validateAmount(amount);
    final isValid = amountFailure == null;

    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          value: amount,
          failure: amountFailure,
          removeFailure: isValid,
          showError: !isValid,
        ),
      ),
    );
  }

  AmountValidationFailure? _validateAmount(Money amount) {
    return _amountValidator.validate(amount);
  }

  FutureOr<void> _onPaymentMethodChanged(
    SetPaymentRecordFormPaymentMethodChanged event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(
      state.copyWith(paymentMethod: event.paymentMethod),
    );
  }

  FutureOr<void> _onDateChanged(
    SetPaymentRecordFormDateChanged event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(
      state.copyWith(date: event.date),
    );
  }

  FutureOr<void> _onNextPageRequested(
    SetPaymentRecordFormNextPageRequested event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(state.copyWith(status: FormStatus.loading));
    final amountFailure = _validateAmount(state.amount.value);
    final isAmountValid = amountFailure == null;
    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          failure: amountFailure,
          removeFailure: isAmountValid,
          showError: !isAmountValid,
        ),
        status: isAmountValid ? FormStatus.success : FormStatus.error,
      ),
    );
    emit(state.copyWith(status: FormStatus.initial));
  }
}
