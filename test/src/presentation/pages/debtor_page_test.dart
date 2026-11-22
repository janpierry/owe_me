import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/core/presentation/formatters/money_formatter.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/containers/home_container.dart';
import 'package:owe_me/src/presentation/pages/debtor_page.dart';
import 'package:owe_me/src/presentation/pages/home_page.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_amount_step_page.dart';
import 'package:owe_me/src/presentation/widgets/debtor_page/debtor_monetary_record_history/debtor_monetary_record_list_item/debtor_monetary_record_list_item.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_amount_text_form_field.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_date_picker.dart';

class MockLoadDebtors extends Mock implements LoadDebtors {}

class MockAddDebtor extends Mock implements AddDebtor {}

class MockLoadDebtorMonetaryRecordHistory extends Mock
    implements LoadDebtorMonetaryRecordHistory {}

class MockEditDebtor extends Mock implements EditDebtor {}

class MockRemoveDebtor extends Mock implements RemoveDebtor {}

class MockRemoveMonetaryRecordAndUpdateDebtor extends Mock
    implements RemoveMonetaryRecordAndUpdateDebtor {}

class MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

void main() {
  final getIt = GetIt.instance;

  final lunchDebt = OweRecord.create(
    id: 7,
    amount: RecordAmount.create(const Money(cents: 2500)).asRight(),
    description: 'Almoço',
    date: DateTime(2025, 1, 10),
    oweType: OweType.debt,
  ).asRight();

  final pixPayment = PaymentRecord(
    id: 8,
    amount: RecordAmount.create(const Money(cents: 1000)).asRight(),
    date: DateTime(2025, 1, 10),
    paymentMethod: PaymentMethod.pix,
  );

  // Stands in for the debtor row in the database: editing overwrites it and
  // loading the debtors reads it back.
  late Debtor storedDebtor;
  // Stands in for the debtor's records in the database.
  late List<MonetaryRecord> storedRecords;
  late MockEditMonetaryRecordAndUpdateDebtor editMonetaryRecord;

  setUpAll(() {
    registerFallbackValue(Debtor.create(nickname: 'Fallback').asRight());
    registerFallbackValue(pixPayment);
  });

  setUp(() {
    storedDebtor = Debtor.create(
      id: 1,
      nickname: 'Ana',
      totalDebt: const Money(cents: 1000),
    ).asRight();
    storedRecords = [];

    final loadDebtors = MockLoadDebtors();
    when(() => loadDebtors()).thenAnswer((_) async => Right([storedDebtor]));

    final editDebtor = MockEditDebtor();
    when(() => editDebtor(debtor: any(named: 'debtor')))
        .thenAnswer((invocation) async {
          storedDebtor = invocation.namedArguments[#debtor] as Debtor;
          return const Right(null);
        });

    final loadHistory = MockLoadDebtorMonetaryRecordHistory();
    when(() => loadHistory(any()))
        .thenAnswer((_) async => Right(storedRecords));

    editMonetaryRecord = MockEditMonetaryRecordAndUpdateDebtor();
    when(
      () => editMonetaryRecord(
        newMonetaryRecord: any(named: 'newMonetaryRecord'),
        oldMonetaryRecord: any(named: 'oldMonetaryRecord'),
        recordDebtor: any(named: 'recordDebtor'),
      ),
    ).thenAnswer((_) async => Right(storedDebtor));

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
      )
      ..registerFactory<SetOweRecordInfoReviewBloc>(
        () => SetOweRecordInfoReviewBloc(
          addMonetaryRecordAndUpdateDebtor:
              MockAddMonetaryRecordAndUpdateDebtor(),
          editMonetaryRecordAndUpdateDebtor: editMonetaryRecord,
        ),
      )
      ..registerFactory<SetPaymentRecordInfoReviewBloc>(
        () => SetPaymentRecordInfoReviewBloc(
          addMonetaryRecordAndUpdateDebtor:
              MockAddMonetaryRecordAndUpdateDebtor(),
          editMonetaryRecordAndUpdateDebtor: editMonetaryRecord,
        ),
      );
  });

  tearDown(() => getIt.reset());

  /// Starts the app on Home and opens Ana's page, the way the user gets there.
  Future<void> openAnasPage(WidgetTester tester) async {
    // The test font draws every glyph 1em wide, so the quick action labels
    // ("Pagamento") wrap and overflow their fixed-height button. They fit on
    // one line with real fonts; shrink the text so layout errors don't drown
    // out these tests.
    tester.platformDispatcher.textScaleFactorTestValue = 0.75;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(const MaterialApp(home: HomeContainer()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ana'));
    await tester.pumpAndSettle();
  }

  /// Opens the menu of the (only) record in the history and picks [option].
  Future<void> chooseRecordMenuOption(
    WidgetTester tester,
    String option,
  ) async {
    await tester.tap(
      find.descendant(
        of: find.byType(DebtorMonetaryRecordListItem),
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(option));
    await tester.pumpAndSettle();
  }

  /// The pencil on the review card row that reads [rowText].
  Finder pencilOfRow(String rowText) => find.descendant(
    of: find.ancestor(of: find.text(rowText), matching: find.byType(Row)).first,
    matching: find.byIcon(Icons.edit),
  );

  String currency(int cents) =>
      MoneyFormatter.toStringCurrency(Money(cents: cents));

  group('Editing the debtor', () {
    testWidgets(
      'When the user renames the debtor and goes back, Home shows the new nickname',
      (tester) async {
        await openAnasPage(tester);

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

  group('Editing a debt', () {
    setUp(() => storedRecords = [lunchDebt]);

    testWidgets(
      'opens on the review with the record, and changing only the date saves '
      'the record with only the date changed',
      (tester) async {
        await openAnasPage(tester);

        await chooseRecordMenuOption(tester, 'Editar débito');

        expect(find.text('Confira as Informações'), findsOneWidget);
        expect(find.text('Ana tem este débito com você'), findsOneWidget);
        expect(find.text('Valor: ${currency(2500)}'), findsOneWidget);
        expect(find.text('Descrição: Almoço'), findsOneWidget);
        expect(find.text('Data: 10/01/2025'), findsOneWidget);

        await tester.tap(pencilOfRow('Data: 10/01/2025'));
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(OweMeDatePicker),
            matching: find.text('10/01/2025'),
          ),
          findsOneWidget,
        );
        await tester.tap(find.byType(OweMeDatePicker));
        await tester.pumpAndSettle();
        await tester.tap(find.text('15'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        expect(find.text('Confira as Informações'), findsOneWidget);
        expect(find.text('Valor: ${currency(2500)}'), findsOneWidget);
        expect(find.text('Descrição: Almoço'), findsOneWidget);
        expect(find.text('Data: 15/01/2025'), findsOneWidget);

        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        final savedRecord = verify(
          () => editMonetaryRecord(
            newMonetaryRecord: captureAny(named: 'newMonetaryRecord'),
            oldMonetaryRecord: any(
              named: 'oldMonetaryRecord',
              that: equals(lunchDebt),
            ),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        ).captured.single;
        expect(
          savedRecord,
          lunchDebt.copyWith(date: DateTime(2025, 1, 15)).asRight(),
        );

        // Same landing as before: the debtor page on top of a fresh Home.
        expect(find.text('Débito atualizado com sucesso.'), findsOneWidget);
        expect(find.byType(DebtorPage), findsOneWidget);
        await tester.pageBack();
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );

    testWidgets(
      'going back from the review without saving returns to the debtor page '
      'and saves nothing',
      (tester) async {
        await openAnasPage(tester);
        await chooseRecordMenuOption(tester, 'Editar débito');

        // Edit a field first, so the review was replaced once on the way.
        await tester.tap(pencilOfRow('Data: 10/01/2025'));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OweMeDatePicker));
        await tester.pumpAndSettle();
        await tester.tap(find.text('15'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        await tester.pageBack();
        await tester.pumpAndSettle();

        expect(find.byType(DebtorPage), findsOneWidget);
        verifyNever(
          () => editMonetaryRecord(
            newMonetaryRecord: any(named: 'newMonetaryRecord'),
            oldMonetaryRecord: any(named: 'oldMonetaryRecord'),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        );
      },
    );
  });

  group('Editing a payment', () {
    setUp(() => storedRecords = [pixPayment]);

    testWidgets(
      'opens on the review with the record, and changing only the amount '
      'saves the record with only the amount changed',
      (tester) async {
        await openAnasPage(tester);

        await chooseRecordMenuOption(tester, 'Editar pagamento');

        expect(find.text('Confira as Informações'), findsOneWidget);
        expect(find.text('Quem te pagou: Ana'), findsOneWidget);
        expect(find.text('Valor: ${currency(1000)}'), findsOneWidget);
        expect(find.text('Método de pagamento: Pix'), findsOneWidget);
        expect(find.text('Data: 10/01/2025'), findsOneWidget);

        await tester.tap(pencilOfRow('Valor: ${currency(1000)}'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(OweMeAmountTextFormField), '5000');
        await tester.pumpAndSettle();
        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        expect(find.text('Confira as Informações'), findsOneWidget);
        expect(find.text('Valor: ${currency(5000)}'), findsOneWidget);
        expect(find.text('Método de pagamento: Pix'), findsOneWidget);
        expect(find.text('Data: 10/01/2025'), findsOneWidget);

        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        final savedRecord = verify(
          () => editMonetaryRecord(
            newMonetaryRecord: captureAny(named: 'newMonetaryRecord'),
            oldMonetaryRecord: any(
              named: 'oldMonetaryRecord',
              that: equals(pixPayment),
            ),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        ).captured.single;
        expect(
          savedRecord,
          pixPayment.copyWith(
            amount: RecordAmount.create(const Money(cents: 5000)).asRight(),
          ),
        );

        // Same landing as before: the debtor page on top of a fresh Home.
        expect(find.text('Pagamento atualizado com sucesso.'), findsOneWidget);
        expect(find.byType(DebtorPage), findsOneWidget);
        await tester.pageBack();
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );

    testWidgets(
      'going back from the review without saving returns to the debtor page '
      'and saves nothing',
      (tester) async {
        await openAnasPage(tester);
        await chooseRecordMenuOption(tester, 'Editar pagamento');

        await tester.pageBack();
        await tester.pumpAndSettle();

        expect(find.byType(DebtorPage), findsOneWidget);
        verifyNever(
          () => editMonetaryRecord(
            newMonetaryRecord: any(named: 'newMonetaryRecord'),
            oldMonetaryRecord: any(named: 'oldMonetaryRecord'),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        );
      },
    );
  });

  group('Creating a debt', () {
    testWidgets('the "Débito" quick action still starts at the amount step', (
      tester,
    ) async {
      await openAnasPage(tester);

      await tester.tap(find.text('Débito'));
      await tester.pumpAndSettle();

      expect(find.byType(SetOweRecordAmountStepPage), findsOneWidget);
      expect(find.text('Informe o Valor'), findsOneWidget);
    });
  });
}
