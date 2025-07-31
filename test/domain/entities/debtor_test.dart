import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/money.dart';

void main() {
  group('Equatable props:', () {
    const debtorId = 1;
    const name = 'Mãe';
    const totalDebt = Money(cents: 10000);

    const first = Debtor(
      id: debtorId,
      name: name,
      totalDebt: totalDebt,
    );

    test('When two entities have the same props, they should be equal', () {
      const second = Debtor(
        id: debtorId,
        name: name,
        totalDebt: totalDebt,
      );

      assert(first == second);
    });

    test('When two entities have different [id], they should not be equal', () {
      const second = Debtor(
        id: 2,
        name: name,
        totalDebt: totalDebt,
      );

      assert(first != second);
    });
    test('When two entities have different [name], they should not be equal', () {
      const second = Debtor(
        id: debtorId,
        name: 'Vó',
        totalDebt: totalDebt,
      );

      assert(first != second);
    });
    test('When two entities have different [totalDebt], they should not be equal', () {
      const second = Debtor(
        id: debtorId,
        name: name,
        totalDebt: Money(cents: 20000),
      );

      assert(first != second);
    });
  });
}
