import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/utils/money_utils.dart';

void main() {
  group('MoneyUtils.fromStringCurrency', () {
    test('parses simple integer value', () {
      final money = MoneyUtils.fromStringCurrency('R\$ 12,00');
      expect(money.cents, 1200);
    });

    test('parses value with thousands separator', () {
      final money = MoneyUtils.fromStringCurrency('R\$ 1.234,56');
      expect(money.cents, 123456);
    });

    test('parses value without currency symbol', () {
      final money = MoneyUtils.fromStringCurrency('567,89');
      expect(money.cents, 56789);
    });

    test('parses value with dots only', () {
      final money = MoneyUtils.fromStringCurrency('1.000');
      expect(money.cents, 100000);
    });

    test('parses value with mixed formatting and spaces', () {
      final money = MoneyUtils.fromStringCurrency('  R\$ 9.876,54  ');
      expect(money.cents, 987654);
    });

    test('returns 0 on empty string', () {
      final money = MoneyUtils.fromStringCurrency('');
      expect(money.cents, 0);
    });

    test('returns 0 on non-numeric input', () {
      final money = MoneyUtils.fromStringCurrency('abc');
      expect(money.cents, 0);
    });

    test('parses value with no decimal separator (assumes cents)', () {
      final money = MoneyUtils.fromStringCurrency('R\$ 50');
      expect(money.cents, 5000);
    });
  });
}
