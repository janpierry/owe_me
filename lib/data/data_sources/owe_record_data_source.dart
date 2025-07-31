import 'package:owe_me/data/data_sources/app_data_base.dart';
import 'package:owe_me/data/models/owe_record_model.dart';

abstract class OweRecordDataSource {
  Future<List<OweRecordModel>> queryOweRecordsByDebtorId(int debtorId);
}

class OweRecordDataSourceImpl implements OweRecordDataSource {
  final AppDatabase _appDatabase;

  OweRecordDataSourceImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<List<OweRecordModel>> queryOweRecordsByDebtorId(int debtorId) async {
    final db = await _appDatabase.database;
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
