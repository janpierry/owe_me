import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/repositories/monetary_record_repository.dart';

class AddMonetaryRecord {
  final MonetaryRecordRepository _repository;

  AddMonetaryRecord({
    required MonetaryRecordRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, void>> call({
    required MonetaryRecord monetaryRecord,
    required Debtor recordDebtor,
  }) async {
    final debtorWithUpdatedDebt =
        recordDebtor.updateTotalDebtWithMonetaryRecord(monetaryRecord);

    return await _repository.addMonetaryRecordAndUpdateDebtorTotalDebt(
      monetaryRecord,
      debtorWithUpdatedDebt,
    );
  }
}
