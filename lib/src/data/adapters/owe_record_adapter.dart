import 'package:owe_me/src/core/error/exceptions/mapping_exceptions.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

class OweRecordAdapter {
  const OweRecordAdapter._();

  static OweRecordModel toModel({
    required OweRecord entity,
    required int debtorId,
  }) {
    return OweRecordModel(
      id: entity.id,
      debtorId: debtorId,
      amountInCents: entity.amount.value.cents,
      description: entity.description,
      date: entity.date.toIso8601String(),
      oweType: entity.oweType.name,
    );
  }

  static OweRecord toEntity(OweRecordModel model) {
    final amount = RecordAmount.create(Money(cents: model.amountInCents)).getOrElse(() {
      throw DataIntegrityException(
          'Invalid amountInCents ${model.amountInCents} for OweRecordModel id ${model.id}');
    });

    return OweRecord.create(
      id: model.id,
      amount: amount,
      description: model.description,
      date: DateTime.parse(model.date),
      oweType: OweType.values.byName(model.oweType),
    ).getOrElse(() {
      throw DataIntegrityException(
          'Invalid description for OweRecordModel id ${model.id}');
    });
  }
}
