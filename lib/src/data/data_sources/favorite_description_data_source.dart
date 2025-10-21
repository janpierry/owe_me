import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/models/favorite_description_model.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:sqflite/sqflite.dart';

abstract class FavoriteDescriptionDataSource {
  Future<void> insertFavoriteDescription(
    FavoriteDescriptionModel favoriteDescription,
  );
  Future<List<FavoriteDescriptionModel>> queryFavoriteDebtsByDebtorId(int debtorId);
  Future<List<FavoriteDescriptionModel>> queryFavoriteCreditsByDebtorId(int debtorId);
}

class FavoriteDescriptionDataSourceImpl implements FavoriteDescriptionDataSource {
  final OweMeDatabase _oweMeDatabase;

  FavoriteDescriptionDataSourceImpl({
    required OweMeDatabase oweMeDatabase,
  }) : _oweMeDatabase = oweMeDatabase;

  @override
  Future<void> insertFavoriteDescription(
    FavoriteDescriptionModel favoriteDescription,
  ) async {
    final db = await _oweMeDatabase.database;
    final Map<String, dynamic> descriptionMap = favoriteDescription.toMap();
    await db.insert(
      FavoriteDescriptionModel.table,
      descriptionMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FavoriteDescriptionModel>> queryFavoriteDebtsByDebtorId(
    int debtorId,
  ) async {
    return await _queryFavoriteDescriptionsByDebtorIdAndFavoriteType(
      debtorId,
      OweType.debt,
    );
  }

  @override
  Future<List<FavoriteDescriptionModel>> queryFavoriteCreditsByDebtorId(
    int debtorId,
  ) async {
    return await _queryFavoriteDescriptionsByDebtorIdAndFavoriteType(
      debtorId,
      OweType.credit,
    );
  }

  Future<List<FavoriteDescriptionModel>>
      _queryFavoriteDescriptionsByDebtorIdAndFavoriteType(
    int debtorId,
    OweType favoriteType,
  ) async {
    final db = await _oweMeDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      FavoriteDescriptionModel.table,
      where: 'debtor_id = ? AND favorite_type = ?',
      whereArgs: [debtorId, favoriteType.name],
    );
    return List.generate(maps.length, (i) {
      return FavoriteDescriptionModel.fromMap(maps[i]);
    });
  }
}
