import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';

class Debtor extends Equatable {
  final int? id; // Null ID for new records
  final String nickname;
  final Money totalDebt;

  const Debtor({
    this.id,
    required this.nickname,
    this.totalDebt = const Money(cents: 0),
  });

  Debtor withMonetaryRecordAdded(MonetaryRecord record) {
    return copyWith(
      totalDebt: record.applyAmountToTotalDebt(totalDebt),
    );
  }

  Debtor withMonetaryRecordRemoved(MonetaryRecord removedRecord) {
    return copyWith(
      totalDebt: removedRecord.revertAmountFromTotalDebt(totalDebt),
    );
  }

  Debtor withMonetaryRecordEdited({
    required MonetaryRecord newRecord,
    required MonetaryRecord oldRecord,
  }) {
    final intermediateDebt = oldRecord.revertAmountFromTotalDebt(totalDebt);
    return copyWith(
      totalDebt: newRecord.applyAmountToTotalDebt(intermediateDebt),
    );
  }

  Debtor copyWith({
    int? id,
    bool removeId = false,
    String? nickname,
    Money? totalDebt,
  }) {
    return Debtor(
      id: removeId ? null : (id ?? this.id),
      nickname: nickname ?? this.nickname,
      totalDebt: totalDebt ?? this.totalDebt,
    );
  }

  @override
  List<Object?> get props => [id, nickname, totalDebt];
}
