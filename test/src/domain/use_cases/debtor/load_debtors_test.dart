import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/repositories/debtor_repository.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';

class MockDebtorRepository extends Mock implements DebtorRepository {}

void main() {
  late MockDebtorRepository mockRepository;
  late LoadDebtors usecase;

  setUp(() {
    mockRepository = MockDebtorRepository();
    usecase = LoadDebtors(repository: mockRepository);
  });

  group('LoadDebtors UseCase', () {
    test('should return a list of debtors when repository returns data', () async {
      // arrange
      final tDebtors = [
        const Debtor(
          id: 1,
          nickname: 'Nickname',
          totalDebt: Money(cents: 1000),
        )
      ];

      when(() => mockRepository.loadAllDebtors())
          .thenAnswer((_) async => Right(tDebtors));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tDebtors));
      verify(() => mockRepository.loadAllDebtors()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return an exception when repository fails', () async {
      // arrange
      const failure = DefaultFailure('Failed to load');

      when(() => mockRepository.loadAllDebtors())
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase();

      // assert
      expect(result, const Left(failure));
      verify(() => mockRepository.loadAllDebtors()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should not call repository multiple times for a single invocation', () async {
      // arrange
      when(() => mockRepository.loadAllDebtors())
          .thenAnswer((_) async => const Right([]));

      // act
      await usecase();

      // assert
      verify(() => mockRepository.loadAllDebtors()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
