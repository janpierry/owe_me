import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/validation/failures/description_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

void main() {
  final amount = RecordAmount.create(Money(cents: 100)).asRight();
  final date = DateTime(2023);

  OweRecord buildOweRecord({
    int? id = 1,
    String? description = 'Description',
    OweType oweType = OweType.debt,
  }) {
    return OweRecord.create(
      id: id,
      amount: amount,
      date: date,
      description: description,
      oweType: oweType,
    ).asRight();
  }

  group('create validation:', () {
    test('When description is null, it returns an OweRecord', () {
      final result = OweRecord.create(
        id: 1,
        amount: amount,
        date: date,
        description: null,
        oweType: OweType.debt,
      );

      expect(result.asRight(), isA<OweRecord>());
    });

    test(
        'When description exceeds the limit, it returns DescriptionExceedsLimitFailure',
        () {
      final result = OweRecord.create(
        id: 1,
        amount: amount,
        date: date,
        description: 'a' * (DescriptionRules.maxLength + 1),
        oweType: OweType.debt,
      );

      expect(result.asLeft(), isA<DescriptionExceedsLimitFailure>());
    });

    test('When description is within the limit, it returns an OweRecord', () {
      final result = OweRecord.create(
        id: 1,
        amount: amount,
        date: date,
        description: 'Almoço',
        oweType: OweType.debt,
      );

      expect(result.asRight(), isA<OweRecord>());
    });
  });

  group('OweRecord Equatable props:', () {
    final entity = buildOweRecord();

    test('When two OweRecords have the same props, they should be equal', () {
      expect(entity, equals(buildOweRecord()));
    });

    test('When two OweRecords have different [id], they should not be equal',
        () {
      expect(entity, isNot(equals(buildOweRecord(id: 2))));
    });

    test(
        'When two OweRecords have different [amount], they should not be equal',
        () {
      final second = OweRecord.create(
        id: 1,
        amount: RecordAmount.create(Money(cents: 200)).asRight(),
        date: date,
        description: 'Description',
        oweType: OweType.debt,
      ).asRight();

      expect(entity, isNot(equals(second)));
    });

    test('When two OweRecords have different [date], they should not be equal',
        () {
      final second = OweRecord.create(
        id: 1,
        amount: amount,
        date: DateTime(2024),
        description: 'Description',
        oweType: OweType.debt,
      ).asRight();

      expect(entity, isNot(equals(second)));
    });

    test(
        'When two OweRecords have different [description], they should not be equal',
        () {
      expect(entity,
          isNot(equals(buildOweRecord(description: 'Another Description'))));
    });

    test('When two OweRecords have different [type], they should not be equal',
        () {
      expect(entity, isNot(equals(buildOweRecord(oweType: OweType.credit))));
    });
  });
}
