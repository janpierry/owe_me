import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/money.dart';

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
    return Debtor(
      id: model.id,
      nickname: model.nickname,
      totalDebt: Money(cents: model.totalDebtInCents),
    );
  }
}
