import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/presentation/validation_mappers/favorite_description_validation_mapper.dart';

extension UiFailureDisplay on Failure {
  String get uiMessage {
    if (this is FavoriteDescriptionFailure) {
      return (this as FavoriteDescriptionFailure).uiMessage;
    }
    return message;
  }
}
