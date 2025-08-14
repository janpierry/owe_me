import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/entities/money.dart';

abstract class MonetaryRecord extends Equatable {
  final int? id; // Null ID for new records
  final Money amount;
  final DateTime date;

  const MonetaryRecord({
    required this.id,
    required this.amount,
    required this.date,
  });

  Money applyAmountToTotalDebt(Money totalDebt);

  @override
  List<Object?> get props => [id, amount, date];
}
