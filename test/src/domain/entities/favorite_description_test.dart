import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

void main() {
  group('Equatable props:', () {
    const id = 1;
    const description = 'description';
    const favoriteType = OweType.debt;

    const first = FavoriteDescription(
      id: id,
      description: description,
      favoriteType: favoriteType,
    );

    test('When two entities have the same props, they should be equal', () {
      const second = FavoriteDescription(
        id: id,
        description: description,
        favoriteType: favoriteType,
      );

      assert(first == second);
    });

    test('When two entities have different [id], they should not be equal', () {
      const second = FavoriteDescription(
        id: 2,
        description: description,
        favoriteType: favoriteType,
      );

      assert(first != second);
    });

    test('When two entities have different [description], they should not be equal', () {
      const second = FavoriteDescription(
        id: id,
        description: 'another description',
        favoriteType: favoriteType,
      );

      assert(first != second);
    });

    test('When two entities have different [favoriteType], they should not be equal', () {
      const second = FavoriteDescription(
        id: id,
        description: description,
        favoriteType: OweType.credit,
      );

      assert(first != second);
    });
  });
}
