import 'package:owe_me/domain/entities/money.dart';

class MoneyUtils {
  MoneyUtils._();

  static Money fromStringCurrency(String formattedAmount) {
    final onlyNumbers = formattedAmount.replaceAll(RegExp(r'[^0-9]'), '');
    final intAmount = int.tryParse(onlyNumbers);

    if (intAmount == null) return const Money(cents: 0);

    final hasCents = formattedAmount.contains(',');
    final amountInCents = hasCents ? intAmount : (intAmount * 100);
    return Money(cents: amountInCents);
  }
}
