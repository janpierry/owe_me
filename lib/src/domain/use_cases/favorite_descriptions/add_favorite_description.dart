import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/repositories/favorite_description_repository.dart';

class AddFavoriteDescription {
  final FavoriteDescriptionRepository _repository;

  AddFavoriteDescription({
    required FavoriteDescriptionRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, void>> call(AddFavoriteDescriptionParams params) async {
    final result = await _repository.isDescriptionInFavorites(
      params.favoriteDescription,
      params.debtor,
    );
    if (result.isLeft()) {
      return result;
    }
    final isDescriptionInFavorites = result.asRight();
    if (isDescriptionInFavorites) {
      return Left(FavoriteDescriptionAlreadyInFavoritesFailure());
    }

    return await _repository.addFavoriteDescription(
      params.favoriteDescription,
      params.debtor,
    );
  }
}

class AddFavoriteDescriptionParams {
  final Debtor debtor;
  final FavoriteDescription favoriteDescription;

  AddFavoriteDescriptionParams({
    required this.debtor,
    required this.favoriteDescription,
  });
}
