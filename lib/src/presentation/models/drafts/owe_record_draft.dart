import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/core/presentation/failures.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

class OweRecordDraft {
  final Money? amount;
  final String? description;
  final DateTime? date;
  final OweType oweType;

  OweRecordDraft({
    this.amount,
    this.description,
    this.date,
    required this.oweType,
  });

  OweRecordDraft copyWith({
    Money? amount,
    bool removeAmount = false,
    String? description,
    bool removeDescription = false,
    DateTime? date,
    bool removeDate = false,
    OweType? oweType,
  }) {
    return OweRecordDraft(
      amount: removeAmount ? null : (amount ?? this.amount),
      description: removeDescription ? null : (description ?? this.description),
      date: removeDate ? null : (date ?? this.date),
      oweType: oweType ?? this.oweType,
    );
  }

  Either<InvalidDraftFailure, OweRecord> toEntity() {
    final amount = RecordAmount.create(this.amount ?? Money(cents: 0));
    if (amount.isLeft()) {
      return Left(InvalidDraftFailure('Valor inválido: ${this.amount}'));
    }
    if (date == null) {
      return Left(InvalidDraftFailure('Data é obrigatória'));
    }

    return Right(
      OweRecord(
        id: null, // ID will be assigned when saved in database
        amount: amount.asRight(),
        description: description,
        date: date!,
        oweType: oweType,
      ),
    );
  }
}
