import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

void main() {
  group('OweRecord Equatable props:', () {
    const id = 1;
    const amount = Money(cents: 100);
    final date = DateTime(2023);
    const description = 'Description';

    final entity = OweRecord(
      id: id,
      amount: amount,
      date: date,
      description: description,
      oweType: OweType.debt,
    );

    test('When two OweRecords have the same props, they should be equal', () {
      final second = OweRecord(
        id: id,
        amount: amount,
        date: date,
        description: description,
        oweType: OweType.debt,
      );

      expect(entity, equals(second));
    });

    test('When two OweRecords have different [id], they should not be equal', () {
      final second = OweRecord(
        id: 2,
        amount: amount,
        date: date,
        description: description,
        oweType: OweType.debt,
      );

      expect(entity, isNot(equals(second)));
    });

    test('When two OweRecords have different [amount], they should not be equal', () {
      final second = OweRecord(
        id: id,
        amount: const Money(cents: 200),
        date: date,
        description: description,
        oweType: OweType.debt,
      );

      expect(entity, isNot(equals(second)));
    });

    test('When two OweRecords have different [date], they should not be equal', () {
      final second = OweRecord(
        id: id,
        amount: amount,
        date: DateTime(2024),
        description: description,
        oweType: OweType.debt,
      );

      expect(entity, isNot(equals(second)));
    });

    test('When two OweRecords have different [description], they should not be equal',
        () {
      final second = OweRecord(
        id: id,
        amount: amount,
        date: date,
        description: 'Another Description',
        oweType: OweType.debt,
      );

      expect(entity, isNot(equals(second)));
    });

    test('When two OweRecords have different [type], they should not be equal', () {
      final second = OweRecord(
        id: id,
        amount: amount,
        date: date,
        description: 'Another Description',
        oweType: OweType.credit,
      );

      expect(entity, isNot(equals(second)));
    });
  });
}
