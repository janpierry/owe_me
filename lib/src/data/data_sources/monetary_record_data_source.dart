import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/data_sources/owe_record_data_source.dart';
import 'package:owe_me/src/data/data_sources/payment_record_data_source.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class MonetaryRecordDataSource {
  Future<void> insertMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  );
  Future<void> updateMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  );
  Future<void> deleteMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  );
  Future<List<MonetaryRecordModel>> queryMonetaryRecordsByDebtorId(int debtorId);
}

class MonetaryRecordDataSourceImpl implements MonetaryRecordDataSource {
  final OweMeDatabase _oweMeDatabase;
  final OweRecordDataSource _oweRecordDataSource;
  final PaymentRecordDataSource _paymentRecordDataSource;

  MonetaryRecordDataSourceImpl({
    required OweMeDatabase oweMeDatabase,
    required OweRecordDataSource oweRecordDataSource,
    required PaymentRecordDataSource paymentRecordDataSource,
  })  : _oweMeDatabase = oweMeDatabase,
        _oweRecordDataSource = oweRecordDataSource,
        _paymentRecordDataSource = paymentRecordDataSource;

  @override
  Future<void> insertMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  ) async {
    final db = await _oweMeDatabase.database;

    await db.transaction((txn) async {
      final dataMap = monetaryRecordModel.toMap();

      // Remove 'id' so SQLite can autoincrement if it's null
      dataMap.remove('id');

      // Insert monetary record
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
  Future<void> updateMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  ) async {
    final db = await _oweMeDatabase.database;

    await db.transaction(
      (txn) async {
        final dataMap = monetaryRecordModel.toMap();

        // Update monetary record
        await txn.update(
          monetaryRecordModel.tableName,
          dataMap,
          where: 'id = ?',
          whereArgs: [monetaryRecordModel.id],
        );

        // Update the debtor's total debt
        await txn.update(
          DebtorModel.table,
          {'total_debt_in_cents': debtorTotalDebtInCents},
          where: 'id = ?',
          whereArgs: [monetaryRecordModel.debtorId],
        );
      },
    );
  }

  @override
  Future<void> deleteMonetaryRecordAndUpdateDebtor(
    MonetaryRecordModel monetaryRecordModel,
    int debtorTotalDebtInCents,
  ) async {
    final db = await _oweMeDatabase.database;

    await db.transaction((txn) async {
      // Remove monetary record
      await txn.delete(
        monetaryRecordModel.tableName,
        where: 'id = ?',
        whereArgs: [monetaryRecordModel.id],
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
