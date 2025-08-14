import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/repositories/debtor_repository.dart';

class RemoveDebtor {
  final DebtorRepository _repository;

  RemoveDebtor({required DebtorRepository repository}) : _repository = repository;

  Future<Either<Failure, void>> call({required Debtor debtor}) async {
    return await _repository.removeDebtor(debtor);
  }
}
