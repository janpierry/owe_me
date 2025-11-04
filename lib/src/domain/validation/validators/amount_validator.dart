import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/validation/validators/validator.dart';
import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';

class AmountValidator implements Validator<Money, AmountValidationFailure> {
  const AmountValidator();

  @override
  AmountValidationFailure? validate(Money value) {
    if (value <= Money.zero) {
      return const AmountZeroOrLessFailure();
    }
    if (value > Money.max) {
      return const AmountExceedsLimitFailure();
    }
    return null;
  }
}
