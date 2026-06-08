import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/nickname_rules.dart';

void main() {
  group('NicknameRules.validate', () {
    test('When length is at the limit, it returns null', () {
      final nickname = 'a' * NicknameRules.maxLength; // exactly 50
      expect(NicknameRules.validate(nickname), isNull);
    });

    test('When length is empty, it returns NicknameEmptyFailure', () {
      final nickname = '';
      expect(
        NicknameRules.validate(nickname),
        isA<NicknameEmptyFailure>(),
      );
    });

    test('When nickname is whitespace-only, it returns NicknameEmptyFailure',
        () {
      expect(NicknameRules.validate('   '), isA<NicknameEmptyFailure>());
    });

    test(
        'When length exceeds the limit, it returns NicknameExceedsLimitFailure',
        () {
      final nickname = 'a' * (NicknameRules.maxLength + 1); // 51
      expect(
        NicknameRules.validate(nickname),
        isA<NicknameExceedsLimitFailure>(),
      );
    });
  });
}
