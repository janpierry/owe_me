import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/failures/owe_record_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

part 'owe_record.dart';
part 'payment_record.dart';

sealed class MonetaryRecord extends Equatable {
  final int? id; // Null ID for new records
  final RecordAmount amount;
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
