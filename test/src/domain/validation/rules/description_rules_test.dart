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
  });
}
