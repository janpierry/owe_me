import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';

class FavoriteDescriptionRules {
  const FavoriteDescriptionRules._();

  static FavoriteDescriptionFailure? validate(String description) {
    if (description.trim().isEmpty) {
      return const FavoriteDescriptionEmptyFailure();
    }

    if (description.length > DescriptionRules.maxLength) {
      return const FavoriteDescriptionTooLongFailure();
    }

    return null;
  }
}
