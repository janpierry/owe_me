import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';

extension FavoriteDescriptionFailureDisplay on FavoriteDescriptionFailure {
  String get uiMessage {
    switch (this) {
      case FavoriteDescriptionAlreadyInFavoritesFailure():
        return 'Esta descrição já está entre os favoritos.';
      case FavoriteDescriptionEmptyFailure():
        return 'A descrição não pode estar vazia para ser adicionada aos favoritos.';
    }
  }
}
