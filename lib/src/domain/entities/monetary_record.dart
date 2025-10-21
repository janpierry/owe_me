import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';

part 'owe_record.dart';
part 'payment_record.dart';

sealed class MonetaryRecord extends Equatable {
  final int? id; // Null ID for new records
  final Money amount;
  final DateTime date;

  const MonetaryRecord({
    required this.id,
    required this.amount,
    required this.date,
  });

  Money applyAmountToTotalDebt(Money totalDebt);

  Money revertAmountFromTotalDebt(Money totalDebt);

  @override
  List<Object?> get props => [id, amount, date];
}
