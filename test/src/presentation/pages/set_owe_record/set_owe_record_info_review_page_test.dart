import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_owe_record/set_owe_record_info_review_page.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class _MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class _MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

void main() {
  const screen = Size(390, 844);

  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();
  final draft = OweRecordDraft(
    amount: const Money(cents: 5000),
    date: DateTime(2026, 1, 15),
    oweType: OweType.debt,
  );

  Future<void> pumpPage(WidgetTester tester, MediaQueryData mediaQuery) async {
    tester.view
      ..physicalSize = screen
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: mediaQuery.copyWith(size: screen),
        child: MaterialApp(
          home: BlocProvider(
            create: (_) =>
                SetOweRecordInfoReviewBloc(
                  addMonetaryRecordAndUpdateDebtor:
                      _MockAddMonetaryRecordAndUpdateDebtor(),
                  editMonetaryRecordAndUpdateDebtor:
                      _MockEditMonetaryRecordAndUpdateDebtor(),
                )..add(
                  SetOweRecordInfoReviewPageInitialized(
                    oweRecordDraft: draft,
                    recordDebtor: debtor,
                    oweRecordToEdit: null,
                  ),
                ),
            child: SetOweRecordInfoReviewPage(
              oweRecordDraft: draft,
              recordDebtor: debtor,
              oweRecordToEdit: null,
              fromDebtorPage: false,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  double confirmButtonBottom(WidgetTester tester) => tester
      .getBottomLeft(find.widgetWithText(OweMeElevatedButton, 'Confirmar'))
      .dy;

  group('the "Confirmar" button', () {
    testWidgets('sits above the iPhone home indicator', (tester) async {
      await pumpPage(
        tester,
        const MediaQueryData(
          padding: EdgeInsets.only(bottom: 34),
          viewPadding: EdgeInsets.only(bottom: 34),
        ),
      );

      expect(confirmButtonBottom(tester), lessThanOrEqualTo(844 - 34 - 16));
    });

    testWidgets('sits right above the keyboard, with no home-indicator gap', (
      tester,
    ) async {
      await pumpPage(
        tester,
        const MediaQueryData(
          viewInsets: EdgeInsets.only(bottom: 300),
          viewPadding: EdgeInsets.only(bottom: 34),
        ),
      );

      expect(confirmButtonBottom(tester), 844 - 300 - 16);
    });
  });
}
