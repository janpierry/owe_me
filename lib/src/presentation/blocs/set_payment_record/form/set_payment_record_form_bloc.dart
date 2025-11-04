import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/validation/services/amount_validation_service.dart';

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
    final amountErrorMessage =
        _amountValidationService.validateAndMapFailureToErrorMessage(event.amount);

    emit(
      state.copyWith(
        paymentRecordDraft: state.paymentRecordDraft.copyWith(amount: event.amount),
        eraseErrorMessage: amountErrorMessage == null,
        amountErrorMessage: amountErrorMessage,
        isValid: amountErrorMessage == null,
      ),
    );
  }

  FutureOr<void> _onPaymentMethodChanged(
    SetPaymentRecordFormPaymentMethodChanged event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(
      state.copyWith(
        paymentRecordDraft:
            state.paymentRecordDraft.copyWith(paymentMethod: event.paymentMethod),
      ),
    );
  }

  FutureOr<void> _onDateChanged(
    SetPaymentRecordFormDateChanged event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(
      state.copyWith(
        paymentRecordDraft: state.paymentRecordDraft.copyWith(date: event.date),
      ),
    );
  }

  FutureOr<void> _onNextPageRequested(
    SetPaymentRecordFormNextPageRequested event,
    Emitter<SetPaymentRecordFormState> emit,
  ) {
    emit(state.copyWith(status: FormStatus.loading));
    if (_areAllFieldsValid()) {
      emit(state.copyWith(status: FormStatus.success));
    } else {
      emit(state.copyWith(status: FormStatus.error));
    }
    emit(state.copyWith(status: FormStatus.initial));
  }

  bool _areAllFieldsValid() {
    final amount = state.paymentRecordDraft.amount;
    if (amount == null) return false;

    return _amountValidationService.validator.validate(amount) == null;
  }
}
