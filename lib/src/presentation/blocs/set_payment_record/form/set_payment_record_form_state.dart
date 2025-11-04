part of 'set_payment_record_form_bloc.dart';

class SetPaymentRecordFormState extends Equatable {
  final PaymentRecordDraft paymentRecordDraft;
  final String? amountErrorMessage;
  final bool isValid;
  final FormStatus status;

  const SetPaymentRecordFormState({
    required this.paymentRecordDraft,
    this.amountErrorMessage,
    this.isValid = false,
    this.status = FormStatus.initial,
  });

  factory SetPaymentRecordFormState.initial({
    required PaymentRecordDraft? paymentRecordDraftToReview,
    required PaymentRecord? paymentRecordToEdit,
  }) {
    return SetPaymentRecordFormState(
      paymentRecordDraft: paymentRecordDraftToReview ??
          PaymentRecordDraft(
            amount: paymentRecordToEdit?.amount ?? Money.zero,
            paymentMethod: paymentRecordToEdit?.paymentMethod ?? PaymentMethod.cash,
            date: paymentRecordToEdit?.date ?? DateTime.now(),
          ),
    );
  }

  SetPaymentRecordFormState copyWith({
    PaymentRecordDraft? paymentRecordDraft,
    bool eraseErrorMessage = false,
    String? amountErrorMessage,
    bool? isValid,
    FormStatus? status,
  }) {
    return SetPaymentRecordFormState(
      paymentRecordDraft: paymentRecordDraft ?? this.paymentRecordDraft,
      amountErrorMessage:
          eraseErrorMessage ? null : amountErrorMessage ?? this.amountErrorMessage,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        paymentRecordDraft,
        amountErrorMessage,
        isValid,
        status,
      ];
}
