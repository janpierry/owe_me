import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';
import 'package:owe_me/src/domain/validation/rules/favorite_description_rules.dart';

void main() {
  group('FavoriteDescriptionRules.validate', () {
    test('When description is empty, it returns FavoriteDescriptionEmptyFailure',
        () {
      expect(
        FavoriteDescriptionRules.validate(''),
        isA<FavoriteDescriptionEmptyFailure>(),
      );
    });

    test(
        'When description is whitespace-only, it returns FavoriteDescriptionEmptyFailure',
        () {
      expect(
        FavoriteDescriptionRules.validate('   '),
        isA<FavoriteDescriptionEmptyFailure>(),
      );
    });

    test('When length is at the limit, it returns null', () {
      final description = 'a' * DescriptionRules.maxLength; // exactly 100
      expect(FavoriteDescriptionRules.validate(description), isNull);
    });

    test(
        'When length exceeds the limit, it returns FavoriteDescriptionTooLongFailure',
        () {
      final description = 'a' * (DescriptionRules.maxLength + 1); // 101
      expect(
        FavoriteDescriptionRules.validate(description),
        isA<FavoriteDescriptionTooLongFailure>(),
      );
    });

    // The TextField counter counts visible characters (grapheme clusters), so
    // the rule must too: '🍕' is 1 visible character but 2 UTF-16 code units.
    group('counts visible characters, not UTF-16 code units', () {
      test('When letters and emoji fill exactly the limit, it returns null', () {
        final description = 'a' * 90 + '🍕' * 10; // 100 visible, 110 units
        expect(FavoriteDescriptionRules.validate(description), isNull);
      });

      test(
          'When letters and emoji exceed the limit, it returns FavoriteDescriptionTooLongFailure',
          () {
        final description = 'a' * 91 + '🍕' * 10; // 101 visible
        expect(
          FavoriteDescriptionRules.validate(description),
          isA<FavoriteDescriptionTooLongFailure>(),
        );
      });
    });
  });
}
