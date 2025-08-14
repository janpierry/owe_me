import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/entities/money.dart';

void main() {
  group('Equatable props:', () {
    test('When two entities have the same props, they should be equal', () {
      const first = Money(cents: 111);
      const second = Money(cents: 111);

      assert(first == second);
    });

    test('When two entities have different [cents], they should not be equal', () {
      const first = Money(cents: 111);
      const second = Money(cents: 121);

      assert(first != second);
    });
  });

  group('inReal tests:', () {
    test(
      'Should return the correct value of money in Real currency',
      () {
        const value = Money(cents: 111);
        expect(value.inReal, 1.11);
      },
    );
    test(
      'Should return the correct value of money in Real currency when there is not more than 1 Real',
      () {
        const value = Money(cents: 11);
        expect(value.inReal, 0.11);
      },
    );
  });
}
