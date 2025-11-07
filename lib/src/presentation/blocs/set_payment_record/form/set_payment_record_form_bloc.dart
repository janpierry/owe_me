import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/models/form_field_state.dart';
import 'package:owe_me/src/presentation/validation/services/validation_services.dart';

part 'set_payment_record_form_event.dart';
part 'set_payment_record_form_state.dart';

class SetPaymentRecordFormBloc
    extends Bloc<SetPaymentRecordFormEvent, SetPaymentRecordFormState> {
  final AmountValidationService _amountValidationService;

  SetPaymentRecordFormBloc({
    required AmountValidationService validationService,
    required PaymentRecordDraft? paymentRecordDraftToReview,
    required PaymentRecord? paymentRecordToEdit,
  })  : _amountValidationService = validationService,
        super(
          SetPaymentRecordFormState.initial(
            paymentRecordDraftToReview: paymentRecordDraftToReview,
            paymentRecordToEdit: paymentRecordToEdit,
            amountValidationService: validationService,
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
    final errorMessage = _validateAmount(amount);
    final isValid = errorMessage == null;

    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          value: amount,
          errorMessage: errorMessage,
          removeErrorMessage: isValid,
          showError: !isValid,
        ),
      ),
    );
  }

  String? _validateAmount(Money amount) {
    return _amountValidationService.validateAndMapFailureToErrorMessage(amount);
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
    final amountErrorMessage = _validateAmount(state.amount.value);
    final isAmountValid = amountErrorMessage == null;
    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          errorMessage: amountErrorMessage,
          removeErrorMessage: isAmountValid,
          showError: !isAmountValid,
        ),
        status: isAmountValid ? FormStatus.success : FormStatus.error,
      ),
    );
    emit(state.copyWith(status: FormStatus.initial));
  }
}
