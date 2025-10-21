import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';

class RemoveMonetaryRecordAndUpdateDebtor {
  final MonetaryRecordRepository _repository;

  RemoveMonetaryRecordAndUpdateDebtor({
    required MonetaryRecordRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Debtor>> call({
    required MonetaryRecord monetaryRecord,
    required Debtor recordDebtor,
  }) async {
    final debtorWithUpdatedDebt = recordDebtor.withMonetaryRecordRemoved(monetaryRecord);

    final result = await _repository.removeMonetaryRecordAndUpdateDebtor(
      monetaryRecord,
      debtorWithUpdatedDebt,
    );

    return result.fold(
      (failure) => Left(failure),
      (_) => Right(debtorWithUpdatedDebt),
    );
  }
}
