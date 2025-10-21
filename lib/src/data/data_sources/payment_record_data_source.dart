import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';

abstract class PaymentRecordDataSource {
  Future<List<PaymentRecordModel>> queryPaymentRecordsByDebtorId(int debtorId);
}

class PaymentRecordDataSourceImpl implements PaymentRecordDataSource {
  final OweMeDatabase _oweMeDatabase;

  PaymentRecordDataSourceImpl({
    required OweMeDatabase oweMeDatabase,
  }) : _oweMeDatabase = oweMeDatabase;

  @override
  Future<List<PaymentRecordModel>> queryPaymentRecordsByDebtorId(
    int debtorId,
  ) async {
    final db = await _oweMeDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      PaymentRecordModel.table,
      where: 'debtor_id = ?',
      whereArgs: [debtorId],
    );
    return List.generate(maps.length, (i) {
      return PaymentRecordModel.fromMap(maps[i]);
    });
  }
}
