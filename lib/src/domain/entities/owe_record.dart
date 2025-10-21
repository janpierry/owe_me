part of 'monetary_record.dart';

class OweRecord extends MonetaryRecord {
  final String? description;
  final OweType oweType;

  const OweRecord({
    required super.id,
    required super.amount,
    required super.date,
    required this.description,
    required this.oweType,
  });

  @override
  Money applyAmountToTotalDebt(Money totalDebt) {
    return switch (oweType) {
      OweType.debt => totalDebt + amount,
      OweType.credit => totalDebt - amount,
    };
  }

  @override
  Money revertAmountFromTotalDebt(Money totalDebt) {
    return switch (oweType) {
      OweType.debt => totalDebt - amount,
      OweType.credit => totalDebt + amount,
    };
  }

  MonetaryRecord copyWith({
    int? id,
    Money? amount,
    String? description,
    bool eraseDescription = false,
    DateTime? date,
    OweType? oweType,
  }) {
    return OweRecord(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: eraseDescription ? null : (description ?? this.description),
      date: date ?? this.date,
      oweType: oweType ?? this.oweType,
    );
  }

  @override
  List<Object?> get props => super.props + [description, oweType];
}
