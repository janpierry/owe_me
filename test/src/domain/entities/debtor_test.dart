import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/failures/debtor_failures.dart';
import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/nickname_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';

void main() {
  group('create validation:', () {
    test('When nickname is empty, it fails with NicknameEmptyFailure as cause',
        () {
      final result = Debtor.create(nickname: '');

      expect(result.asLeft(), isA<DebtorValidationFailure>());
      expect(result.asLeft().cause, isA<NicknameEmptyFailure>());
    });

    test(
        'When nickname is whitespace-only, it fails with NicknameEmptyFailure as cause',
        () {
      final result = Debtor.create(nickname: '   ');

      expect(result.asLeft(), isA<DebtorValidationFailure>());
      expect(result.asLeft().cause, isA<NicknameEmptyFailure>());
    });

    test(
        'When nickname exceeds the limit, it fails with NicknameExceedsLimitFailure as cause',
        () {
      final result = Debtor.create(nickname: 'a' * (NicknameRules.maxLength + 1));

      expect(result.asLeft(), isA<DebtorValidationFailure>());
      expect(result.asLeft().cause, isA<NicknameExceedsLimitFailure>());
    });

    test('When nickname is valid, it returns a Debtor', () {
      final result = Debtor.create(nickname: 'João');

      expect(result.asRight(), isA<Debtor>());
    });
  });

  group('copyWith validation:', () {
    final debtor = Debtor.create(nickname: 'João').asRight();

    test('When the new nickname is invalid, copyWith returns a Left', () {
      final result = debtor.copyWith(nickname: '');

      expect(result.asLeft(), isA<DebtorValidationFailure>());
      expect(result.asLeft().cause, isA<NicknameEmptyFailure>());
    });

    test('When changing only totalDebt, copyWith returns a valid Debtor', () {
      final result = debtor.copyWith(totalDebt: const Money(cents: 500));

      expect(result.asRight().totalDebt, const Money(cents: 500));
    });
  });

  group('Equatable props:', () {
    const debtorId = 1;
    const nickname = 'Nickname';
    const totalDebt = Money(cents: 10000);

    final first = Debtor.create(
      id: debtorId,
      nickname: nickname,
      totalDebt: totalDebt,
    ).asRight();

    test('When two entities have the same props, they should be equal', () {
      final second = Debtor.create(
        id: debtorId,
        nickname: nickname,
        totalDebt: totalDebt,
      ).asRight();

      assert(first == second);
    });

    test('When two entities have different [id], they should not be equal', () {
      final second = Debtor.create(
        id: 2,
        nickname: nickname,
        totalDebt: totalDebt,
      ).asRight();

      assert(first != second);
    });

    test('When two entities have different [nickname], they should not be equal',
        () {
      final second = Debtor.create(
        id: debtorId,
        nickname: 'Another Nickname',
        totalDebt: totalDebt,
      ).asRight();

      assert(first != second);
    });

    test('When two entities have different [totalDebt], they should not be equal',
        () {
      final second = Debtor.create(
        id: debtorId,
        nickname: nickname,
        totalDebt: const Money(cents: 20000),
      ).asRight();

      assert(first != second);
    });
  });
}
