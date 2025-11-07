import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

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
}
