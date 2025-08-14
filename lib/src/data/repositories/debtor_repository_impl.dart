import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/data/adapters/debtor_adapter.dart';
import 'package:owe_me/src/data/data_sources/debtor_data_source.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/repositories/debtor_repository.dart';

class DebtorRepositoryImpl implements DebtorRepository {
  final DebtorDataSource _debtorDataSource;

  DebtorRepositoryImpl({
    required DebtorDataSource debtorDataSource,
  }) : _debtorDataSource = debtorDataSource;

  @override
  Future<Either<Failure, List<Debtor>>> loadAllDebtors() async {
    try {
      final debtorModels = await _debtorDataSource.queryAllDebtors();

      final debtors = debtorModels.map((debtorModel) {
        return DebtorAdapter.toEntity(debtorModel);
      }).toList();

      return Right(debtors);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Debtor>> addDebtor(Debtor debtor) async {
    try {
      final debtorModel = DebtorAdapter.toModel(debtor);
      final savedDebtorId = await _debtorDataSource.insertDebtor(debtorModel);
      final savedDebtor = debtor.copyWith(id: savedDebtorId);
      return Right(savedDebtor);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editDebtor(Debtor debtor) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      final debtorModel = DebtorAdapter.toModel(debtor);
      await _debtorDataSource.updateDebtor(debtorModel);
      return Right(null);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeDebtor(Debtor debtor) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      await _debtorDataSource.deleteDebtor(debtorId);
      return Right(null);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }
}
