import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/repositories/debtor_repository.dart';

class AddDebtor {
  final DebtorRepository _repository;

  AddDebtor({required DebtorRepository repository}) : _repository = repository;

  Future<Either<Failure, Debtor>> call({required Debtor debtor}) async {
    return await _repository.addDebtor(debtor);
  }
}
