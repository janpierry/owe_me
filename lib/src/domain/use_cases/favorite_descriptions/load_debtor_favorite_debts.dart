import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/repositories/favorite_description_repository.dart';

class LoadDebtorFavoriteDebts {
  final FavoriteDescriptionRepository _repository;

  LoadDebtorFavoriteDebts({required FavoriteDescriptionRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<FavoriteDescription>>> call(Debtor debtor) async {
    return await _repository.loadDebtorFavoriteDebts(debtor);
  }
}
