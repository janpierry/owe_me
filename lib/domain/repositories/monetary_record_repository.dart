import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';

abstract class MonetaryRecordRepository {
  Future<Either<Failure, void>> addMonetaryRecordAndUpdateDebtorTotalDebt(
    MonetaryRecord monetaryRecord,
    Debtor recordDebtor,
  );
  Future<Either<Failure, List<MonetaryRecord>>> loadDebtorMonetaryRecordHistory(
    Debtor debtor,
  );
}
