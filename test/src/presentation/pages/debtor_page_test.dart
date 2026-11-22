import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';

class MockLoadDebtors extends Mock implements LoadDebtors {}

class MockAddDebtor extends Mock implements AddDebtor {}

class MockLoadDebtorMonetaryRecordHistory extends Mock
    implements LoadDebtorMonetaryRecordHistory {}

class MockEditDebtor extends Mock implements EditDebtor {}

class MockRemoveDebtor extends Mock implements RemoveDebtor {}

class MockRemoveMonetaryRecordAndUpdateDebtor extends Mock
    implements RemoveMonetaryRecordAndUpdateDebtor {}

void main() {
  final getIt = GetIt.instance;

  // Stands in for the debtor row in the database: editing overwrites it and
  // loading the debtors reads it back.
  late Debtor storedDebtor;

  setUpAll(() {
    registerFallbackValue(Debtor.create(nickname: 'Fallback').asRight());
  });

  setUp(() {
    storedDebtor = Debtor.create(
      id: 1,
      nickname: 'Ana',
      totalDebt: const Money(cents: 1000),
    ).asRight();

    final loadDebtors = MockLoadDebtors();
    when(() => loadDebtors()).thenAnswer((_) async => Right([storedDebtor]));

    final editDebtor = MockEditDebtor();
    when(() => editDebtor(debtor: any(named: 'debtor')))
        .thenAnswer((invocation) async {
          storedDebtor = invocation.namedArguments[#debtor] as Debtor;
          return const Right(null);
        });

    final loadHistory = MockLoadDebtorMonetaryRecordHistory();
    when(() => loadHistory(any())).thenAnswer((_) async => const Right([]));

    getIt
      ..registerFactory<HomeDebtorsBloc>(
        () => HomeDebtorsBloc(
          loadDebtors: loadDebtors,
          addDebtor: MockAddDebtor(),
        ),
      )
      ..registerFactory<DebtorBloc>(
        () => DebtorBloc(
          loadDebtorMonetaryRecordHistory: loadHistory,
          editDebtor: editDebtor,
          removeDebtor: MockRemoveDebtor(),
          removeMonetaryRecordAndUpdateDebtor:
              MockRemoveMonetaryRecordAndUpdateDebtor(),
        ),
      );
  });

  tearDown(() => getIt.reset());

  group('Editing the debtor', () {
    testWidgets(
      'When the user renames the debtor and goes back, Home shows the new nickname',
      (tester) async {
        // The test font draws every glyph 1em wide, so the quick action
        // labels ("Pagamento") wrap and overflow their fixed-height button.
        // They fit on one line with real fonts; shrink the text so layout
        // errors don't drown out this test.
        tester.platformDispatcher.textScaleFactorTestValue = 0.75;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await tester.pumpWidget(const MaterialApp(home: HomeContainer()));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Ana'));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Editar devedor'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField), 'Bia');
        await tester.tap(find.text('Editar'));
        await tester.pumpAndSettle();

        await tester.pageBack();
        await tester.pumpAndSettle();

        expect(find.text('Bia'), findsOneWidget);
        expect(find.text('Ana'), findsNothing);
      },
    );
  });
}
