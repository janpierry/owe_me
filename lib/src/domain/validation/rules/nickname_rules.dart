import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';

class NicknameRules {
  const NicknameRules._();

  static const maxLength = 50;

  static NicknameValidationFailure? validate(String nickname) {
    if (nickname.trim().isEmpty) {
      return const NicknameEmptyFailure();
    }

    if (nickname.length > NicknameRules.maxLength) {
      return const NicknameExceedsLimitFailure();
    }

    return null;
  }
}
