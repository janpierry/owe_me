import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';

class PaymentRecordDraft {
  final Money? amount;
  final DateTime? date;
  final PaymentMethod? paymentMethod;

  PaymentRecordDraft({
    this.amount,
    this.date,
    this.paymentMethod,
  });

  PaymentRecordDraft copyWith({
    Money? amount,
    bool removeAmount = false,
    DateTime? date,
    bool removeDate = false,
    PaymentMethod? paymentMethod,
    bool removePaymentMethod = false,
  }) {
    return PaymentRecordDraft(
      amount: removeAmount ? null : (amount ?? this.amount),
      date: removeDate ? null : (date ?? this.date),
      paymentMethod: removePaymentMethod ? null : (paymentMethod ?? this.paymentMethod),
    );
  }
}
