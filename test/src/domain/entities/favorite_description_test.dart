import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';
import 'package:owe_me/src/domain/validation/rules/description_rules.dart';

void main() {
  group('Equatable props:', () {
    const id = 1;
    const description = 'description';
    const favoriteType = OweType.debt;

    final first = FavoriteDescription.create(
      id: id,
      description: description,
      favoriteType: favoriteType,
    ).asRight();

    test('When two entities have the same props, they should be equal', () {
      final second = FavoriteDescription.create(
        id: id,
        description: description,
        favoriteType: favoriteType,
      ).asRight();

      assert(first == second);
    });

    test('When two entities have different [id], they should not be equal', () {
      final second = FavoriteDescription.create(
        id: 2,
        description: description,
        favoriteType: favoriteType,
      ).asRight();

      assert(first != second);
    });

    test(
        'When two entities have different [description], they should not be equal',
        () {
      final second = FavoriteDescription.create(
        id: id,
        description: 'another description',
        favoriteType: favoriteType,
      ).asRight();

      assert(first != second);
    });

    test(
        'When two entities have different [favoriteType], they should not be equal',
        () {
      final second = FavoriteDescription.create(
        id: id,
        description: description,
        favoriteType: OweType.credit,
      ).asRight();

      assert(first != second);
    });
  });

  group('create validation:', () {
    test(
        'When description is empty, it returns FavoriteDescriptionEmptyFailure',
        () {
      final result = FavoriteDescription.create(
        description: '',
        favoriteType: OweType.debt,
      );

      expect(result.asLeft(), isA<FavoriteDescriptionEmptyFailure>());
    });

    test(
        'When description is whitespace-only, it returns FavoriteDescriptionEmptyFailure',
        () {
      final result = FavoriteDescription.create(
        description: '   ',
        favoriteType: OweType.debt,
      );

      expect(result.asLeft(), isA<FavoriteDescriptionEmptyFailure>());
    });

    test(
        'When description exceeds the limit, it returns FavoriteDescriptionTooLongFailure',
        () {
      final result = FavoriteDescription.create(
        description: 'a' * (DescriptionRules.maxLength + 1),
        favoriteType: OweType.debt,
      );

      expect(result.asLeft(), isA<FavoriteDescriptionTooLongFailure>());
    });

    test('When description is valid, it returns a FavoriteDescription', () {
      final result = FavoriteDescription.create(
        description: 'Almoço',
        favoriteType: OweType.debt,
      );

      expect(result.asRight(), isA<FavoriteDescription>());
    });
  });
}
