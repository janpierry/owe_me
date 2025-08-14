import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/data/adapters/monetary_record_adapter.dart';
import 'package:owe_me/src/data/data_sources/monetary_record_data_source.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';

class MonetaryRecordRepositoryImpl implements MonetaryRecordRepository {
  final MonetaryRecordDataSource _monetaryRecordDataSource;

  const MonetaryRecordRepositoryImpl({
    required MonetaryRecordDataSource monetaryRecordDataSource,
  }) : _monetaryRecordDataSource = monetaryRecordDataSource;

  @override
  Future<Either<Failure, void>> addMonetaryRecordAndUpdateDebtorTotalDebt(
    MonetaryRecord monetaryRecord,
    Debtor recordDebtor,
  ) async {
    try {
      final debtorId = recordDebtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }
      final monetaryRecordModel = MonetaryRecordAdapter.toModel(
        entity: monetaryRecord,
        debtorId: debtorId,
      );
      await _monetaryRecordDataSource.insertMonetaryRecordAndUpdateDebtorTotalDebt(
        monetaryRecordModel,
        recordDebtor.totalDebt.cents,
      );
      return const Right(null);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MonetaryRecord>>> loadDebtorMonetaryRecordHistory(
    Debtor debtor,
  ) async {
    try {
      final debtorId = debtor.id;
      if (debtorId == null) {
        return const Left(DebtorIdNotFoundFailure('Debtor ID cannot be null'));
      }

      final monetaryRecordModels =
          await _monetaryRecordDataSource.queryMonetaryRecordsByDebtorId(debtorId);

      final monetaryRecords = monetaryRecordModels.map((monetaryRecordModel) {
        return MonetaryRecordAdapter.toEntity(monetaryRecordModel);
      }).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      return Right(monetaryRecords);
    } on Exception catch (e) {
      //TODO: handle specific Failures
      return Left(DefaultFailure(e.toString()));
    }
  }
}
