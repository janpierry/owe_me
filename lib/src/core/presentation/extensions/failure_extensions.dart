import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/validation/failures/description_validation_failures.dart';
import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/presentation/validation_mappers/description_validation_mapper.dart';
import 'package:owe_me/src/presentation/validation_mappers/favorite_description_validation_mapper.dart';
import 'package:owe_me/src/presentation/validation_mappers/nickname_validation_mapper.dart';

extension UiFailureDisplay on Failure {
  /// User-facing (pt-BR) text for this failure. Wrapper failures such as
  /// `DebtorValidationFailure` are unwrapped through [Failure.cause] so the
  /// rule failure's mapper decides the text, not the English domain [message].
  String get uiMessage {
    final failure = this;
    if (failure is FavoriteDescriptionFailure) {
      return failure.uiMessage;
    }
    if (failure is NicknameValidationFailure) {
      return failure.uiMessage;
    }
    if (failure is DescriptionValidationFailure) {
      return failure.uiMessage;
    }
    final cause = failure.cause;
    if (cause != null) {
      return cause.uiMessage;
    }
    return message;
  }
}
