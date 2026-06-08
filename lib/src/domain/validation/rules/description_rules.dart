import 'package:owe_me/src/domain/validation/failures/description_validation_failures.dart';

class DescriptionRules {
  const DescriptionRules._();

  static const maxLength = 100;

  static DescriptionValidationFailure? validate(String description) {
    if (description.length > DescriptionRules.maxLength) {
      return const DescriptionExceedsLimitFailure();
    }

    return null;
  }
}
