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
    bool eraseAmount = false,
    String? description,
    bool eraseDescription = false,
    DateTime? date,
    bool eraseDate = false,
    OweType? oweType,
  }) {
    return OweRecordDraft(
      amount: eraseAmount ? null : amount ?? this.amount,
      description: eraseDescription ? null : description ?? this.description,
      date: eraseDate ? null : date ?? this.date,
      oweType: oweType ?? this.oweType,
    );
  }
}
