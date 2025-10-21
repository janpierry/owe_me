import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

class OweRecordAdapter {
  const OweRecordAdapter._();

  static OweRecordModel toModel({
    required OweRecord entity,
    required int debtorId,
  }) {
    return OweRecordModel(
      id: entity.id,
      debtorId: debtorId,
      amountInCents: entity.amount.cents,
      description: entity.description,
      date: entity.date.toIso8601String(),
      oweType: entity.oweType.name,
    );
  }

  static OweRecord toEntity(OweRecordModel model) {
    return OweRecord(
      id: model.id,
      amount: Money(cents: model.amountInCents),
      description: model.description,
      date: DateTime.parse(model.date),
      oweType: OweType.values.byName(model.oweType),
    );
  }
}
