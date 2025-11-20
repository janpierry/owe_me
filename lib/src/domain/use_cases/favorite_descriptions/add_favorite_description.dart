import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/repositories/favorite_description_repository.dart';
import 'package:owe_me/src/domain/validation/validators/favorite_description_validator.dart';

class AddFavoriteDescription {
  final FavoriteDescriptionRepository _repository;
  final FavoriteDescriptionValidator _validator;

  AddFavoriteDescription({
    required FavoriteDescriptionRepository repository,
    required FavoriteDescriptionValidator validator,
  })  : _repository = repository,
        _validator = validator;

  Future<Either<Failure, void>> call(AddFavoriteDescriptionParams params) async {
    final failure = _validator.validate(params.favoriteDescription);
    if (failure != null) return Left(failure);

    if (_isDescriptionInFavorites(
        params.favoriteDescription, params.currentFavoriteDescriptions)) {
      return Left(FavoriteDescriptionAlreadyInFavoritesFailure());
    }
    return await _repository.addFavoriteDescription(
      params.favoriteDescription,
      params.debtor,
    );
  }

  bool _isDescriptionInFavorites(
    FavoriteDescription favoriteDescription,
    List<FavoriteDescription> currentFavoriteDescriptions,
  ) {
    final description = favoriteDescription.description;
    for (var favoriteDescription in currentFavoriteDescriptions) {
      if (description.toLowerCase() == favoriteDescription.description.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}

class AddFavoriteDescriptionParams {
  final Debtor debtor;
  final FavoriteDescription favoriteDescription;
  final List<FavoriteDescription> currentFavoriteDescriptions;

  AddFavoriteDescriptionParams({
    required this.debtor,
    required this.favoriteDescription,
    required this.currentFavoriteDescriptions,
  });
}
