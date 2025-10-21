import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';

class AddMonetaryRecordAndUpdateDebtor {
  final MonetaryRecordRepository _repository;

  AddMonetaryRecordAndUpdateDebtor({
    required MonetaryRecordRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Debtor>> call({
    required MonetaryRecord monetaryRecord,
    required Debtor recordDebtor,
  }) async {
    final debtorWithUpdatedDebt = recordDebtor.withMonetaryRecordAdded(monetaryRecord);

    final result = await _repository.addMonetaryRecordAndUpdateDebtor(
      monetaryRecord,
      debtorWithUpdatedDebt,
    );

    return result.fold(
      (failure) => Left(failure),
      (_) => Right(debtorWithUpdatedDebt),
    );
  }
}
