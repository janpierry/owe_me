import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

sealed class FavoriteDescriptionValidationFailure extends ValidationFailure {
  const FavoriteDescriptionValidationFailure(super.message);
}

class FavoriteDescriptionEmptyFailure extends FavoriteDescriptionValidationFailure {
  const FavoriteDescriptionEmptyFailure()
      : super('Favorite description cannot be empty.');
}
