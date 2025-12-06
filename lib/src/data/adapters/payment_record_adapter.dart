import 'package:owe_me/src/core/error/exceptions/mapping_exceptions.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

class PaymentRecordAdapter {
  const PaymentRecordAdapter._();

  static PaymentRecordModel toModel({
    required PaymentRecord entity,
    required int debtorId,
  }) {
    return PaymentRecordModel(
      id: entity.id,
      debtorId: debtorId,
      amountInCents: entity.amount.value.cents,
      date: entity.date.toIso8601String(),
      paymentType: entity.paymentMethod.name,
    );
  }

  static PaymentRecord toEntity(PaymentRecordModel model) {
    final amount = RecordAmount.create(Money(cents: model.amountInCents)).getOrElse(() {
      throw DataIntegrityException(
          'Invalid amountInCents ${model.amountInCents} for PaymentRecordModel id ${model.id}');
    });

    return PaymentRecord(
      id: model.id,
      amount: amount,
      date: DateTime.parse(model.date),
      paymentMethod: PaymentMethod.values.byName(model.paymentType),
    );
  }
}
