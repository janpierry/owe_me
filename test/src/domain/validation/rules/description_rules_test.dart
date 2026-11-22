import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/validation/failures/description_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';

void main() {
  group('DescriptionRules.validate', () {
    test('When length is at the limit, it returns null', () {
      final description = 'a' * DescriptionRules.maxLength; // exactly 100
      expect(DescriptionRules.validate(description), isNull);
    });

    test(
        'When length exceeds the limit, it returns DescriptionExceedsLimitFailure',
        () {
      final description = 'a' * (DescriptionRules.maxLength + 1); // 101
      expect(
        DescriptionRules.validate(description),
        isA<DescriptionExceedsLimitFailure>(),
      );
    });

    // The TextField counter counts visible characters (grapheme clusters), so
    // the rule must too: '🍕' is 1 visible character but 2 UTF-16 code units.
    group('counts visible characters, not UTF-16 code units', () {
      test('When 84 letters and 10 emoji are used (94 visible), it returns null',
          () {
        final description = 'a' * 84 + '🍕' * 10; // 94 visible, 104 units
        expect(DescriptionRules.validate(description), isNull);
      });

      test('When letters and emoji fill exactly the limit, it returns null', () {
        final description = 'a' * 90 + '🍕' * 10; // 100 visible, 110 units
        expect(DescriptionRules.validate(description), isNull);
      });

      test(
          'When letters and emoji exceed the limit, it returns DescriptionExceedsLimitFailure',
          () {
        final description = 'a' * 91 + '🍕' * 10; // 101 visible
        expect(
          DescriptionRules.validate(description),
          isA<DescriptionExceedsLimitFailure>(),
        );
      });
    });
  });
}
