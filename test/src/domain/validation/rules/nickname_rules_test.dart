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
      expect(NicknameRules.validate(nickname), isA<NicknameEmptyFailure>());
    });

    test(
      'When nickname is whitespace-only, it returns NicknameEmptyFailure',
      () {
        expect(NicknameRules.validate('   '), isA<NicknameEmptyFailure>());
      },
    );

    test(
      'When length exceeds the limit, it returns NicknameExceedsLimitFailure',
      () {
        final nickname = 'a' * (NicknameRules.maxLength + 1); // 51
        expect(
          NicknameRules.validate(nickname),
          isA<NicknameExceedsLimitFailure>(),
        );
      },
    );

    // The TextField counter counts visible characters (grapheme clusters), so
    // the rule must too: '🍕' is 1 visible character but 2 UTF-16 code units.
    group('counts visible characters, not UTF-16 code units', () {
      test('When emoji fill exactly the limit, it returns null', () {
        final nickname =
            '🍕' * NicknameRules.maxLength; // 50 visible, 100 units
        expect(NicknameRules.validate(nickname), isNull);
      });

      test(
        'When emoji exceed the limit, it returns NicknameExceedsLimitFailure',
        () {
          final nickname = '🍕' * (NicknameRules.maxLength + 1); // 51 visible
          expect(
            NicknameRules.validate(nickname),
            isA<NicknameExceedsLimitFailure>(),
          );
        },
      );

      test('When a multi-code-point emoji is used, it counts as one', () {
        // 🇧🇷 is two code points (4 UTF-16 code units) but 1 visible character.
        final nickname = 'a' * (NicknameRules.maxLength - 1) + '🇧🇷'; // 50
        expect(NicknameRules.validate(nickname), isNull);
      });
    });
  });
}
