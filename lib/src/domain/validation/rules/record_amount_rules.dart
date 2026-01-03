import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_validation_failures.dart';

class RecordAmountRules {
  const RecordAmountRules._();

  static AmountValidationFailure? validate(Money amount) {
    if (amount <= Money.zero) {
      return const AmountZeroOrLessFailure();
    }
    if (amount > Money.max) {
      return const AmountExceedsLimitFailure();
    }

    return null;
  }
}
