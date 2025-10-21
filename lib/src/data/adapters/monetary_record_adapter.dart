import 'package:owe_me/src/data/adapters/owe_record_adapter.dart';
import 'package:owe_me/src/data/adapters/payment_record_adapter.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';

class MonetaryRecordAdapter {
  const MonetaryRecordAdapter._();

  static MonetaryRecordModel toModel({
    required MonetaryRecord entity,
    required int debtorId,
  }) {
    switch (entity) {
      case OweRecord():
        return OweRecordAdapter.toModel(entity: entity, debtorId: debtorId);
      case PaymentRecord():
        return PaymentRecordAdapter.toModel(entity: entity, debtorId: debtorId);
    }
  }

  static MonetaryRecord toEntity(MonetaryRecordModel model) {
    switch (model) {
      case OweRecordModel():
        return OweRecordAdapter.toEntity(model);
      case PaymentRecordModel():
        return PaymentRecordAdapter.modelToEntity(model);
    }
  }
}
