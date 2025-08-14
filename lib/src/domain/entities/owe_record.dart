import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

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
  List<Object?> get props => super.props + [description, oweType];
}
