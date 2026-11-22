import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_info_review_container.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_date_step_page.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_date_picker.dart';

class MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

void main() {
  final recordDate = DateTime(2025, 1, 10);

  final debtor = Debtor.create(
    id: 1,
    nickname: 'Ana',
    totalDebt: const Money(cents: 1000),
  ).asRight();

  final oweRecordToEdit = OweRecord.create(
    id: 1,
    amount: RecordAmount.create(const Money(cents: 1000)).asRight(),
    description: 'Almoço',
    date: recordDate,
    oweType: OweType.debt,
  ).asRight();

  setUp(() {
    // "Salvar alterações" pushes the info review container, which pulls its
    // BLoC from get_it.
    GetIt.instance.registerFactory<SetOweRecordInfoReviewBloc>(
      () => SetOweRecordInfoReviewBloc(
        addMonetaryRecordAndUpdateDebtor:
            MockAddMonetaryRecordAndUpdateDebtor(),
        editMonetaryRecordAndUpdateDebtor:
            MockEditMonetaryRecordAndUpdateDebtor(),
      ),
    );
  });

  tearDown(() => GetIt.instance.reset());

  /// Opens the date step the way the review's date pencil does: on top of the
  /// review it will replace, with the draft built from the record.
  Future<void> openFromReview(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('Página do devedor'))),
    );
    tester.state<NavigatorState>(find.byType(Navigator))
      ..push(
        MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('Revisão anterior')),
        ),
      )
      ..push(
        MaterialPageRoute<void>(
          builder: (_) => SetOweRecordDateStepPage(
            oweRecordDraft: OweRecordDraft.fromEntity(oweRecordToEdit),
            recordDebtor: debtor,
            oweRecordToEdit: oweRecordToEdit,
            isReviewing: true,
            fromDebtorPage: true,
          ),
        ),
      );
    await tester.pumpAndSettle();
  }

  group('when editing a record from the review:', () {
    testWidgets('the picker shows the record date', (tester) async {
      await openFromReview(tester);

      expect(
        find.descendant(
          of: find.byType(OweMeDatePicker),
          matching: find.text('10/01/2025'),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'saving without changes keeps the record date and replaces the review',
      (tester) async {
        await openFromReview(tester);

        await tester.tap(find.text('Salvar alterações'));
        await tester.pumpAndSettle();

        final reviewContainer = tester.widget<SetOweRecordInfoReviewContainer>(
          find.byType(SetOweRecordInfoReviewContainer),
        );
        expect(reviewContainer.oweRecordDraft.date, recordDate);
        expect(
          find.text('Revisão anterior', skipOffstage: false),
          findsNothing,
        );
      },
    );
  });
}
