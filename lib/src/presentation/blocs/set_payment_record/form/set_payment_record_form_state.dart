part of 'set_payment_record_form_bloc.dart';

class SetPaymentRecordFormState extends Equatable {
  final FormFieldState<Money> amount;
  final PaymentMethod paymentMethod;
  final DateTime date;
  final FormStatus status;

  const SetPaymentRecordFormState({
    required this.amount,
    required this.paymentMethod,
    required this.date,
    this.status = FormStatus.initial,
  });

  bool get isValid => amount.isValid;

  PaymentRecordDraft get paymentRecordDraft => PaymentRecordDraft(
        amount: amount.value,
        paymentMethod: paymentMethod,
        date: date,
      );

  factory SetPaymentRecordFormState.initial({
    required PaymentRecordDraft? paymentRecordDraftToReview,
    required PaymentRecord? paymentRecordToEdit,
    required AmountValidationService amountValidationService,
  }) {
    final amountToReview = paymentRecordDraftToReview?.amount;
    final amount = amountToReview ?? paymentRecordToEdit?.amount ?? Money.zero;
    final amountErrorMessage =
        amountValidationService.validateAndMapFailureToErrorMessage(amount);
    final amountFieldState = FormFieldState<Money>(
      value: amount,
      errorMessage: amountErrorMessage,
      showError: false,
    );

    final paymentMethodToReview = paymentRecordDraftToReview?.paymentMethod;
    final paymentMethod =
        paymentMethodToReview ?? paymentRecordToEdit?.paymentMethod ?? PaymentMethod.cash;

    final dateToReview = paymentRecordDraftToReview?.date;
    final date = dateToReview ?? paymentRecordToEdit?.date ?? DateTime.now();

    return SetPaymentRecordFormState(
      amount: amountFieldState,
      paymentMethod: paymentMethod,
      date: date,
    );
  }

  SetPaymentRecordFormState copyWith({
    FormFieldState<Money>? amount,
    PaymentMethod? paymentMethod,
    DateTime? date,
    FormStatus? status,
  }) {
    return SetPaymentRecordFormState(
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        paymentMethod,
        date,
        isValid,
        status,
      ];
}
