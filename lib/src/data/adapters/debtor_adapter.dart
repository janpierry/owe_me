import 'package:owe_me/src/core/error/exceptions/mapping_exceptions.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';

class DebtorAdapter {
  const DebtorAdapter._();

  static DebtorModel toModel(Debtor entity) {
    return DebtorModel(
      id: entity.id,
      nickname: entity.nickname,
      totalDebtInCents: entity.totalDebt.cents,
    );
  }

  static Debtor toEntity(DebtorModel model) {
    return Debtor.create(
      id: model.id,
      nickname: model.nickname,
      totalDebt: Money(cents: model.totalDebtInCents),
    ).getOrElse(() {
      throw DataIntegrityException(
          'Invalid DebtorModel data of id ${model.id}');
    });
  }
}
