import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

void main() {
  const id = 1;
  const debtorId = 2;
  const amountInCents = 12345;
  const description = 'Lunch';
  const date = '2024-01-01T12:00:00.000';
  final oweType = OweType.debt.name;

  final model = OweRecordModel(
    id: id,
    debtorId: debtorId,
    amountInCents: amountInCents,
    description: description,
    date: date,
    oweType: OweType.debt.name,
  );

  group('Equatable props:', () {
    test('When two models have the same props, they should be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: amountInCents,
        description: description,
        date: date,
        oweType: oweType,
      );

      expect(model, equals(second));
    });

    test('When two models have different [id], they should not be equal', () {
      final second = OweRecordModel(
        id: 2,
        debtorId: debtorId,
        amountInCents: amountInCents,
        description: description,
        date: date,
        oweType: oweType,
      );

      expect(model, isNot(equals(second)));
    });

    test('When two models have different [debtorId], they should not be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: 3,
        amountInCents: amountInCents,
        description: description,
        date: date,
        oweType: oweType,
      );

      expect(model, isNot(equals(second)));
    });

    test('When two models have different [amountInCents], they should not be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: 54321,
        description: description,
        date: date,
        oweType: oweType,
      );

      expect(model, isNot(equals(second)));
    });

    test('When two models have different [description], they should not be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: amountInCents,
        description: 'Dinner',
        date: date,
        oweType: oweType,
      );

      expect(model, isNot(equals(second)));
    });

    test('When two models have different [date], they should not be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: amountInCents,
        description: description,
        date: '2024-01-02T12:00:00.000',
        oweType: oweType,
      );

      expect(model, isNot(equals(second)));
    });

    test('When two models have different [oweType], they should not be equal', () {
      final second = OweRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: amountInCents,
        description: description,
        date: date,
        oweType: OweType.credit.name,
      );

      expect(model, isNot(equals(second)));
    });
  });

  group('fromMap tests', () {
    test('should create a valid model from map', () {
      final map = {
        'id': id,
        'debtor_id': debtorId,
        'amount_in_cents': amountInCents,
        'description': description,
        'date': date,
        'owe_type': 'debt',
      };
      final result = OweRecordModel.fromMap(map);
      expect(result, equals(model));
    });
  });

  group('toMap tests', () {
    test('should return a valid map from model', () {
      final expectedMap = {
        'id': id,
        'debtor_id': debtorId,
        'amount_in_cents': amountInCents,
        'description': description,
        'date': date,
        'owe_type': 'debt',
      };
      expect(model.toMap(), equals(expectedMap));
    });
  });
}
