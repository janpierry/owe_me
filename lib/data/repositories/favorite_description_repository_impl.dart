import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/data/data_sources/favorite_description_data_source.dart';
import 'package:owe_me/data/adapters/favorite_description_adapter.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/favorite_description.dart';
import 'package:owe_me/domain/repositories/favorite_description_repository.dart';

class FavoriteDescriptionRepositoryImpl implements FavoriteDescriptionRepository {
  final FavoriteDescriptionDataSource _favoriteDescriptionDataSource;

  FavoriteDescriptionRepositoryImpl({
    required FavoriteDescriptionDataSource favoriteDescriptionDataSource,
  }) : _favoriteDescriptionDataSource = favoriteDescriptionDataSource;

  @override
  Future<Either<Failure, void>> addFavoriteDescription(
    FavoriteDescription favoriteDescription,
    Debtor debtor,
  ) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      final favoriteDescriptionModel = FavoriteDescriptionAdapter.toModel(
        entity: favoriteDescription,
        debtorId: debtorId,
      );
      await _favoriteDescriptionDataSource.insertFavoriteDescription(
        favoriteDescriptionModel,
      );
      return const Right(null);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteDescription>>> loadDebtorFavoriteDebts(
    Debtor debtor,
  ) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      final favoriteDescriptionModels =
          await _favoriteDescriptionDataSource.queryFavoriteDebtsByDebtorId(debtorId);

      final favoriteDescriptions =
          favoriteDescriptionModels.map((favoriteDescriptionModel) {
        return FavoriteDescriptionAdapter.toEntity(favoriteDescriptionModel);
      }).toList();

      return Right(favoriteDescriptions);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteDescription>>> loadDebtorFavoriteCredits(
    Debtor debtor,
  ) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      final favoriteDescriptionModels =
          await _favoriteDescriptionDataSource.queryFavoriteCreditsByDebtorId(debtorId);

      final favoriteDescriptions =
          favoriteDescriptionModels.map((favoriteDescriptionModel) {
        return FavoriteDescriptionAdapter.toEntity(favoriteDescriptionModel);
      }).toList();

      return Right(favoriteDescriptions);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }
}
