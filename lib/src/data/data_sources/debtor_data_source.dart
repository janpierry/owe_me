import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DebtorDataSource {
  Future<List<DebtorModel>> queryAllDebtors();
  Future<int> insertDebtor(DebtorModel debtor);
  Future<void> updateDebtor(DebtorModel debtor);
  Future<void> deleteDebtor(int debtorId);
}

class DebtorDataSourceImpl implements DebtorDataSource {
  final OweMeDatabase _oweMeDatabase;

  DebtorDataSourceImpl({
    required OweMeDatabase oweMeDatabase,
  }) : _oweMeDatabase = oweMeDatabase;

  @override
  Future<List<DebtorModel>> queryAllDebtors() async {
    final db = await _oweMeDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(DebtorModel.table);
    return List.generate(maps.length, (i) {
      return DebtorModel.fromMap(maps[i]);
    });
  }

  @override
  Future<int> insertDebtor(DebtorModel debtor) async {
    final db = await _oweMeDatabase.database;
    final Map<String, dynamic> debtorMap = debtor.toMap();
    return await db.insert(
      DebtorModel.table,
      debtorMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateDebtor(DebtorModel debtor) async {
    final db = await _oweMeDatabase.database;
    final Map<String, dynamic> debtorMap = debtor.toMap();
    await db.update(
      DebtorModel.table,
      debtorMap,
      where: 'id = ?',
      whereArgs: [debtor.id],
    );
  }

  @override
  Future<void> deleteDebtor(int debtorId) async {
    final db = await _oweMeDatabase.database;
    await db.delete(
      DebtorModel.table,
      where: 'id = ?',
      whereArgs: [debtorId],
    );
  }
}
