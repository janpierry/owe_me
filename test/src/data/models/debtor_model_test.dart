import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/domain/entities/money.dart';

void main() {
  const debtorId = 1;
  const nickname = 'Nickname';
  const totalDebtInCents = 10000;
  const totalDebt = Money(cents: totalDebtInCents);

  const model = DebtorModel(
    id: debtorId,
    nickname: nickname,
    totalDebtInCents: totalDebtInCents,
  );

  group('Equatable props:', () {
    test('When two models have the same props, they should be equal', () {
      const second = DebtorModel(
        id: debtorId,
        nickname: nickname,
        totalDebtInCents: totalDebtInCents,
      );

      assert(model == second);
    });

    test('When two models have different [id], they should not be equal', () {
      const second = DebtorModel(
        id: 2,
        nickname: nickname,
        totalDebtInCents: totalDebtInCents,
      );

      assert(model != second);
    });
    test('When two models have different [nickname], they should not be equal', () {
      const second = DebtorModel(
        id: debtorId,
        nickname: 'Another Nickname',
        totalDebtInCents: totalDebtInCents,
      );

      assert(model != second);
    });
    test('When two models have different [totalDebtInCents], they should not be equal',
        () {
      const second = DebtorModel(
        id: debtorId,
        nickname: nickname,
        totalDebtInCents: 20000,
      );

      assert(model != second);
    });
  });

  group('fromMap tests', () {
    test('should return a valid DebtorModel from map', () {
      final map = {
        'id': debtorId,
        'nickname': nickname,
        'total_debt_in_cents': totalDebt.cents,
      };

      final result = DebtorModel.fromMap(map);
      expect(result, equals(model));
    });
  });

  group('toMap tests', () {
    test('should return a valid map from DebtorModel', () {
      final expectedMap = {
        'id': debtorId,
        'nickname': nickname,
        'total_debt_in_cents': totalDebt.cents,
      };

      final result = model.toMap();
      expect(result, equals(expectedMap));
    });
  });
}
