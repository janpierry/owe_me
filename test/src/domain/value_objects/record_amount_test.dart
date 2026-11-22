import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

void main() {
  RecordAmount buildAmount(int cents) =>
      RecordAmount.create(Money(cents: cents)).asRight();

  group('Equatable props:', () {
    test(
      'When two RecordAmounts have the same value, they should be equal',
      () {
        expect(buildAmount(111), equals(buildAmount(111)));
      },
    );

    test(
      'When two RecordAmounts have different values, they should not be equal',
      () {
        expect(buildAmount(111), isNot(equals(buildAmount(121))));
      },
    );

    test(
      'When two RecordAmounts are equal, they should have the same hashCode',
      () {
        expect(buildAmount(111).hashCode, buildAmount(111).hashCode);
      },
    );
  });
}
