import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';

abstract class OweRecordDataSource {
  Future<List<OweRecordModel>> queryOweRecordsByDebtorId(int debtorId);
}

class OweRecordDataSourceImpl implements OweRecordDataSource {
  final OweMeDatabase _oweMeDatabase;

  OweRecordDataSourceImpl({
    required OweMeDatabase oweMeDatabase,
  }) : _oweMeDatabase = oweMeDatabase;

  @override
  Future<List<OweRecordModel>> queryOweRecordsByDebtorId(int debtorId) async {
    final db = await _oweMeDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      OweRecordModel.table,
      where: 'debtor_id = ?',
      whereArgs: [debtorId],
    );
    return List.generate(maps.length, (i) {
      return OweRecordModel.fromMap(maps[i]);
    });
  }
}
