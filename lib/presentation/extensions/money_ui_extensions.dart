import 'package:owe_me/domain/entities/money.dart';

extension NullableMoneyUiExtension on Money? {
  String toFormattedString() {
    if (this == null) {
      return Money.zero().toString();
    }
    return this!.toString();
  }
}
