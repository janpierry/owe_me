part of 'monetary_record.dart';

class PaymentRecord extends MonetaryRecord {
  final PaymentMethod paymentMethod;

  const PaymentRecord({
    required super.id,
    required super.amount,
    required super.date,
    required this.paymentMethod,
  });

  @override
  Money applyAmountToTotalDebt(Money totalDebt) {
    return totalDebt - amount;
  }

  @override
  Money revertAmountFromTotalDebt(Money totalDebt) {
    return totalDebt + amount;
  }

  PaymentRecord copyWith({
    int? id,
    Money? amount,
    DateTime? date,
    PaymentMethod? paymentMethod,
  }) {
    return PaymentRecord(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => super.props + [paymentMethod];
}
