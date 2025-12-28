import 'package:dartz/dartz.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/record_amount_rules.dart';

class RecordAmount {
  final Money value;

  const RecordAmount._(this.value);

  static Either<AmountValidationFailure, RecordAmount> create(Money value) {
    final failure = RecordAmountRules.validate(value);
    if (failure != null) {
      return Left(failure);
    }

    return Right(RecordAmount._(value));
  }
}
