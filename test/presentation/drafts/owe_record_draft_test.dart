import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/domain/entities/money.dart';
import 'package:owe_me/domain/enums/owe_type.dart';

void main() {
  test(
    'Should create an instance with nullable values as null',
    () {
      final draft = OweRecordDraft(oweType: OweType.debt);
      expect(draft.amount, isNull);
      expect(draft.description, isNull);
      expect(draft.date, isNull);
    },
  );

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
      final draft = OweRecordDraft(
        amount: amountTest,
        oweType: OweType.debt,
      );
      final updatedDraft = draft.copyWith(eraseAmount: true);
      expect(updatedDraft.amount, isNull);
    });

    test('Should erase [description] when [eraseDescription] is true', () {
      final draft = OweRecordDraft(
        description: descriptionTest,
        oweType: OweType.debt,
      );
      final updatedDraft = draft.copyWith(eraseDescription: true);
      expect(updatedDraft.description, isNull);
    });

    test('Should erase [date] when [eraseDate] is true', () {
      final draft = OweRecordDraft(
        date: dateTest,
        oweType: OweType.debt,
      );
      final updatedDraft = draft.copyWith(eraseDate: true);
      expect(updatedDraft.date, isNull);
    });
  });
}
