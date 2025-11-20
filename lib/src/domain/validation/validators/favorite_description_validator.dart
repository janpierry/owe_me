import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/validation/failures/favorite_description_validation_failures.dart';
import 'package:owe_me/src/domain/validation/validators/validator.dart';

class FavoriteDescriptionValidator
    implements Validator<FavoriteDescription, FavoriteDescriptionValidationFailure> {
  const FavoriteDescriptionValidator();

  @override
  FavoriteDescriptionValidationFailure? validate(FavoriteDescription value) {
    if (value.description.trim().isEmpty) {
      return FavoriteDescriptionEmptyFailure();
    }
    return null;
  }
}
