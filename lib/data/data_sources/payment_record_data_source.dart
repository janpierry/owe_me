import 'package:owe_me/data/data_sources/app_data_base.dart';
import 'package:owe_me/data/models/payment_record_model.dart';

abstract class PaymentRecordDataSource {
  Future<List<PaymentRecordModel>> queryPaymentRecordsByDebtorId(int debtorId);
}

class PaymentRecordDataSourceImpl implements PaymentRecordDataSource {
  final AppDatabase _appDatabase;

  PaymentRecordDataSourceImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<List<PaymentRecordModel>> queryPaymentRecordsByDebtorId(
    int debtorId,
  ) async {
    final db = await _appDatabase.database;
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
