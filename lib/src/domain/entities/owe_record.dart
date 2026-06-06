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

  static Either<DescriptionValidationFailure, OweRecord> create({
    required int? id,
    required RecordAmount amount,
    required DateTime date,
    required String? description,
    required OweType oweType,
  }) {
    if (description != null) {
      final failure = DescriptionRules.validate(description);
      if (failure != null) {
        return Left(failure);
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

  // description is intentionally not copyable: it is validated, so changing it
  // must go through [create]. copyWith only adjusts validity-preserving fields.
  OweRecord copyWith({
    int? id,
    bool removeId = false,
    RecordAmount? amount,
    DateTime? date,
    OweType? oweType,
  }) {
    return OweRecord._(
      id: removeId ? null : (id ?? this.id),
      amount: amount ?? this.amount,
      description: description,
      date: date ?? this.date,
      oweType: oweType ?? this.oweType,
    );
  }

  @override
  List<Object?> get props => super.props + [description, oweType];
}
