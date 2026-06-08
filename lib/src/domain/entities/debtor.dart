import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/failures/debtor_failures.dart';
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

  static Either<DebtorValidationFailure, Debtor> create({
    int? id,
    required String nickname,
    Money totalDebt = const Money(cents: 0),
  }) {
    final failure = NicknameRules.validate(nickname);
    if (failure != null) {
      return Left(DebtorValidationFailure(failure));
    }
    return Right(
      Debtor._(
        id: id,
        nickname: nickname,
        totalDebt: totalDebt,
      ),
    );
  }

  Either<DebtorValidationFailure, Debtor> withMonetaryRecordAdded(
    MonetaryRecord record,
  ) {
    return copyWith(
      totalDebt: record.applyAmountToTotalDebt(totalDebt),
    );
  }

  Either<DebtorValidationFailure, Debtor> withMonetaryRecordRemoved(
    MonetaryRecord removedRecord,
  ) {
    return copyWith(
      totalDebt: removedRecord.revertAmountFromTotalDebt(totalDebt),
    );
  }

  Either<DebtorValidationFailure, Debtor> withMonetaryRecordEdited({
    required MonetaryRecord newRecord,
    required MonetaryRecord oldRecord,
  }) {
    final intermediateDebt = oldRecord.revertAmountFromTotalDebt(totalDebt);
    return copyWith(
      totalDebt: newRecord.applyAmountToTotalDebt(intermediateDebt),
    );
  }

  // copyWith re-validates through [create] so no mutation can produce a broken
  // entity (the always-valid invariant). Returns Either accordingly.
  Either<DebtorValidationFailure, Debtor> copyWith({
    int? id,
    bool removeId = false,
    String? nickname,
    Money? totalDebt,
  }) {
    return create(
      id: removeId ? null : (id ?? this.id),
      nickname: nickname ?? this.nickname,
      totalDebt: totalDebt ?? this.totalDebt,
    );
  }

  @override
  List<Object?> get props => [id, nickname, totalDebt];
}
