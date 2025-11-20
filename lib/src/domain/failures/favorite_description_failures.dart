import 'package:owe_me/src/core/shared/error/failures.dart';

class FavoriteDescriptionAlreadyInFavoritesFailure extends Failure {
  const FavoriteDescriptionAlreadyInFavoritesFailure()
      : super('Favorite description is already in favorites.');
}
