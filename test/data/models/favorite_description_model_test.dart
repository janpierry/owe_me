import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/data/models/favorite_description_model.dart';

void main() {
  group('FavoriteDescriptionModel', () {
    const id = 1;
    const debtorId = 2;
    const description = 'Fort';
    const favoriteType = 'debt';

    const model = FavoriteDescriptionModel(
      id: id,
      debtorId: debtorId,
      description: description,
      favoriteType: favoriteType,
    );

    test('should support value equality', () {
      const identicalModel = FavoriteDescriptionModel(
        id: id,
        debtorId: debtorId,
        description: description,
        favoriteType: favoriteType,
      );

      expect(model, equals(identicalModel));
    });

    test('fromMap should return valid model', () {
      final map = {
        'id': id,
        'debtor_id': debtorId,
        'description': description,
        'favorite_type': favoriteType,
      };

      final result = FavoriteDescriptionModel.fromMap(map);

      expect(result.id, equals(id));
      expect(result.debtorId, equals(debtorId));
      expect(result.description, equals(description));
      expect(result.favoriteType, equals(favoriteType));
    });

    test('toMap should return correct map', () {
      final map = model.toMap();

      expect(map['id'], equals(id));
      expect(map['debtor_id'], equals(debtorId));
      expect(map['description'], equals(description));
      expect(map['favorite_type'], equals(favoriteType));
    });

    test('toMap should include null id when id is null', () {
      const modelWithoutId = FavoriteDescriptionModel(
        id: null,
        debtorId: debtorId,
        description: description,
        favoriteType: favoriteType,
      );

      final map = modelWithoutId.toMap();

      expect(map['id'], isNull);
      expect(map['debtor_id'], equals(debtorId));
    });
  });
}
