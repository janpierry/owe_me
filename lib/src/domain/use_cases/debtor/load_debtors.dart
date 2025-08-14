import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/repositories/debtor_repository.dart';

class LoadDebtors {
  final DebtorRepository _repository;

  LoadDebtors({required DebtorRepository repository}) : _repository = repository;

  Future<Either<Failure, List<Debtor>>> call() async {
    return await _repository.loadAllDebtors();
  }
}
