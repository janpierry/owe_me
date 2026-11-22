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

  // The draft as it reaches the date step while editing: amount and
  // description already filled in, date not touched yet.
  final draftWithoutDate = OweRecordDraft(
    amount: const Money(cents: 1000),
    description: 'Almoço',
    oweType: OweType.debt,
  );

  setUp(() {
    // "Continuar" pushes the info review container, which pulls its BLoC
    // from get_it.
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

  Future<void> pumpDateStep(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: SetOweRecordDateStepPage(
          oweRecordDraft: draftWithoutDate,
          recordDebtor: debtor,
          oweRecordToEdit: oweRecordToEdit,
          isReviewing: false,
          fromDebtorPage: false,
        ),
      ),
    );
  }

  group('when editing a record and the draft has no date:', () {
    testWidgets('the picker shows the record date', (tester) async {
      await pumpDateStep(tester);

      expect(
        find.descendant(
          of: find.byType(OweMeDatePicker),
          matching: find.text('10/01/2025'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('continuing without changes keeps the record date', (
      tester,
    ) async {
      await pumpDateStep(tester);

      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      final reviewContainer = tester.widget<SetOweRecordInfoReviewContainer>(
        find.byType(SetOweRecordInfoReviewContainer),
      );
      expect(reviewContainer.oweRecordDraft.date, recordDate);
    });
  });
}
