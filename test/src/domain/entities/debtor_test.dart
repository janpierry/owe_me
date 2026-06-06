import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/validation/failures/nickname_validation_failures.dart';
import 'package:owe_me/src/domain/validation/rules/nickname_rules.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';

void main() {
  group('create validation:', () {
    test('When nickname is empty, it returns NicknameEmptyFailure', () {
      final result = Debtor.create(nickname: '');

      expect(result.asLeft(), isA<NicknameEmptyFailure>());
    });

    test('When nickname is whitespace-only, it returns NicknameEmptyFailure', () {
      final result = Debtor.create(nickname: '   ');

      expect(result.asLeft(), isA<NicknameEmptyFailure>());
    });

    test('When nickname exceeds the limit, it returns NicknameExceedsLimitFailure',
        () {
      final result = Debtor.create(nickname: 'a' * (NicknameRules.maxLength + 1));

      expect(result.asLeft(), isA<NicknameExceedsLimitFailure>());
    });

    test('When nickname is valid, it returns a Debtor', () {
      final result = Debtor.create(nickname: 'João');

      expect(result.asRight(), isA<Debtor>());
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
