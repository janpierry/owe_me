import 'package:owe_me/src/data/data_sources/app_data_base.dart';
import 'package:owe_me/src/data/data_sources/owe_record_data_source.dart';
import 'package:owe_me/src/data/data_sources/payment_record_data_source.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class MonetaryRecordDataSource {
  Future<void> insertMonetaryRecordAndUpdateDebtorTotalDebt(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  );
  Future<List<MonetaryRecordModel>> queryMonetaryRecordsByDebtorId(int debtorId);
}

class MonetaryRecordDataSourceImpl implements MonetaryRecordDataSource {
  final AppDatabase _appDatabase;
  final OweRecordDataSource _oweRecordDataSource;
  final PaymentRecordDataSource _paymentRecordDataSource;

  MonetaryRecordDataSourceImpl({
    required AppDatabase appDatabase,
    required OweRecordDataSource oweRecordDataSource,
    required PaymentRecordDataSource paymentRecordDataSource,
  })  : _appDatabase = appDatabase,
        _oweRecordDataSource = oweRecordDataSource,
        _paymentRecordDataSource = paymentRecordDataSource;

  @override
  Future<void> insertMonetaryRecordAndUpdateDebtorTotalDebt(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  ) async {
    final db = await _appDatabase.database;

    await db.transaction((txn) async {
      final dataMap = monetaryRecordModel.toMap();

      // Remove 'id' so SQLite can autoincrement if it's null
      dataMap.remove('id');

      // Insert owe record
      await txn.insert(
        monetaryRecordModel.tableName,
        dataMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Update the debtor's total debt
      await txn.update(
        DebtorModel.table,
        {'total_debt_in_cents': debtorTotalDebtInCents},
        where: 'id = ?',
        whereArgs: [monetaryRecordModel.debtorId],
      );
    });
  }

  @override
  Future<List<MonetaryRecordModel>> queryMonetaryRecordsByDebtorId(int debtorId) async {
    final oweRecordModels =
        await _oweRecordDataSource.queryOweRecordsByDebtorId(debtorId);
    final paymentRecordModels =
        await _paymentRecordDataSource.queryPaymentRecordsByDebtorId(debtorId);
    //TODO Open/Closed Principle problem - Handle future problem, what if there are more types of monetary records?

    final List<MonetaryRecordModel> monetaryRecordsModels = [
      ...oweRecordModels,
      ...paymentRecordModels
    ];
    return monetaryRecordsModels;
  }
}
