import 'package:owe_me/src/core/error/exceptions/mapping_exceptions.dart';
import 'package:owe_me/src/data/models/favorite_description_model.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';

class FavoriteDescriptionAdapter {
  const FavoriteDescriptionAdapter._();

  static FavoriteDescriptionModel toModel({
    required FavoriteDescription entity,
    required int debtorId,
  }) {
    return FavoriteDescriptionModel(
      id: entity.id,
      debtorId: debtorId,
      description: entity.description,
      favoriteType: entity.favoriteType.name,
    );
  }

  static FavoriteDescription toEntity(FavoriteDescriptionModel model) {
    final value = FavoriteDescription.create(
      id: model.id,
      description: model.description,
      favoriteType: OweType.values.byName(model.favoriteType),
    );

    return value.getOrElse(() {
      throw DataIntegrityException(
          'Invalid FavoriteDescriptionModel data of id ${model.id}');
    });
  }
}
