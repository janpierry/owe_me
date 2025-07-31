import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/repositories/monetary_record_repository.dart';

class LoadDebtorMonetaryRecordHistory {
  final MonetaryRecordRepository _repository;

  LoadDebtorMonetaryRecordHistory({required MonetaryRecordRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<MonetaryRecord>>> call(Debtor debtor) async {
    return await _repository.loadDebtorMonetaryRecordHistory(debtor);
  }
}
