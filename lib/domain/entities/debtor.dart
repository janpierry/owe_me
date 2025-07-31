import 'package:equatable/equatable.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/entities/money.dart';

class Debtor extends Equatable {
  final int? id; // Null ID for new records
  final String name;
  final Money totalDebt;

  const Debtor({
    this.id,
    required this.name,
    this.totalDebt = const Money(cents: 0),
  });

  Debtor updateTotalDebtWithMonetaryRecord(MonetaryRecord record) {
    return copyWith(
      totalDebt: record.applyAmountToTotalDebt(totalDebt),
    );
  }

  Debtor copyWith({
    int? id,
    String? name,
    Money? totalDebt,
  }) {
    return Debtor(
      id: id ?? this.id,
      name: name ?? this.name,
      totalDebt: totalDebt ?? this.totalDebt,
    );
  }

  @override
  List<Object?> get props => [id, name, totalDebt];
}
