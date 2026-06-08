import 'package:owe_me/src/domain/validation/failures/description_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';

extension DescriptionFailureDisplay on DescriptionValidationFailure {
  String get uiMessage {
    switch (this) {
      case DescriptionExceedsLimitFailure():
        return 'A descrição não pode ter mais de '
            '${DescriptionRules.maxLength} caracteres.';
    }
  }
}
