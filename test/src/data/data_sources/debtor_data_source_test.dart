import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/data/data_sources/owe_me_data_base.dart';
import 'package:owe_me/src/data/data_sources/debtor_data_source.dart';
import 'package:owe_me/src/data/models/debtor_model.dart';
import 'package:sqflite/sqflite.dart';

class MockOweMeDatabase extends Mock implements OweMeDatabase {}

class MockDatabase extends Mock implements Database {}

void main() {
  late DebtorDataSourceImpl dataSource;
  late MockOweMeDatabase mockOweMeDatabase;
  late MockDatabase mockDatabase;

  setUp(() {
    mockOweMeDatabase = MockOweMeDatabase();
    mockDatabase = MockDatabase();

    dataSource = DebtorDataSourceImpl(oweMeDatabase: mockOweMeDatabase);
    registerFallbackValue(<String, dynamic>{}); // for safety
  });

  group('getAllDebtors', () {
    test('should return a list of DebtorModel when query succeeds', () async {
      // Arrange
      final mockMapList = [
        {'id': 1, 'nickname': 'John', 'total_debt_in_cents': 0},
        {'id': 2, 'nickname': 'Jane', 'total_debt_in_cents': 1000},
      ];

      when(() => mockOweMeDatabase.database).thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.query(DebtorModel.table)).thenAnswer(
        (_) async => mockMapList,
      );

      // Act
      final result = await dataSource.queryAllDebtors();

      // Assert
      expect(result, isA<List<DebtorModel>>());
      expect(result.length, 2);
      expect(result[0], const DebtorModel(id: 1, nickname: 'John', totalDebtInCents: 0));
      expect(
          result[1], const DebtorModel(id: 2, nickname: 'Jane', totalDebtInCents: 1000));

      verify(() => mockOweMeDatabase.database).called(1);
      verify(() => mockDatabase.query(DebtorModel.table)).called(1);
    });

    test('should return an empty list when no records are found', () async {
      when(() => mockOweMeDatabase.database).thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.query(DebtorModel.table)).thenAnswer((_) async => []);

      final result = await dataSource.queryAllDebtors();

      expect(result, isEmpty);
    });

    test('should throw when database throws', () async {
      when(() => mockOweMeDatabase.database).thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.query(DebtorModel.table)).thenThrow(Exception('DB error'));

      expect(() => dataSource.queryAllDebtors(), throwsException);
    });
  });
}
