import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';

class MockLoadDebtors extends Mock implements LoadDebtors {}

class MockAddDebtor extends Mock implements AddDebtor {}

void main() {
  late MockAddDebtor addDebtor;
  late HomeDebtorsBloc bloc;

  setUpAll(() {
    registerFallbackValue(Debtor.create(nickname: 'Fallback').asRight());
  });

  setUp(() {
    addDebtor = MockAddDebtor();
    bloc = HomeDebtorsBloc(
      loadDebtors: MockLoadDebtors(),
      addDebtor: addDebtor,
    );
  });

  tearDown(() => bloc.close());

  group('HomeAddDebtorRequested', () {
    // Documents current behavior: the add flow has no field-level error state,
    // so an invalid nickname ends in the generic HomeDebtorsError. The dialog
    // already runs NicknameRules before dispatching, so this is a defensive
    // path.
    test('When the nickname is invalid, it emits HomeDebtorsError and does not save', () async {
      final states = expectLater(
        bloc.stream,
        emitsInOrder([isA<HomeDebtorsLoading>(), isA<HomeDebtorsError>()]),
      );

      bloc.add(HomeAddDebtorRequested(debtorNickname: 'a' * 51));

      await states;
      verifyNever(() => addDebtor(debtor: any(named: 'debtor')));
    });

    test('When the nickname is valid, it saves the debtor and emits HomeDebtorsLoaded with it', () async {
      final newDebtor = Debtor.create(nickname: 'Ana').asRight();
      final savedDebtor = Debtor.create(id: 1, nickname: 'Ana').asRight();
      when(() => addDebtor(debtor: any(named: 'debtor')))
          .thenAnswer((_) async => Right(savedDebtor));

      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<HomeDebtorsLoading>(),
          HomeDebtorsLoaded(debtors: [savedDebtor]),
        ]),
      );

      bloc.add(const HomeAddDebtorRequested(debtorNickname: 'Ana'));

      await states;
      verify(() => addDebtor(debtor: newDebtor)).called(1);
    });
  });
}
