import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/entities/money.dart';
import 'package:owe_me/domain/enums/payment_method.dart';

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
  List<Object?> get props => super.props + [paymentMethod];
}
