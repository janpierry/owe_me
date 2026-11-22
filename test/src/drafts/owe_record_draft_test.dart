import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

void main() {
  test('Should create an instance with nullable values as null', () {
    final draft = OweRecordDraft(oweType: OweType.debt);
    expect(draft.amount, isNull);
    expect(draft.description, isNull);
    expect(draft.date, isNull);
  });

  group('copyWith tests:', () {
    const amountTest = Money(cents: 100);
    const descriptionTest = 'description';
    final dateTest = DateTime(2000);

    test('Should update [amount]', () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      final updatedDraft = draft.copyWith(amount: amountTest);
      expect(updatedDraft.amount, amountTest);
    });

    test('Should update [description]', () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      final updatedDraft = draft.copyWith(description: descriptionTest);
      expect(updatedDraft.description, descriptionTest);
    });

    test('Should update [date]', () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      final updatedDraft = draft.copyWith(date: dateTest);
      expect(updatedDraft.date, dateTest);
    });

    test('Should update [oweType]', () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      final updatedDraft = draft.copyWith(oweType: OweType.credit);
      expect(updatedDraft.oweType, OweType.credit);
    });

    test('Should keep previous values when not updates', () {
      final draft = OweRecordDraft(
        amount: amountTest,
        description: descriptionTest,
        date: dateTest,
        oweType: OweType.debt,
      );
      final updatedDraft = draft.copyWith();
      expect(updatedDraft.amount, amountTest);
      expect(updatedDraft.description, descriptionTest);
      expect(updatedDraft.date, dateTest);
      expect(updatedDraft.oweType, OweType.debt);
    });

    test('Should update multiple values', () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      final updatedDraft = draft.copyWith(
        amount: amountTest,
        description: descriptionTest,
        date: dateTest,
        oweType: OweType.credit,
      );
      expect(updatedDraft.amount, amountTest);
      expect(updatedDraft.description, descriptionTest);
      expect(updatedDraft.date, dateTest);
      expect(updatedDraft.oweType, OweType.credit);
    });

    test('Should erase [amount] when [eraseAmount] is true', () {
      final draft = OweRecordDraft(amount: amountTest, oweType: OweType.debt);
      final updatedDraft = draft.copyWith(removeAmount: true);
      expect(updatedDraft.amount, isNull);
    });

    test('Should erase [description] when [eraseDescription] is true', () {
      final draft = OweRecordDraft(
        description: descriptionTest,
        oweType: OweType.debt,
      );
      final updatedDraft = draft.copyWith(removeDescription: true);
      expect(updatedDraft.description, isNull);
    });

    test('Should erase [date] when [eraseDate] is true', () {
      final draft = OweRecordDraft(date: dateTest, oweType: OweType.debt);
      final updatedDraft = draft.copyWith(removeDate: true);
      expect(updatedDraft.date, isNull);
    });
  });

  group('fromEntity tests:', () {
    final record = OweRecord.create(
      id: 7,
      amount: RecordAmount.create(const Money(cents: 2500)).asRight(),
      description: 'Almoço',
      date: DateTime(2025, 1, 10),
      oweType: OweType.credit,
    ).asRight();

    test('Should fill every field from the record', () {
      final draft = OweRecordDraft.fromEntity(record);

      expect(draft.amount, const Money(cents: 2500));
      expect(draft.description, 'Almoço');
      expect(draft.date, DateTime(2025, 1, 10));
      expect(draft.oweType, OweType.credit);
    });

    test('Should round-trip through toEntity, except for the id', () {
      final roundTripped = OweRecordDraft.fromEntity(record).toEntity();

      expect(roundTripped.asRight(), record.copyWith(removeId: true).asRight());
    });
  });

  group('toEntity tests:', () {
    test('When the description exceeds the limit, it returns InvalidDraftFailure with the pt-BR message', () {
      final draft = OweRecordDraft(
        amount: const Money(cents: 100),
        description: 'a' * 101, // DescriptionRules.maxLength + 1
        date: DateTime(2000),
        oweType: OweType.debt,
      );

      final result = draft.toEntity();

      expect(
        result.asLeft().message,
        'A descrição não pode ter mais de 100 caracteres.',
      );
    });

    test('When every field is valid, it returns the OweRecord', () {
      final draft = OweRecordDraft(
        amount: const Money(cents: 100),
        description: 'Pizza',
        date: DateTime(2000),
        oweType: OweType.debt,
      );

      final record = draft.toEntity().asRight();

      expect(record.description, 'Pizza');
      expect(record.amount.value, const Money(cents: 100));
    });
  });
}
