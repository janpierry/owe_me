import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/favorite_description.dart';

abstract class FavoriteDescriptionRepository {
  Future<Either<Failure, void>> addFavoriteDescription(
    FavoriteDescription favoriteDescription,
    Debtor debtor,
  );
  Future<Either<Failure, List<FavoriteDescription>>> loadDebtorFavoriteDebts(
    Debtor debtor,
  );
  Future<Either<Failure, List<FavoriteDescription>>> loadDebtorFavoriteCredits(
    Debtor debtor,
  );
}
