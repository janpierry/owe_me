import 'package:owe_me/data/models/debtor_model.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/money.dart';

class DebtorAdapter {
  const DebtorAdapter._();

  static DebtorModel toModel(Debtor entity) {
    return DebtorModel(
      id: entity.id,
      name: entity.name,
      totalDebtInCents: entity.totalDebt.cents,
    );
  }

  static Debtor toEntity(DebtorModel model) {
    return Debtor(
      id: model.id,
      name: model.name,
      totalDebt: Money(cents: model.totalDebtInCents),
    );
  }
}
