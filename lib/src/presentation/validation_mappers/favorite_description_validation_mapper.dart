import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';

extension FavoriteDescriptionFailureDisplay on FavoriteDescriptionFailure {
  String get uiMessage {
    switch (this) {
      case FavoriteDescriptionAlreadyInFavoritesFailure():
        return 'Esta descrição já está entre os favoritos.';
      case FavoriteDescriptionEmptyFailure():
        return 'A descrição não pode estar vazia para ser adicionada aos favoritos.';
      case FavoriteDescriptionTooLongFailure():
        return 'A descrição não pode ter mais de '
            '${DescriptionRules.maxLength} caracteres.';
    }
  }
}
