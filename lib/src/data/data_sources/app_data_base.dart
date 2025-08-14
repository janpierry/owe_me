import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:owe_me/src/data/models/favorite_description_model.dart';
import 'package:owe_me/src/data/models/owe_record_model.dart';
import 'package:owe_me/src/data/models/payment_record_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._internal();

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'owe_me.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DebtorModel.table} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nickname TEXT NOT NULL,
        total_debt_in_cents INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE ${OweRecordModel.table} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        debtor_id INTEGER NOT NULL,
        amount_in_cents INTEGER NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        owe_type INTEGER NOT NULL,
        FOREIGN KEY (debtor_id) REFERENCES debtors(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE ${PaymentRecordModel.table} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        debtor_id INTEGER NOT NULL,
        amount_in_cents INTEGER NOT NULL,
        date TEXT NOT NULL,
        payment_type TEXT NOT NULL,
        FOREIGN KEY (debtor_id) REFERENCES debtors(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE ${FavoriteDescriptionModel.table} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        debtor_id INTEGER NOT NULL,
        description TEXT NOT NULL,
        favorite_type TEXT NOT NULL,
        FOREIGN KEY (debtor_id) REFERENCES debtors(id) ON DELETE CASCADE
      );
    ''');
  }

  Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future closeDatabase() async {
    if (_db == null) return;

    final dbClient = await database;
    dbClient.close();
    _db = null;
  }
}
