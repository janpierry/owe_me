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
    bool eraseAmount = false,
    DateTime? date,
    bool eraseDate = false,
    PaymentMethod? paymentMethod,
    bool erasePaymentMethod = false,
  }) {
    return PaymentRecordDraft(
      amount: eraseAmount ? null : amount ?? this.amount,
      date: eraseDate ? null : date ?? this.date,
      paymentMethod: erasePaymentMethod ? null : paymentMethod ?? this.paymentMethod,
    );
  }
}
