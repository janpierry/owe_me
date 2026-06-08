import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

sealed class DescriptionValidationFailure extends ValidationFailure {
  const DescriptionValidationFailure(super.message);
}

class DescriptionExceedsLimitFailure extends DescriptionValidationFailure {
  const DescriptionExceedsLimitFailure()
      : super('Description exceeds the maximum allowed limit.');
}
