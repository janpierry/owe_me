import 'package:dartz/dartz.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_validation_failures.dart';

class RecordAmount {
  final Money value;

  const RecordAmount._(this.value);

  static Either<AmountValidationFailure, RecordAmount> create(Money value) {
    if (value <= Money.zero) {
      return const Left(AmountZeroOrLessFailure());
    }
    if (value > Money.max) {
      return const Left(AmountExceedsLimitFailure());
    }

    return Right(RecordAmount._(value));
  }
}
