import 'package:owe_me/data/models/payment_record_model.dart';
import 'package:owe_me/domain/entities/payment_record.dart';
import 'package:owe_me/domain/entities/money.dart';
import 'package:owe_me/domain/enums/payment_method.dart';

class PaymentRecordAdapter {
  const PaymentRecordAdapter._();

  static PaymentRecordModel toModel({
    required PaymentRecord entity,
    required int debtorId,
  }) {
    return PaymentRecordModel(
      id: entity.id,
      debtorId: debtorId,
      amountInCents: entity.amount.cents,
      date: entity.date.toIso8601String(),
      paymentType: entity.paymentMethod.name,
    );
  }

  static PaymentRecord modelToEntity(PaymentRecordModel model) {
    return PaymentRecord(
      id: model.id,
      amount: Money(cents: model.amountInCents),
      date: DateTime.parse(model.date),
      paymentMethod: PaymentMethod.values.byName(model.paymentType),
    );
  }
}
