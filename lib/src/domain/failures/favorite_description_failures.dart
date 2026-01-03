import 'package:owe_me/src/core/error/failures/failures.dart';

sealed class FavoriteDescriptionFailure extends Failure {
  const FavoriteDescriptionFailure(super.message);
}

class FavoriteDescriptionAlreadyInFavoritesFailure extends FavoriteDescriptionFailure {
  const FavoriteDescriptionAlreadyInFavoritesFailure()
      : super('Favorite description is already in favorites.');
}

class FavoriteDescriptionEmptyFailure extends FavoriteDescriptionFailure {
  const FavoriteDescriptionEmptyFailure()
      : super('Favorite description cannot be empty.');
}
