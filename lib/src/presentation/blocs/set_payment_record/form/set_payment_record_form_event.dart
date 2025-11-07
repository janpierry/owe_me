part of 'set_payment_record_form_bloc.dart';

sealed class SetPaymentRecordFormEvent extends Equatable {
  const SetPaymentRecordFormEvent();

  @override
  List<Object?> get props => [];
}

final class SetPaymentRecordFormAmountChanged extends SetPaymentRecordFormEvent {
  final Money amount;

  const SetPaymentRecordFormAmountChanged({
    required this.amount,
  });

  @override
  List<Object?> get props => [amount];
}

final class SetPaymentRecordFormPaymentMethodChanged extends SetPaymentRecordFormEvent {
  final PaymentMethod? paymentMethod;

  const SetPaymentRecordFormPaymentMethodChanged({
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [paymentMethod];
}

final class SetPaymentRecordFormDateChanged extends SetPaymentRecordFormEvent {
  final DateTime date;

  const SetPaymentRecordFormDateChanged({required this.date});

  @override
  List<Object?> get props => [date];
}

final class SetPaymentRecordFormNextPageRequested extends SetPaymentRecordFormEvent {}
