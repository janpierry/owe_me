import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';

class MockLoadDebtorMonetaryRecordHistory extends Mock
    implements LoadDebtorMonetaryRecordHistory {}

class MockEditDebtor extends Mock implements EditDebtor {}

class MockRemoveDebtor extends Mock implements RemoveDebtor {}

class MockRemoveMonetaryRecordAndUpdateDebtor extends Mock
    implements RemoveMonetaryRecordAndUpdateDebtor {}

void main() {
  late MockLoadDebtorMonetaryRecordHistory loadHistory;
  late MockEditDebtor editDebtor;
  late DebtorBloc bloc;

  final debtor = Debtor.create(
    id: 1,
    nickname: 'Ana',
    totalDebt: const Money(cents: 1000),
  ).asRight();

  setUpAll(() {
    registerFallbackValue(debtor);
  });

  setUp(() async {
    loadHistory = MockLoadDebtorMonetaryRecordHistory();
    editDebtor = MockEditDebtor();
    when(() => loadHistory(any())).thenAnswer((_) async => const Right([]));

    bloc = DebtorBloc(
      loadDebtorMonetaryRecordHistory: loadHistory,
      editDebtor: editDebtor,
      removeDebtor: MockRemoveDebtor(),
      removeMonetaryRecordAndUpdateDebtor:
          MockRemoveMonetaryRecordAndUpdateDebtor(),
    );

    // Editing works on the debtor the page loaded, so load it first and wait
    // for the history load it triggers to settle.
    final pageReady = expectLater(
      bloc.stream,
      emitsThrough(isA<DebtorMonetaryRecordHistoryEmpty>()),
    );
    bloc.add(DebtorPageInitialized(debtor: debtor));
    await pageReady;
  });

  tearDown(() => bloc.close());

  group('DebtorEditRequested', () {
    test(
        'When the nickname is too long, it emits DebtorEditError with the pt-BR message and does not save',
        () async {
      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DebtorEditInProgress>(),
          const DebtorEditError(
            message: 'O apelido não pode ter mais de 50 caracteres.',
          ),
        ]),
      );

      bloc.add(DebtorEditRequested(nickname: 'a' * 51));

      await states;
      verifyNever(() => editDebtor(debtor: any(named: 'debtor')));
    });

    test(
        'When the nickname is blank, it emits DebtorEditError with the pt-BR message and does not save',
        () async {
      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DebtorEditInProgress>(),
          const DebtorEditError(message: 'Apelido é obrigatório.'),
        ]),
      );

      bloc.add(const DebtorEditRequested(nickname: '   '));

      await states;
      verifyNever(() => editDebtor(debtor: any(named: 'debtor')));
    });

    test(
        'When the nickname is valid, it saves the edited debtor, reloads it and emits DebtorEditSuccess with it',
        () async {
      final editedDebtor = Debtor.create(
        id: 1,
        nickname: 'Ana Maria',
        totalDebt: const Money(cents: 1000),
      ).asRight();
      when(() => editDebtor(debtor: any(named: 'debtor')))
          .thenAnswer((_) async => const Right(null));

      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DebtorEditInProgress>(),
          const DebtorPageLoading(),
          DebtorPageLoaded(debtor: editedDebtor),
          // The page rebuilds Home and itself from this debtor, so Home
          // shows the new nickname (#26).
          DebtorEditSuccess(updatedDebtor: editedDebtor),
        ]),
      );

      bloc.add(const DebtorEditRequested(nickname: 'Ana Maria'));

      await states;
      verify(() => editDebtor(debtor: editedDebtor)).called(1);
    });
  });
}
