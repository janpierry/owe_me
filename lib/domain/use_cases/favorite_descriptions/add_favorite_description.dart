import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/favorite_description.dart';
import 'package:owe_me/domain/repositories/favorite_description_repository.dart';

class AddFavoriteDescription {
  final FavoriteDescriptionRepository _repository;

  AddFavoriteDescription({required FavoriteDescriptionRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(AddFavoriteDescriptionParams params) async {
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
