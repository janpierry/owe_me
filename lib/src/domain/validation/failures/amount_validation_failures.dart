import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

sealed class AmountValidationFailure extends ValidationFailure {
  const AmountValidationFailure(super.message);
}

class AmountZeroOrLessFailure extends AmountValidationFailure {
  const AmountZeroOrLessFailure() : super('Amount must be greater than zero.');
}

class AmountExceedsLimitFailure extends AmountValidationFailure {
  const AmountExceedsLimitFailure() : super('Amount exceeds the maximum allowed limit.');
}
