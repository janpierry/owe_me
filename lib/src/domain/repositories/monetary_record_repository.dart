import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';

abstract class MonetaryRecordRepository {
  Future<Either<Failure, void>> addMonetaryRecordAndUpdateDebtor(
    MonetaryRecord monetaryRecord,
    Debtor recordDebtor,
  );
  Future<Either<Failure, void>> editMonetaryRecordAndUpdateDebtor(
    MonetaryRecord monetaryRecord,
    Debtor recordDebtor,
  );
  Future<Either<Failure, void>> removeMonetaryRecordAndUpdateDebtor(
    MonetaryRecord monetaryRecord,
    Debtor recordDebtor,
  );
  Future<Either<Failure, List<MonetaryRecord>>> loadDebtorMonetaryRecordHistory(
    Debtor debtor,
  );
}
