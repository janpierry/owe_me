import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';

class EditMonetaryRecordAndUpdateDebtor {
  final MonetaryRecordRepository _repository;

  EditMonetaryRecordAndUpdateDebtor({
    required MonetaryRecordRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Debtor>> call({
    required MonetaryRecord newMonetaryRecord,
    required MonetaryRecord oldMonetaryRecord,
    required Debtor recordDebtor,
  }) async {
    final debtorWithUpdatedDebt = recordDebtor.withMonetaryRecordEdited(
      newRecord: newMonetaryRecord,
      oldRecord: oldMonetaryRecord,
    );

    final result = await _repository.editMonetaryRecordAndUpdateDebtor(
      newMonetaryRecord,
      debtorWithUpdatedDebt,
    );

    return result.fold(
      (failure) => Left(failure),
      (_) => Right(debtorWithUpdatedDebt),
    );
  }
}
