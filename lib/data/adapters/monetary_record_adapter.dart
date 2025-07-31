import 'package:owe_me/data/adapters/owe_record_adapter.dart';
import 'package:owe_me/data/adapters/payment_record_adapter.dart';
import 'package:owe_me/data/models/monetary_record_model.dart';
import 'package:owe_me/data/models/owe_record_model.dart';
import 'package:owe_me/data/models/payment_record_model.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/entities/owe_record.dart';
import 'package:owe_me/domain/entities/payment_record.dart';

class MonetaryRecordAdapter {
  const MonetaryRecordAdapter._();

  static MonetaryRecordModel toModel({
    required MonetaryRecord entity,
    required int debtorId,
  }) {
    if (entity is OweRecord) {
      return OweRecordAdapter.toModel(entity: entity, debtorId: debtorId);
    } else if (entity is PaymentRecord) {
      return PaymentRecordAdapter.toModel(entity: entity, debtorId: debtorId);
    } else {
      throw ArgumentError('Unsupported MonetaryRecord type: ${entity.runtimeType}');
    }
  }

  static MonetaryRecord toEntity(MonetaryRecordModel model) {
    if (model is OweRecordModel) {
      return OweRecordAdapter.toEntity(model);
    } else if (model is PaymentRecordModel) {
      return PaymentRecordAdapter.modelToEntity(model);
    } else {
      throw ArgumentError('Unsupported MonetaryRecordModel type: ${model.runtimeType}');
    }
  }
}
