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
  });
}
