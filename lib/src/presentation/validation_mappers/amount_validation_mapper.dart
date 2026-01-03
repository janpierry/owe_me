import 'package:owe_me/src/domain/validation/failures/amount_validation_failures.dart';

extension AmountFailureDisplay on AmountValidationFailure {
  String get uiMessage {
    switch (this) {
      case AmountZeroOrLessFailure():
        return 'Valor deve ser maior que zero.';
      case AmountExceedsLimitFailure():
        return 'Valor excede o limite máximo.';
    }
  }
}
