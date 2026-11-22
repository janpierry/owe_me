import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';

void main() {
  group('fromEntity:', () {
    final record = PaymentRecord(
      id: 8,
      amount: RecordAmount.create(const Money(cents: 1000)).asRight(),
      date: DateTime(2025, 1, 10),
      paymentMethod: PaymentMethod.pix,
    );

    test('fills every field from the record', () {
      final draft = PaymentRecordDraft.fromEntity(record);

      expect(draft.amount, const Money(cents: 1000));
      expect(draft.date, DateTime(2025, 1, 10));
      expect(draft.paymentMethod, PaymentMethod.pix);
    });

    test('round-trips through toEntity, except for the id', () {
      final roundTripped = PaymentRecordDraft.fromEntity(record).toEntity();

      expect(roundTripped.asRight(), record.copyWith(removeId: true));
    });
  });
}
