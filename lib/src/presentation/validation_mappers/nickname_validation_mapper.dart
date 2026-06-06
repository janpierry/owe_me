import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/nickname_rules.dart';

extension NicknameFailureDisplay on NicknameValidationFailure {
  String get uiMessage {
    switch (this) {
      case NicknameEmptyFailure():
        return 'Apelido é obrigatório.';
      case NicknameExceedsLimitFailure():
        return 'O apelido não pode ter mais de '
            '${NicknameRules.maxLength} caracteres.';
    }
  }
}
