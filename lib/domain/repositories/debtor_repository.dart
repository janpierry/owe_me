import 'package:dartz/dartz.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/domain/entities/debtor.dart';

abstract class DebtorRepository {
  Future<Either<Failure, List<Debtor>>> loadAllDebtors();
  Future<Either<Failure, Debtor>> addDebtor(Debtor debtor);
  Future<Either<Failure, void>> editDebtor(Debtor debtor);
  Future<Either<Failure, void>> removeDebtor(Debtor debtor);
}
