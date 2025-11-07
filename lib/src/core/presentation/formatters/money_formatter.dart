import 'package:intl/intl.dart';
import 'package:owe_me/src/domain/entities/money.dart';

class MoneyFormatter {
  MoneyFormatter._();

  static String toStringCurrency(Money money) {
    final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(money.inReal);
  }

  static String toStringCurrencyNullable(Money? money) {
    if (money == null) {
      return toStringCurrency(Money.zero);
    }
    return toStringCurrency(money);
  }
}
