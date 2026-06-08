part of 'monetary_record.dart';

class OweRecord extends MonetaryRecord {
  final String? description;
  final OweType oweType;

  const OweRecord._({
    required super.id,
    required super.amount,
    required super.date,
    required this.description,
    required this.oweType,
  });

  static Either<OweRecordValidationFailure, OweRecord> create({
    required int? id,
    required RecordAmount amount,
    required DateTime date,
    required String? description,
    required OweType oweType,
  }) {
    if (description != null) {
      final failure = DescriptionRules.validate(description);
      if (failure != null) {
        return Left(OweRecordValidationFailure(failure));
      }
    }
    return Right(
      OweRecord._(
        id: id,
        amount: amount,
        date: date,
        description: description,
        oweType: oweType,
      ),
    );
  }

  @override
  Money applyAmountToTotalDebt(Money totalDebt) {
    return switch (oweType) {
      OweType.debt => totalDebt + amount.value,
      OweType.credit => totalDebt - amount.value,
    };
  }

  @override
  Money revertAmountFromTotalDebt(Money totalDebt) {
    return switch (oweType) {
      OweType.debt => totalDebt - amount.value,
      OweType.credit => totalDebt + amount.value,
    };
  }

  // copyWith re-validates through [create] so no mutation can produce a broken
  // entity (the always-valid invariant). Returns Either accordingly.
  Either<OweRecordValidationFailure, OweRecord> copyWith({
    int? id,
    bool removeId = false,
    RecordAmount? amount,
    String? description,
    bool removeDescription = false,
    DateTime? date,
    OweType? oweType,
  }) {
    return create(
      id: removeId ? null : (id ?? this.id),
      amount: amount ?? this.amount,
      description: removeDescription ? null : (description ?? this.description),
      date: date ?? this.date,
      oweType: oweType ?? this.oweType,
    );
  }

  @override
  List<Object?> get props => super.props + [description, oweType];
}
