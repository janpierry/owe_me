import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

sealed class NicknameValidationFailure extends ValidationFailure {
  const NicknameValidationFailure(super.message);
}

class NicknameEmptyFailure extends NicknameValidationFailure {
  const NicknameEmptyFailure() : super('Nickname cannot be empty.');
}

class NicknameExceedsLimitFailure extends NicknameValidationFailure {
  const NicknameExceedsLimitFailure()
      : super('Nickname exceeds the maximum allowed limit.');
}
