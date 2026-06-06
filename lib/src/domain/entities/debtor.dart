import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/nickname_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';

class Debtor extends Equatable {
  final int? id; // Null ID for new records
  final String nickname;
  final Money totalDebt;

  const Debtor._({
    this.id,
    required this.nickname,
    this.totalDebt = const Money(cents: 0),
  });

  static Either<NicknameValidationFailure, Debtor> create({
    int? id,
    required String nickname,
    Money totalDebt = const Money(cents: 0),
  }) {
    final failure = NicknameRules.validate(nickname);
    if (failure != null) {
      return Left(failure);
    }
    return Right(
      Debtor._(
        id: id,
        nickname: nickname,
        totalDebt: totalDebt,
      ),
    );
  }

  Debtor withMonetaryRecordAdded(MonetaryRecord record) {
    return copyWith(
      totalDebt: record.applyAmountToTotalDebt(totalDebt),
    );
  }

  Debtor withMonetaryRecordRemoved(MonetaryRecord removedRecord) {
    return copyWith(
      totalDebt: removedRecord.revertAmountFromTotalDebt(totalDebt),
    );
  }

  Debtor withMonetaryRecordEdited({
    required MonetaryRecord newRecord,
    required MonetaryRecord oldRecord,
  }) {
    final intermediateDebt = oldRecord.revertAmountFromTotalDebt(totalDebt);
    return copyWith(
      totalDebt: newRecord.applyAmountToTotalDebt(intermediateDebt),
    );
  }

  // nickname is intentionally not copyable: it is validated, so changing it must
  // go through [create]. copyWith only adjusts validity-preserving fields.
  Debtor copyWith({
    int? id,
    bool removeId = false,
    Money? totalDebt,
  }) {
    return Debtor._(
      id: removeId ? null : (id ?? this.id),
      nickname: nickname,
      totalDebt: totalDebt ?? this.totalDebt,
    );
  }

  @override
  List<Object?> get props => [id, nickname, totalDebt];
}
